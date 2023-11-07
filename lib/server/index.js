const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Game = require('./models/game');
const getSentence = require("./api/getSentence");
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require("socket.io")(server)

app.use(express.json());


//listening to socket io  events from the client
io.on("connection",(socket)=>{
    console.log(socket.id);

    socket.on('create-game' , async({nickname})=>{
        try{
        let game = new Game();
        const sentence = await getSentence();
        game.words = sentence;
        let player = {
            socketID: socket.id,
            nickname,
            isPartyLeader: true,
        };
        game.players.push(player);
        game = await game.save();

        const gameId = game._id.toString();
        socket.join(gameId);

        io.to(gameId).emit('updateGame' , game);
        }
        catch(e){
            console.log(e);
        }
    });

    socket.on('join-game' , async({nickname , gameId})=>{
        try{
            if(!gameId.match(/^[0-9a-fA-F]{24}$/)){
                socket.emit('notCorrectGame' , "Please enter a valid game ID");
                return;
            }
            let game = await Game.findById({gameId});

            if(game.isJoin){
                const id = game._id.toString();
                let player = {
                    nickname,
                    socketID  : socket.id,
                }
                socket.join(id);
                game.players.push(player);
                game = await game.save();
                io.to(gameId).emit('updateGame' , game); 
            } else{
                socket.emit('notCorrectGame' , "The game is in progress, please try again later!");
            }
        }
        catch(e){
            console.log(e); 
        }
    })

});


const DB = process.env.DB_URL;

mongoose.connect(DB).then(()=>{
    console.log('Connection Successful!');
}).catch((e) =>{
    console.error(e);
})

server.listen(port , "0.0.0.0" ,()=>{
     console.log("Server running on port " + port);
});

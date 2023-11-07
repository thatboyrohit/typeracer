import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:type_racer/providers/game_state_provider.dart';
import 'package:type_racer/screens/create_room_screen.dart';
import 'package:type_racer/screens/game_screen.dart';
import 'package:type_racer/screens/home_screen.dart';
import 'package:type_racer/screens/join_room.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameStateProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/create-room': (context) => const CreateRoom(),
          '/join-room': (context) => const JoinRoom(),
          '/game-screen': (context) => const GameScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:type_racer/utils/socket_methods.dart';
import 'package:type_racer/widgets/custom_buttons.dart';
import 'package:type_racer/widgets/custom_textfiel.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateGameListener(context);
    _socketMethods.notCorrectGameListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Join Room',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Enter your nickname',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    controller: _gameIdController,
                    hintText: 'Enter Game ID',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    text: 'Join',
                    onTap: () => _socketMethods.joinGame(
                      _gameIdController.text,
                      _nameController.text,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

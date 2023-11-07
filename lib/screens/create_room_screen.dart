import 'package:flutter/material.dart';
import 'package:type_racer/utils/socket_methods.dart';
import 'package:type_racer/widgets/custom_buttons.dart';
import 'package:type_racer/widgets/custom_textfiel.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController _nameController = TextEditingController();
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
                    'Create Room',
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
                  CustomButton(
                    text: 'Create',
                    onTap: () =>
                        _socketMethods.createGame(_nameController.text),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

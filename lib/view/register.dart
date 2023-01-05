import 'package:chat_getx/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Name"),
            controller: Get.find<AuthController>().name,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Email"),
            controller: Get.find<AuthController>().email,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Password"),
            controller: Get.find<AuthController>().password,
          ),
          ElevatedButton(
              onPressed: () {
                Get.find<AuthController>().signUp();
              },
              child: const Text('SignUp'))
        ],
      ),
    );
  }
}

import 'package:chat_getx/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: Get.find<AuthController>().name,
          ),
          TextField(
            controller: Get.find<AuthController>().email,
          ),
          TextField(
            controller: Get.find<AuthController>().password,
          ),
          ElevatedButton(
              onPressed: () {
                Get.find<AuthController>().login();
              },
              child: const Text('Login'))
        ],
      ),
    );
  }
}

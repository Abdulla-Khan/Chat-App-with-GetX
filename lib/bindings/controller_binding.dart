import 'package:chat_getx/controller/auth_controller.dart';
import 'package:chat_getx/controller/chat_controller.dart';
import 'package:chat_getx/controller/home_controller.dart';
import 'package:get/get.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ChatController());
  }
}

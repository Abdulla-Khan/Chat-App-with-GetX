import 'package:chat_getx/controller/home_controller.dart';
import 'package:chat_getx/view/chat_screen.dart';
import 'package:chat_getx/view/chat_tiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Users'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => ChatTile());
              },
              icon: Icon(Icons.message))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            width: size.width,
            height: size.width * 0.2,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
            child: StreamBuilder(
                stream: Get.find<HomeController>().todoStream(),
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: Get.find<HomeController>().todos.length,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          return ListTile(
                            title: Text(
                              Get.find<HomeController>().todos[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              Get.find<HomeController>().todos[index].email,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.message),
                              onPressed: () =>
                                  Get.to(() => ChatScreen(), arguments: [
                                Get.find<HomeController>().todos[0].uid,
                                Get.find<HomeController>().todos[0].name
                              ]),
                            ),
                          );
                        });
                      });
                }),
          ),
        ],
      ),
    );
  }
}

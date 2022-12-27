import 'package:chat_getx/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<List<UserModel>> todoList = Rx<List<UserModel>>([]);
  List<UserModel> get todos => todoList.value;
  var name = 'Loading'.obs;
  var email = 'Loading'.obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  onReady() {
    todoList.bindStream(todoStream());
  }

  Stream<List<UserModel>> todoStream() {
    return firebaseFirestore
        .collection('users')
        .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> todos = [];
      for (var todo in query.docs) {
        final todoModel = UserModel.fromDocumentSnapshot(todo);
        name.value = todoModel.name;
        email.value = todoModel.email;
        todos.add(todoModel);
      }
      // log('2');
      // print(todos);
      return todos;
    });
  }

  on(a) async {
    late bool doesExist;

    final doc = await FirebaseFirestore.instance
        .collection('chats')
        .doc(a + '&' + FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .get()
        .then((doc) {
      doesExist = doc.docs.isNotEmpty;
      print(a + '&' + FirebaseAuth.instance.currentUser!.uid);
    });
    print(doesExist);
  }
}

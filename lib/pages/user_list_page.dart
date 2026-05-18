import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_crud_6sic4/controllers/user_controller.dart';

class UserListPage extends StatelessWidget {
  UserListPage({super.key});

  final userC = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data User (CRUD GetX + API)'),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () {
          if (userC.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: userC.users.length,
            itemBuilder: (context, index) {
              final user = userC.users[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    child: Text(user.name[0]),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            buttonColor: Colors.red,
                            confirmTextColor: Colors.white,
                            title: "Hapus User",
                            middleText: "Yakin hapus data user ${user.name}?",
                            textCancel: "Gak, jadi.",
                            textConfirm: "Iya, hapus!",
                            onConfirm: () {
                              userC.deleteUser(user.id);
                              Get.back();
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

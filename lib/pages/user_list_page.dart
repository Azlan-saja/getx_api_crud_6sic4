import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_crud_6sic4/controllers/user_controller.dart';
import 'package:getx_api_crud_6sic4/pages/user_add_page.dart';
import 'package:getx_api_crud_6sic4/pages/user_edit_page.dart';

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
        onPressed: () {
          Get.to(() => UserAddPage());
        },
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
                color: const Color.fromARGB(255, 232, 247, 245),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    child: Badge(
                      alignment: AlignmentGeometry.xy(-3, 0.7),
                      backgroundColor: Colors.white,
                      textColor: Colors.red.shade900,
                      label: Text((index + 1).toString()),
                      child: Text(
                        user.name[0],
                      ),
                    ),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => UserEditPage(
                                user: user,
                              ));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            buttonColor: Colors.red,
                            confirmTextColor: Colors.white,
                            title: "Hapus User",
                            middleText: "Yakin hapus data user ${user.name}?",
                            textCancel: "Gak jadi.",
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

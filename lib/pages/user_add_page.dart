import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_crud_6sic4/controllers/user_controller.dart';

class UserAddPage extends StatelessWidget {
  UserAddPage({super.key});

  final userCtrl = Get.find<UserController>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Nama',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                userCtrl.addUser(nameCtrl.text, emailCtrl.text);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

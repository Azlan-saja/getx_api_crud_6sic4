import 'package:get/get.dart';
import 'package:getx_api_crud_6sic4/models/user_model.dart';
import 'package:getx_api_crud_6sic4/services/api_service.dart';

class UserController extends GetxController {
  // Ngapain?
  final service = ApiService();
  var users = <UserModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  // 1. Menampilkan semua data user - GET
  void fetchUsers() async {
    isLoading(true);
    final data = await service.getUsers();
    users.assignAll(data);
    isLoading(false);
  }

  // 2. Menambahkan data user baru - POST
  void addUser(String name, String email) async {
    final data = await service.createUser(name, email);
    if (data != null) {
      users.add(data);
      Get.back();
      Get.snackbar('Tambah User', 'Berhasil tambah user baru.');
    } else {
      Get.snackbar('Tambah User', 'Gagal tambah data user.');
    }
  }

  // 3. Mengubah data user - PUT/PATCH
  void editUser(int id, String name, String email) async {
    final isSuccess = await service.updateUser(id, name, email);
    if (isSuccess || id > 10) {
      int index = users.indexWhere((element) => element.id == id);
      users[index] = UserModel(id: id, name: name, email: email);
      users.refresh();
      Get.back();
      Get.snackbar('Edit User', 'Berhasil mengubah data user.');
    } else {
      Get.snackbar('Edit User', 'Gagal mengubah data user.');
    }
  }

  // 4. Menghapus data user - DELETE
  void deleteUser(int id) async {
    final isSuccess = await service.deleteUser(id);
    if (isSuccess) {
      users.removeWhere((element) => element.id == id);
      Get.snackbar('Hapus User', 'Berhasil menghapus data user.');
    } else {
      Get.snackbar('Hapus User', 'Gagal menghapus data user.');
    }
  }
}

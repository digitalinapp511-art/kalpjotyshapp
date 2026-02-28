import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {

  final box = GetStorage();
  final ImagePicker picker = ImagePicker();

  var name = "".obs;
  var email = "".obs;
  var imagePath = "".obs;

  @override
  void onInit() {
    name.value = box.read("name") ?? "Ravi Sharma";
    email.value = box.read("email") ?? "ravi@gmail.com";
    imagePath.value = box.read("image") ?? "";
    super.onInit();
  }

  Future<void> pickImage() async {
    final XFile? picked =
    await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      imagePath.value = picked.path;
      box.write("image", picked.path);
    }
  }

  void saveProfile(String newName, String newEmail) {
    name.value = newName;
    email.value = newEmail;

    box.write("name", newName);
    box.write("email", newEmail);
  }
}
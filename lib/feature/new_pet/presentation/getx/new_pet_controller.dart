import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';

class NewPetController extends GetxController {
  // File _imageFile;
  // final picker = ImagePicker();
  Rx<XFile> petImage = XFile('').obs;

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      petImage.value = pickedFile;
    }
  }
}

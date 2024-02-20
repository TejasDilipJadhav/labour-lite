import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageHandling {
  late File _image;
  late String url;

  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  File getImage() {
    return _image;
  }

  String getUrl() {
    return url;
  }
}

import 'package:image_picker/image_picker.dart';

// Method to pick image from the gallery
Future<XFile?> pickImageFromGallery(ImagePicker picker) async {
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return pickedFile;
  } else {
    return null;
  }
}

// Method to capture image from the camera
Future<XFile?> captureImageFromCamera(ImagePicker picker) async {
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    return pickedFile;
  } else {
    return null;
  }
}

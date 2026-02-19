// lib/stub_image_picker.dart
class XFile {
  final String path;
  XFile(this.path);
}

class ImagePicker {
  const ImagePicker();
  Future<XFile?> pickImage({required dynamic source}) async {
    throw UnsupportedError("ImagePicker is not supported on Web. Use FilePicker instead.");
  }
}

class ImageSource {
  static const gallery = 'gallery';
}
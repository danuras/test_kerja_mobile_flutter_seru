import 'package:file_picker/file_picker.dart';

/// class untuk mengpick gambar
class PickImage {
  static Future<FilePickerResult?> pickImage() async {
    return await FilePicker.platform.pickFiles(
        allowedExtensions: ['jpg', 'png', 'jpeg'], type: FileType.custom);
  }
}

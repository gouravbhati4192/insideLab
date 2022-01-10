import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:financial_freedom/old/widgets/common/StringConstants.dart';

class CameraFile {
  ///get image(PickedFile)  or file from Camera or fileExplorer
  static Future<File> getFile(String type) async {
    final imagePicker = ImagePicker.platform;
    final filePicker = FilePicker.platform;
    File file;
    switch (type) {
      case StringConstants.camera:
        var pickedfile = await imagePicker.pickImage(source: ImageSource.camera);
        file = File(pickedfile.path);
        break;

      case StringConstants.file:
        file = File((await filePicker.pickFiles(type: FileType.any)).files[0].path);
        break;

      case StringConstants.gallery:
        var pickedfile = await imagePicker.pickImage(source: ImageSource.gallery);
        file = File(pickedfile.path);
        break;
    }

    return file;
  }
}

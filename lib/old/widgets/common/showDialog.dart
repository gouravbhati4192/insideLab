import 'dart:io';

import 'package:financial_freedom/old/widgets/common/StringConstants.dart';
import 'package:financial_freedom/old/widgets/common/camera_gallery_file.dart';
import 'package:flutter/material.dart';

class ShowDialogBox {
  ///method to get dialog box for selection of image from camera or gallery
  File selectedFile;
  Future showSelectionDialog(BuildContext context) {
    var _style = TextStyle(fontSize: 10, color: Colors.blue);

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  title: IconButton(
                    icon: Icon(
                      Icons.camera,
                      color: Colors.blue,
                      size: 40,
                    ),
                    onPressed: () async {
                      selectedFile =
                          await CameraFile.getFile(StringConstants.camera);

                      Navigator.pop(context);
                    },
                  ),
                  subtitle: Text(
                    'Add from Camera',
                    style: _style,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  title: IconButton(
                    icon: Icon(
                      Icons.folder,
                      color: Colors.blue,
                      size: 40,
                    ),
                    onPressed: () async {
                      selectedFile =
                          await CameraFile.getFile(StringConstants.file);
                      Navigator.pop(context);
                    },
                  ),
                  subtitle: Text(
                    'Pick from Files',
                    style: _style,
                  ),
                ),
              ),
            ],
          ));
        });
  }
}

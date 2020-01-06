import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;

class ImageTaskCustom extends StatefulWidget {
  final Function onTap;

  ImageTaskCustom({this.onTap});
  @override
  _ImageTaskCustomState createState() => _ImageTaskCustomState();
}

class _ImageTaskCustomState extends State<ImageTaskCustom> {
  File selectedImage;
  Future takeImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      return;
    }
    selectedImage = imageFile;
    final appDir = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImage = await imageFile.copy("${appDir.path}/$fileName");
    widget.onTap(saveImage);
  }

  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: mqHeight / 5,
      bottom: mqHeight / 17,
      left: mqWidth / 3.5,
      right: mqWidth / 3.5,
      child: InkResponse(
        onTap: takeImage,
        child: Container(
          decoration: BoxDecoration(
            image: selectedImage == null
                ? null
                : DecorationImage(
                    image: FileImage(selectedImage), fit: BoxFit.cover),
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.5), blurRadius: 5)
            ],
            color: Theme.of(context).primaryColor,
          ),
          child: selectedImage == null
              ? Icon(
                  Icons.camera,
                  size: mqHeight / 10,
                  color: Colors.white,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}

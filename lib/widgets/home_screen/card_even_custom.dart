import 'dart:io';

import 'package:app_provider/app_provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:network/models/task_model.dart';
import 'package:provider/provider.dart';
import 'package:voice_task_app/widgets/dialog_confirm_delete.dart';
import 'package:voice_task_app/widgets/home_screen/modalbottomsheet_updateicon_custom.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;

class CardEvenCustom extends StatefulWidget {
  final String idTask;
  final String titleTask;
  final String imagePath;
  final DateTime dateCreate;
  final int codeIcon;
  CardEvenCustom({
    this.idTask,
    this.titleTask,
    this.imagePath,
    this.dateCreate,
    this.codeIcon,
  });

  @override
  _CardEvenCustomState createState() => _CardEvenCustomState();
}

class _CardEvenCustomState extends State<CardEvenCustom> {
  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat.yMMMMEEEEd().format(widget.dateCreate);
    final taskProvider = Provider.of<TaskProvider>(context);
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
      setState(() {
        selectedImage = saveImage;
      });
      taskProvider.updateTask(
        keyTask: widget.idTask,
        taskModel: TaskModel()
          ..idTask = widget.idTask
          ..titleTask = widget.titleTask
          ..imageTask = selectedImage.path
          ..dateCreate = widget.dateCreate
          ..codeIcon = widget.codeIcon,
      );
    }

    return InkResponse(
      onLongPress: () => showDialog(
        context: context,
        child: DialogConfirmDelete(
            title: widget.titleTask,
            onPressed: () {
              taskProvider.deleteTask(keyTask: widget.idTask);
              Navigator.of(context).pop(true);
            }),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            bottomLeft: Radius.circular(80),
          ),
        ),
        elevation: 4,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: InkResponse(
                onTap: takeImage,
                child: Container(
                  height: mqHeight / 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      topLeft: Radius.circular(80),
                    ),
                    image: widget.imagePath == null
                        ? DecorationImage(
                            image: AssetImage("assets/images/empty.png"),
                            fit: BoxFit.fill)
                        : DecorationImage(
                            image: FileImage(File(widget.imagePath)),
                            fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 8,
              fit: FlexFit.tight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 8),
                      child: Text(
                        dateFormat,
                        style: textTheme.overline,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.titleTask,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: textTheme.subtitle
                                  .copyWith(letterSpacing: 1.5),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: InkResponse(
                            onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (ctxBtmSheet) =>
                                  ModalBottomSheetUpdateIconCustom(
                                idTask: widget.idTask,
                                titleTask: widget.titleTask,
                                imagePath: widget.imagePath,
                                dateCreate: widget.dateCreate,
                                codeIcon: widget.codeIcon,
                              ),
                            ),
                            child: widget.codeIcon == -1
                                ? CircleAvatar(
                                    radius: mqHeight / 18,
                                    child: FittedBox(
                                      child: Text('Add Icon'),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: mqHeight / 18,
                                    child: Icon(
                                      IconData(widget.codeIcon,
                                          fontFamily: "MaterialIcons"),
                                      size: mqWidth / 6,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

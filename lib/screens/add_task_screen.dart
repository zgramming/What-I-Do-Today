import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_provider/app_provider/task_provider.dart';

import 'package:network/models/task_model.dart';
import 'package:voice_task_app/widgets/add_task_screen/category_icon_custom.dart';

import 'package:voice_task_app/widgets/add_task_screen/image_task_custom.dart';
import 'package:voice_task_app/widgets/diagonal_clipper.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = "add-task";

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKeys = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  int selectedList = -1;
  int codeIcon = -1;
  File _pickedImage;
  void _selectedCodeIcon(int _pickedCodeIcon) {
    setState(() => codeIcon = _pickedCodeIcon);
  }

  void _selectedImage(File pickedImage) {
    setState(() => _pickedImage = pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              final form = formKeys.currentState.validate();
              var now = DateTime.now().toString();

              if (form && codeIcon != -1 && _pickedImage != null) {
                taskProvider.addTask(
                  keyTask: now,
                  taskModel: TaskModel()
                    ..idTask = now
                    ..titleTask = _titleController.text
                    ..imageTask = _pickedImage.path
                    ..dateCreate = DateTime.now()
                    ..codeIcon = codeIcon,
                );
                Navigator.of(context).pop(true);
              } else {
                BotToast.showText(
                    text: "Form Not Completly",
                    contentColor: Theme.of(context).errorColor);
                return;
              }
            },
          )
        ],
      ),
      body: Form(
        key: formKeys,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: mqHeight / 2,
                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: DiagonalClipper(),
                      child: Container(
                        height: mqHeight / 2.5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    ImageTaskCustom(onTap: _selectedImage)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Enter Title Task",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Provided Title ";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Pick Category',
                      style: textTheme.subhead
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    CategoryIconCustom(onTap: _selectedCodeIcon),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

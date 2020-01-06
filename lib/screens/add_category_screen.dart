import 'package:app_provider/app_provider/category_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:network/models/category_model.dart';
import 'package:provider/provider.dart';

import '../widgets/diagonal_clipper.dart';

class AddCategoryScreen extends StatefulWidget {
  static const routeName = "add-category";

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final formKeys = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  int iconCode = 0;

  void _pickIcon() async {
    final openIconPicker =
        await FlutterIconPicker.showIconPicker(context, iconSize: 40);
    if (openIconPicker == null) {
      return;
    }
    print(openIconPicker.codePoint);
    setState(() {
      iconCode = openIconPicker.codePoint;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              final form = formKeys.currentState.validate();
              if (form) {
                categoryProvider.addCategory(
                  categoryModel: CategoryModel()
                    ..idCategory = DateTime.now()
                    ..titleCategory = _titleController.text
                    ..codeCategory = iconCode,
                );
                Navigator.of(context).pop(true);
              } else {
                BotToast.showText(
                    text: "Form Not Completely",
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
                    Positioned(
                      top: mqHeight / 10,
                      bottom: 0,
                      left: mqWidth / 3.5,
                      right: mqWidth / 3.5,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.5),
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: _pickIcon,
                          child: CircleAvatar(
                            radius: mqHeight / 8,
                            child: (iconCode == 0)
                                ? Text('Pick Icon')
                                : Icon(
                                    IconData(
                                      iconCode,
                                      fontFamily: "MaterialIcons",
                                    ),
                                    size: mqHeight / 8,
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Enter Your Title Icon",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Provided Title Category";
                    } else if (value.trim().isEmpty) {
                      return "Can't Insert only Spaces";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app_provider/app_provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network/models/category_model.dart';
import 'package:network/models/task_model.dart';
import 'package:provider/provider.dart';

class ModalBottomSheetUpdateIconCustom extends StatefulWidget {
  final String idTask;
  final String titleTask;
  final String imagePath;
  final DateTime dateCreate;
  final int codeIcon;
  final int indexTask;
  ModalBottomSheetUpdateIconCustom({
    this.idTask,
    this.codeIcon,
    this.titleTask,
    this.imagePath,
    this.dateCreate,
    this.indexTask,
  });
  @override
  _ModalBottomSheetUpdateIconCustomState createState() =>
      _ModalBottomSheetUpdateIconCustomState();
}

class _ModalBottomSheetUpdateIconCustomState
    extends State<ModalBottomSheetUpdateIconCustom> {
  int selectedList = -1;
  int selectedIcon = 0;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final mqWidth = MediaQuery.of(context).size.width;

    final taskProvider = Provider.of<TaskProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: WatchBoxBuilder(
        box: Hive.box("category_box"),
        builder: (ctx, categoryBox) {
          if (categoryBox.isEmpty) {
            return Column(
              children: <Widget>[
                Text(
                  'Category Empty , Add Some',
                  style: textTheme.title.copyWith(
                    color: theme.brightness == Brightness.light
                        ? Colors.black.withOpacity(.5)
                        : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Image.asset("assets/images/empty.png"),
              ],
            );
          } else {
            final categoryList =
                categoryBox.values.toList().cast<CategoryModel>();
            return GridView.builder(
              shrinkWrap: true,
              itemCount: categoryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (ctxGrid, index) {
                final categoryValue = categoryList[index];
                return InkResponse(
                  onTap: () {
                    setState(() {
                      selectedList = index;
                      selectedIcon = categoryValue.codeCategory;
                    });
                    print("$selectedList & ${widget.indexTask}");
                    taskProvider.updateTask(
                        keyTask: widget.idTask,
                        taskModel: TaskModel()
                          ..idTask = widget.idTask
                          ..titleTask = widget.titleTask
                          ..imageTask = widget.imagePath
                          ..dateCreate = widget.dateCreate
                          ..codeIcon = selectedIcon);
                  },
                  child: SizedBox(
                    child: Card(
                      color: theme.brightness == Brightness.light
                          ? null
                          : Color(0xFFe23e57),
                      shape: selectedList == index
                          ? RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            )
                          : null,
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            IconData(
                              categoryValue.codeCategory,
                              fontFamily: "MaterialIcons",
                            ),
                            size: mqWidth / 8,
                            color: theme.brightness == Brightness.light
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          FittedBox(
                            child: Text(
                              categoryValue.titleCategory,
                              style: textTheme.subtitle.copyWith(
                                color: theme.brightness == Brightness.light
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

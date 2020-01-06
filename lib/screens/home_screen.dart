import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:network/models/category_model.dart';
import 'package:network/models/task_model.dart';

import 'package:voice_task_app/widgets/home_screen/card_even_custom.dart';
import 'package:voice_task_app/widgets/home_screen/card_odd_custom.dart';
import 'package:voice_task_app/widgets/home_screen/fab_voice_custom.dart';
import 'package:voice_task_app/widgets/home_screen/modalbottomsheet_settings_custom.dart';
import 'package:voice_task_app/widgets/home_screen/stack_appbar_custom.dart';
import 'package:voice_task_app/widgets/home_screen/stack_category_custom.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: CircleAvatar(
            radius: mqHeight / 30,
            backgroundImage: AssetImage("assets/images/icon-app.png"),
          ),
          actions: <Widget>[
            WatchBoxBuilder(
              box: Hive.box("language_box"),
              builder: (ctx, box) {
                var languageVoice = box.get("isEngland", defaultValue: true);
                return Switch(
                  value: languageVoice,
                  onChanged: (value) {
                    box.put('isEngland', value);
                    print(languageVoice.toString());
                  },
                  inactiveThumbImage:
                      AssetImage("assets/images/indonesia-flag.png"),
                  activeThumbImage:
                      AssetImage("assets/images/england-flag.png"),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (ctxModalBottomSheet) =>
                    ModalBottomSheetSettingsCustom(),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              WatchBoxBuilder(
                box: Hive.box('category_box'),
                builder: (ctxBox, box) {
                  if (box.isEmpty) {
                    return StackAppBarCustom(
                      categoryContent: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Empty',
                          style: textTheme.display1.copyWith(
                            color: Colors.white,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    );
                  } else {
                    final categoryList =
                        box.values.toList().cast<CategoryModel>();
                    return StackAppBarCustom(
                      categoryContent: Container(
                        height: mqHeight / 6,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final categoryValue = categoryList[index];
                            return StackCategoryCustom(
                              idCategory: categoryValue.idCategory,
                              titleCategory: categoryValue.titleCategory,
                              codeCategory: categoryValue.codeCategory,
                              indexBox: index,
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
              WatchBoxBuilder(
                box: Hive.box("task_box"),
                builder: (ctx, box) {
                  if (box.isEmpty) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: mqHeight / 8,
                        horizontal: 8,
                      ),
                      height: mqHeight / 3.5,
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: const AssetImage("assets/images/empty.png"),
                        ),
                      ),
                      child: Text(
                        'Task Empty , Add Someone',
                        style: textTheme.title
                            .copyWith(color: Colors.black.withOpacity(.5)),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    final taskList = box.values.toList().cast<TaskModel>();
                    taskList
                        .sort((a, b) => -a.dateCreate.compareTo(b.dateCreate));
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: mqHeight / 8,
                        horizontal: 8,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: taskList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final taskValue = taskList[index];
                          if (index.isOdd) {
                            return CardOddCustom(
                              idTask: taskValue.idTask,
                              codeIcon: taskValue.codeIcon,
                              titleTask: taskValue.titleTask,
                              imagePath: taskValue.imageTask,
                              dateCreate: taskValue.dateCreate,
                            );
                          } else {
                            return CardEvenCustom(
                              idTask: taskValue.idTask,
                              codeIcon: taskValue.codeIcon,
                              titleTask: taskValue.titleTask,
                              imagePath: taskValue.imageTask,
                              dateCreate: taskValue.dateCreate,
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
        floatingActionButton: FabVoiceCustom(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

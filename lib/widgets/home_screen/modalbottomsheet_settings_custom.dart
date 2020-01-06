import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:voice_task_app/screens/add_category_screen.dart';
import 'package:voice_task_app/screens/add_task_screen.dart';
import 'package:voice_task_app/widgets/home_screen/card_settings_custom.dart';

class ModalBottomSheetSettingsCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            WatchBoxBuilder(
              box: Hive.box("darkmode_box"),
              builder: (ctx, box) {
                var darkMode = box.get("darkMode", defaultValue: false);
                return CardSettingsCustom(
                  iconLeading: darkMode ? Icons.brightness_3 : Icons.wb_sunny,
                  title: "App Theme",
                  trailing: Switch.adaptive(
                    value: darkMode,
                    onChanged: (value) {
                      box.put("darkMode", value);
                    },
                  ),
                );
              },
            ),
            CardSettingsCustom(
              iconLeading: Icons.add,
              title: "Add Task Manual",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AddTaskScreen.routeName);
              },
            ),
            CardSettingsCustom(
              iconLeading: Icons.category,
              title: "Add Your Category",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AddCategoryScreen.routeName);
              },
            ),
            CardSettingsCustom(
              iconLeading: Icons.book,
              title: "License",
              onTap: () => showLicensePage(
                context: context,
                applicationIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "assets/images/icon-app.png",
                    height: mqHeight / 4,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

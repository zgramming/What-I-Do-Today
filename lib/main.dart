import 'package:app_provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network/models/task_model.dart';
import 'package:network/network.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:voice_task_app/screens/add_category_screen.dart';
import 'package:voice_task_app/screens/add_task_screen.dart';
import 'package:voice_task_app/screens/home_screen.dart';
import 'package:voice_task_app/screens/testing_screen.dart';

const String languageBox = "language_box";
const String darkModeBox = "darkmode_box";
const MaterialColor myColor =
    const MaterialColor(0xFFe23e57, const <int, Color>{
  50: const Color(0xFFe23e57),
  100: const Color(0xFFe23e57),
  200: const Color(0xFFe23e57),
  300: const Color(0xFFe23e57),
  400: const Color(0xFFe23e57),
  500: const Color(0xFFe23e57),
  600: const Color(0xFFe23e57),
  700: const Color(0xFFe23e57),
  800: const Color(0xFFe23e57),
  900: const Color(0xFFe23e57),
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(CategoryModelAdapter(), 0);
  Hive.registerAdapter(TaskModelAdapter(), 1);
  await Hive.openBox(languageBox);
  await Hive.openBox(darkModeBox);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future _openBox;

  @override
  void initState() {
    _openBox = Future.wait([
      Hive.openBox("category_box"),
      Hive.openBox("task_box"),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box(darkModeBox),
      builder: (ctx, box) {
        var darkMode = box.get("darkMode", defaultValue: false);
        return BotToastInit(
          child: MaterialApp(
            title: 'What I Do Today',
            debugShowCheckedModeBanner: false,
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: ThemeData(
              primarySwatch: myColor,
              accentColor: Colors.amber,
              brightness: darkMode ? Brightness.dark : Brightness.light,
            ),
            darkTheme: ThemeData.dark(),
            home: FutureBuilder(
              future: _openBox,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return HomeScreen();
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            routes: {
              HomeScreen.routeName: (ctx) => HomeScreen(),
              TestingScreen.routeName: (ctx) => TestingScreen(),
              AddCategoryScreen.routeName: (ctx) => AddCategoryScreen(),
              AddTaskScreen.routeName: (ctx) => AddTaskScreen(),
            },
          ),
        );
      },
    );
  }
}

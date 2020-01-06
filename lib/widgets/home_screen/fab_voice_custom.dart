import 'package:app_provider/app_provider/task_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network/models/task_model.dart';

class FabVoiceCustom extends StatefulWidget {
  @override
  _FabVoiceCustomState createState() => _FabVoiceCustomState();
}

class _FabVoiceCustomState extends State<FabVoiceCustom> {
  SpeechRecognition _speechRecognition;
  bool _isListening = false;
  bool _isAvailable = false;
  String resultText = "";
  final TaskProvider taskProvider = TaskProvider();
  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result));

    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));

    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => resultText = speech));

    _speechRecognition.setRecognitionCompleteHandler((String speech) {
      var now = DateTime.now().toString();

      setState(() => _isListening = false);
      BotToast.showSimpleNotification(title: resultText);
      taskProvider.addTask(
        keyTask: now,
        taskModel: TaskModel()
          ..idTask = now
          ..titleTask = resultText
          ..imageTask = null
          ..dateCreate = DateTime.now()
          ..codeIcon = -1,
      );
      print("NOW : $now");
    });
    _speechRecognition.setErrorHandler(() {
      BotToast.showText(text: "Something Wrong. Check Your Connection");
      initSpeechRecognizer();
      setState(() {
        _isListening = false;
      });
    });

    _speechRecognition
        .activate("en_US")
        .then((result) => setState(() => _isAvailable = result));
  }

  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    return WatchBoxBuilder(
      box: Hive.box("language_box"),
      builder: (ctx, box) {
        var isEngland = box.get("isEngland", defaultValue: true);
        return FloatingActionButton.extended(
          clipBehavior: Clip.antiAlias,
          label: Text(_isListening ? " Stop" : "Say It"),
          icon: Image.asset(
            _isListening
                ? "assets/images/listen.png"
                : "assets/images/voice.png",
            width: mqHeight / 18,
          ),
          onPressed: _isListening
              ? () {
                  if (_isListening) {
                    _speechRecognition.stop().then(
                          (result) => setState(() {
                            _isListening = result;
                            print("result Stop : $result");
                          }),
                        );
                  }
                }
              : () {
                  if (_isAvailable && !_isListening) {
                    _speechRecognition
                        .activate(isEngland ? "en_US" : "id_ID")
                        .then((_) => _speechRecognition.listen());
                  }
                },
        );
      },
    );
  }
}

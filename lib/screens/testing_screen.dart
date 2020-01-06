// import 'package:flutter/material.dart';

// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_recognition_error.dart';
// import 'package:voice_task_app/screens/add_task_screen.dart';

// class TestingScreen extends StatefulWidget {
//   static const routeName = "testing-screen";
//   @override
//   _TestingScreenState createState() => _TestingScreenState();
// }

// class _TestingScreenState extends State<TestingScreen> {
//   bool _hasSpeech = false;
//   String lastWords = "";

//   String lastError = "";
//   String lastStatus = "";
//   final SpeechToText speech = SpeechToText();
//   @override
//   void initState() {
//     super.initState();
//     initSpeechState();
//   }

//   Future<void> initSpeechState() async {
//     bool hasSpeech = await speech.initialize(
//         onError: errorListener, onStatus: statusListener);

//     if (!mounted) return;
//     setState(() {
//       _hasSpeech = hasSpeech;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _hasSpeech
//           ? Column(children: [
//               Expanded(
//                 child: Center(
//                   child: Text('Speech recognition available'),
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     FlatButton(
//                       child: Text('Start'),
//                       onPressed: startListening,
//                     ),
//                     FlatButton(
//                       child: Text('Stop'),
//                       onPressed: stopListening,
//                     ),
//                     FlatButton(
//                       child: Text('Cancel'),
//                       onPressed: cancelListening,
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: <Widget>[
//                     Center(
//                       child: Text('Recognized Words'),
//                     ),
//                     Center(
//                       child: Text(lastWords),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: <Widget>[
//                     Center(
//                       child: Text('Error'),
//                     ),
//                     Center(
//                       child: Text(lastError),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Center(
//                   child: speech.isListening
//                       ? Text("I'm listening...")
//                       : Text('Not listening'),
//                 ),
//               ),
//             ])
//           : Center(
//               child: Text('Speech recognition unavailable',
//                   style:
//                       TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
//     );
//   }

//   void startListening() {
//     lastWords = "";
//     lastError = "";
//     speech.listen(onResult: resultListener);
//     setState(() {});
//   }

//   void stopListening() {
//     speech.stop();
//     setState(() {});
//   }

//   void cancelListening() {
//     speech.cancel();
//     setState(() {});
//   }

//   void resultListener(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = "${result.recognizedWords} - ${result.finalResult}";
//     });
//     Navigator.of(context).pushNamed(AddTaskScreen.routeName);
//   }

//   void errorListener(SpeechRecognitionError error) {
//     setState(() {
//       lastError = "${error.errorMsg} - ${error.permanent}";
//     });
//   }

//   void statusListener(String status) {
//     setState(() {
//       lastStatus = "$status";
//     });
//   }
// }

import 'package:flutter/material.dart';

class TestingScreen extends StatelessWidget {
  static const routeName = "testing-screen";
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

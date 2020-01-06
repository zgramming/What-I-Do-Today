import 'package:flutter/material.dart';

class DialogConfirmDelete extends StatelessWidget {
  final String title;
  final Function onPressed;
  DialogConfirmDelete({this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Do you want remove $title ?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
          textTheme: ButtonTextTheme.normal,
        ),
        FlatButton(
          onPressed: onPressed,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}

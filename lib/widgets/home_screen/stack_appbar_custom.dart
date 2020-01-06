import 'package:flutter/material.dart';

class StackAppBarCustom extends StatelessWidget {
  final Widget categoryContent;
  StackAppBarCustom({this.categoryContent});
  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: mqHeight / 3,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(80),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Your Category',
              style: textTheme.subtitle
                  .copyWith(color: Colors.white70, letterSpacing: 2),
            ),
          ),
          Positioned(
            top: mqHeight / 4.5,
            right: mqWidth / 20,
            left: mqWidth / 20,
            child: categoryContent,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CardSettingsCustom extends StatelessWidget {
  final IconData iconLeading;
  final String title;
  final Widget trailing;
  final Function onTap;
  CardSettingsCustom({
    @required this.iconLeading,
    @required this.title,
    this.trailing,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          iconLeading,
          color: theme.brightness == Brightness.light
              ? Theme.of(context).primaryColor
              : Colors.white,
          size: mqHeight / 12,
        ),
        title: Text(
          title,
          style: textTheme.subtitle.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: theme.brightness == Brightness.light
                ? Colors.black54
                : Colors.white,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}

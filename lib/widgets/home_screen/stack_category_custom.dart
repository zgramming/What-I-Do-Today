import 'package:app_provider/app_provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_task_app/widgets/dialog_confirm_delete.dart';

class StackCategoryCustom extends StatelessWidget {
  final DateTime idCategory;
  final int codeCategory;
  final String titleCategory;
  final int indexBox;
  StackCategoryCustom({
    this.idCategory,
    this.codeCategory,
    this.titleCategory,
    this.indexBox,
  });
  @override
  Widget build(BuildContext context) {
    final mqWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final ThemeData theme = Theme.of(context);

    final categoryProvider = Provider.of<CategoryProvider>(context);
    return InkWell(
      onLongPress: () => showDialog(
        context: context,
        child: DialogConfirmDelete(
          title: titleCategory,
          onPressed: () {
            categoryProvider.deleteCategory(indexBox: indexBox);
            Navigator.of(context).pop(true);
          },
        ),
      ),
      child: Container(
        width: mqWidth / 3,
        child: Card(
          color:
              theme.brightness == Brightness.light ? null : Color(0xFFe23e57),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                IconData(
                  codeCategory,
                  fontFamily: "MaterialIcons",
                ),
                size: mqWidth / 6,
                color: theme.brightness == Brightness.light
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              FittedBox(
                child: Text(
                  titleCategory,
                  style: textTheme.subtitle.copyWith(
                    color: theme.brightness == Brightness.light
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

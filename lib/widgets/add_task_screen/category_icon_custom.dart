import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network/models/category_model.dart';

class CategoryIconCustom extends StatefulWidget {
  final Function onTap;
  final int selectedCodeIcon;
  CategoryIconCustom({this.onTap, this.selectedCodeIcon});
  @override
  _CategoryIconCustomState createState() => _CategoryIconCustomState();
}

class _CategoryIconCustomState extends State<CategoryIconCustom> {
  int selectedList = -1;
  int codeIcon = 0;
  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final ThemeData theme = Theme.of(context);

    return WatchBoxBuilder(
      box: Hive.box("category_box"),
      builder: (ctx, box) {
        if (box.isEmpty) {
          return Column(
            children: <Widget>[
              Text(
                'Category Empty , Please Add Someone',
                style: textTheme.title,
                textAlign: TextAlign.center,
              ),
              Image.asset("assets/images/empty.png"),
            ],
          );
        } else {
          final categoryList = box.values.toList().cast<CategoryModel>();
          return SizedBox(
            height: mqHeight / 6,
            child: ListView.builder(
              itemCount: categoryList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final categoryValue = categoryList[index];
                return InkResponse(
                  onTap: () {
                    setState(() {
                      selectedList = index;
                    });
                    codeIcon = categoryValue.codeCategory;
                    widget.onTap(codeIcon);
                  },
                  child: SizedBox(
                    width: mqWidth / 4,
                    child: Card(
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
            ),
          );
        }
      },
    );
  }
}

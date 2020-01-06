import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:network/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final String categoryBox = "category_box";

  void addCategory({
    @required CategoryModel categoryModel,
  }) {
    final hiveBox = Hive.box(categoryBox);
    final hiveValue = categoryModel;
    hiveBox.add(hiveValue);
    notifyListeners();
  }

  void deleteCategory({@required int indexBox}) async {
    final hiveBox = Hive.box(categoryBox);
    await hiveBox.deleteAt(indexBox);
    notifyListeners();
  }
}

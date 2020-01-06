import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType()
class CategoryModel extends HiveObject {
  @HiveField(0)
  DateTime idCategory;
  @HiveField(1)
  String titleCategory;
  @HiveField(2)
  int codeCategory;
  CategoryModel({this.idCategory, this.titleCategory, this.codeCategory});
  // Hive fields go here
}

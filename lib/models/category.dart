import 'package:wallet/common/constants.dart';

class CategoryModel {
  int id;
  String name;
  int color;

  CategoryModel(this.id, this.name, this.color);

  CategoryModel.fromMap(Map<String, dynamic> map) {
    id = map[COLUMN_ID];
    name = map[COLUMN_NAME];
    color = map[COLUMN_COLOR];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      COLUMN_NAME: name,
      COLUMN_COLOR: color,
    };
    if (id != null) {
      map[COLUMN_ID] = id;
    }
    return map;
  }
}

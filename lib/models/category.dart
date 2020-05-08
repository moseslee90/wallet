import 'package:wallet/common/constants.dart' as constants;

class CategoryModel {
  int id;
  String name;

  CategoryModel(this.id, this.name);

  CategoryModel.fromMap(Map<String, dynamic> map) {
    id = map[constants.columnId];
    name = map[constants.columnName];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      constants.columnName: name,
    };
    if (id != null) {
      map[constants.columnId] = id;
    }
    return map;
  }
}

import 'package:wallet/common/constants.dart' as constants;

class CategoryModel {
  int id;
  String name;

  CategoryModel(this.id, this.name);

  CategoryModel.fromMap(Map<String, dynamic> map) {
    id = map[constants.COLUMN_ID];
    name = map[constants.COLUMN_NAME];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      constants.COLUMN_NAME: name,
    };
    if (id != null) {
      map[constants.COLUMN_ID] = id;
    }
    return map;
  }
}

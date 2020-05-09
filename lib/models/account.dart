import 'package:wallet/common/constants.dart' as constants;
import 'package:meta/meta.dart';

class AccountModel {
  int id;
  String name;
  int color;
  int total; // total is only updated with items

  AccountModel(this.id, this.name, this.color);

  AccountModel.fromMap(Map<String, dynamic> map) {
    id = map[constants.COLUMN_ID];
    name = map[constants.COLUMN_NAME];
    color = map[constants.COLUMN_COLOR];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      constants.COLUMN_COLOR: color,
      constants.COLUMN_NAME: name,
    };
    if (id != null) {
      map[constants.COLUMN_ID] = id;
    }
    return map;
  }

  String totalToString() {
    if (total == null) {
      return '0';
    }
    return total.toString();
  }
}
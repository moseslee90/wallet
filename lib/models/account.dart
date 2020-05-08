import 'package:wallet/common/constants.dart' as constants;
import 'package:meta/meta.dart';

class AccountModel {
  int id;
  String name;
  int color;
  int total; // total is only updated with items

  AccountModel(this.id, this.name, this.color);

  AccountModel.fromMap(Map<String, dynamic> map) {
    id = map[constants.columnId];
    name = map[constants.columnName];
    color = map[constants.columnColor];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      constants.columnColor: color,
      constants.columnName: name,
    };
    if (id != null) {
      map[constants.columnId] = id;
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
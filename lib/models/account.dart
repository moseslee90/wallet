import 'package:wallet/common/constants.dart' as constants;
import 'package:meta/meta.dart';

class AccountModel {
  int id;
  String name;
  int color;
  double total = 0; // total is only updated with items
  int position = 0; // initialise as 0

  AccountModel(this.id, this.name, this.color);

  AccountModel.fromMap(Map<String, dynamic> map) {
    id = map[constants.COLUMN_ID];
    name = map[constants.COLUMN_NAME];
    color = map[constants.COLUMN_COLOR];
    position = map[constants.COLUMN_POSITION] ?? 0;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      constants.COLUMN_COLOR: color,
      constants.COLUMN_NAME: name,
      constants.COLUMN_POSITION: position,
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
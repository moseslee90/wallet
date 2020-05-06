import 'package:wallet/common/constants.dart' as constants;

class AccountModel {
  int id;
  int color;
  int total;

  AccountModel(this.id, this.total, this.color);

  AccountModel.fromMap(Map<String, dynamic> map) {
    id = map[constants.columnId];
    color = map[constants.columnColor];
    total = map[constants.columnTotal];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      constants.columnTotal: total,
      constants.columnColor: color,
    };
    if (id != null) {
      map[constants.columnId] = id;
    }
    return map;
  }
}
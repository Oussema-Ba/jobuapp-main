import 'dart:developer';

import 'package:crossplat_objectid/crossplat_objectid.dart';

String generateId() {
  ObjectId id1 = ObjectId();
  return id1.toHexString();
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

String getLastTimeUpdated(DateTime? time) {
  log("time");
  log(time.toString());
  return time != null ? "${time.hour}:${time.minute}" : "now";
}

List<String> getListString(List<dynamic> data) {
  List<String> converted = [];
 
  for (var item in data) {
    converted.add(item.toString());
  }
  return converted;
}

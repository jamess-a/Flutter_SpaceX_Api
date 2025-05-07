// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes
// GENERATED FILE, do not edit!
import 'package:i69n/i69n.dart' as i69n;
import 'package:spacex/localization/entities/language.dart';
import 'package:spacex/localization/strings_base.dart';

String get _languageCode => 'th';
String get _localeName => 'th';

String _plural(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) => i69n.plural(
  count,
  _languageCode,
  zero: zero,
  one: one,
  two: two,
  few: few,
  many: many,
  other: other,
);
String _ordinal(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) => i69n.ordinal(
  count,
  _languageCode,
  zero: zero,
  one: one,
  two: two,
  few: few,
  many: many,
  other: other,
);
String _cardinal(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) => i69n.cardinal(
  count,
  _languageCode,
  zero: zero,
  one: one,
  two: two,
  few: few,
  many: many,
  other: other,
);

class Strings_th extends Strings {
  const Strings_th();
  LaunchesStrings_th get launches => LaunchesStrings_th(this);
  LaunchesStrings_th get modals => LaunchesStrings_th(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)] as i69n.I69nMessageBundle)[key
          .substring(index + 1)];
    }
    switch (key) {
      case 'launches':
        return launches;

      case 'modal':
        return modals;
      default:
        return throw ArgumentError('Unknown key: $key');
    }
  }
}

class LaunchesStrings_th extends LaunchesStrings {
  final Strings_th _parent;
  LaunchesStrings_th(this._parent);
  String get title => "ตารางปล่อยจรวด";
  String get searchHint => "ค้นหาด้วยชื่อ";
  String get loading => "กำลังโหลดข้อมูล...";
  String get error => "เกิดข้อผิดพลาดบางอย่าง";
  String get success => "สําเร็จ";
  String get livelaunch => "ถ่ายทอดสด";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)] as i69n.I69nMessageBundle)[key
          .substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'searchHint':
        return searchHint;
      case 'loading':
        return loading;
      case 'error':
        return error;
      case 'success':
        return success;
      case 'livelaunch':
        return livelaunch;
      default:
        return throw ArgumentError('Unknown key: $key');
    }
  }
}

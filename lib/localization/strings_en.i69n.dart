// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes
// GENERATED FILE, do not edit!
import 'package:i69n/i69n.dart' as i69n;
import 'package:spacex/localization/entities/language.dart';
import 'package:spacex/localization/strings_base.dart';

String get _languageCode => 'en';
String get _localeName => 'en';

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

class Strings_en extends Strings {
  const Strings_en();
  LaunchesStrings_en get launches => LaunchesStrings_en(this);
  LaunchesStrings_en get modals => LaunchesStrings_en(this);
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

class LaunchesStrings_en extends LaunchesStrings {
  final Strings_en _parent;
  LaunchesStrings_en(this._parent);
  String get title => "Launches";
  String get searchHint => "Search by name";
  String get loading => "Loading...";
  String get error => "Something went wrong.";
  String get success => "Success";
  String get failed => "Failed";
  String get livelaunch => "Live Launch";
  String get emptyResult => "Launches not Found";
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
      case 'failed':
        return failed;
      case 'livelaunch':
        return livelaunch;
      case 'emptyResult':
        return emptyResult;
      default:
        return throw ArgumentError('Unknown key: $key');
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'strings_base.dart';
import 'strings_en.i69n.dart';
import 'strings_th.i69n.dart';

class LanguageCubit extends Cubit<Strings> {
  LanguageCubit() : super(const Strings_en());

  void changeLanguage(String localeCode) {
    switch (localeCode) {
      case 'th':
        emit(const Strings_th());
        break;
      default:
        emit(const Strings_en());
    }
  }
}

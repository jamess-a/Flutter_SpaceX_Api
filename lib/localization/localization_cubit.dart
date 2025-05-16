import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/localization/strings_base.dart';
import 'package:spacex/localization/generated/strings_en.i69n.dart';
import 'package:spacex/localization/generated/strings_th.i69n.dart';

class LanguageCubit extends Cubit<Strings> {
  LanguageCubit() : super(Strings_en());

  void toggleLanguage() {
    if (state is Strings_en) {
      emit(Strings_th());
    } else {
      emit(Strings_en());
    }
  }

  String get currentLanguage => state is Strings_en ? 'en' : 'th' ;

  
}

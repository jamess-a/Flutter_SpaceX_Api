import 'package:i69n/i69n.dart';

abstract class Strings implements I69nMessageBundle {
  const Strings();

  get launches => null;
  get modal => null;


  void load(String mewStrings) {
    throw UnimplementedError();
  }
  
  @override
  Object operator [](String key);
}

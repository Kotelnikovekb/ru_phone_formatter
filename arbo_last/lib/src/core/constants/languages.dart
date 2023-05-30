import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ru_RU': {
      'greeting': 'Привет',
    },
    'en_US': {
      'greeting': 'Hello',
    },
  };
}
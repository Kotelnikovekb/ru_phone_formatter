library ru_phone_formatter;

import 'package:flutter/services.dart';

///класс форматирования вводимых телефонов с учетом массы российских номеров. Позволяет вводить телефоны с 7,9,8
///
///the formatting class of the entered phones, taking into account the masses of Russian numbers. Allows you to enter phones with 7,9,8
class RuPhoneInputFormatter extends TextInputFormatter {
  String _formattedPhone = "";
  bool _isRu = false;

  RuPhoneInputFormatter({
    String? initialText,
  }) {
    if (initialText != null) {
      formatEditUpdate(
          TextEditingValue.empty, TextEditingValue(text: initialText));
    }
  }

  ///Задает номер телефона в маске
  ///
  /// Specifies the phone number in the mask
  void setPhone(String phone) {
    formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: phone));
  }

  ///Возвращает телефон в маске
  ///
  ///Returns the phone in with a mask
  String getMaskedPhone() {
    return _formattedPhone;
  }

  ///Возвращает телефон без маски и +. Для российских телефонов номер начинается с 9
  ///
  ///Returns phone without mask and +. For Russian phones, the number starts with 9
  String getClearPhone() {
    if (_formattedPhone.isEmpty) {
      return '';
    }
    if (!_isRu) {
      return _formattedPhone.replaceAll(RegExp(r'\D'), '');
    }
    return _formattedPhone.replaceAll(RegExp(r'\D'), '').substring(
        1,
        (_formattedPhone.replaceAll(RegExp(r'\D'), '').length >= 11)
            ? 11
            : _formattedPhone.replaceAll(RegExp(r'\D'), '').length);
  }

  ///Проверяет, заполнен ли телефон. Для нерусских телефонов всегда актуально
  ///
  ///Checks if the phone is full. For non-Russian phones always true
  bool isDone() {
    if (!_isRu) {
      return true;
    }
    return (_formattedPhone.replaceAll(RegExp(r'\D'), '').length > 10);
  }

  ///Проверяет, является ли номер русским
  ///checks if the number is Russian
  bool get isRussian => _isRu;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');
    int selectionStart = oldValue.selection.end;

    if (oldValue.text == '${newValue.text} ') {
      _formattedPhone = '';
      return TextEditingValue(
          text: _formattedPhone,
          selection: TextSelection(
              baseOffset: _formattedPhone.length,
              extentOffset: _formattedPhone.length,
              affinity: newValue.selection.affinity,
              isDirectional: newValue.selection.isDirectional));
    }

    if (selectionStart != _formattedPhone.length) {
      _formattedPhone = _formattingPhone(text);

      return TextEditingValue(
          text: _formattedPhone,
          selection: TextSelection(
              baseOffset: newValue.selection.baseOffset,
              extentOffset: newValue.selection.extentOffset,
              affinity: newValue.selection.affinity,
              isDirectional: newValue.selection.isDirectional));
    }

    _formattedPhone = _formattingPhone(text);

    return TextEditingValue(
        text: _formattedPhone,
        selection: TextSelection(
            baseOffset: _formattedPhone.length,
            extentOffset: _formattedPhone.length,
            affinity: newValue.selection.affinity,
            isDirectional: newValue.selection.isDirectional));
  }

  String _formattingPhone(String text) {
    text = text.replaceAll(RegExp(r'\D'), '');
    if (text.isNotEmpty) {
      String phone = '';
      if (['7', '8', '9'].contains(text[0])) {
        _isRu = true;
        if (text[0] == '9') {
          text = '7$text';
        }
        String firstSymbols = (text[0] == '8') ? '8' : '+7';
        phone = '$firstSymbols ';
        if (text.length > 1) {
          phone += '(${text.substring(1, (text.length < 4) ? text.length : 4)}';
        }
        if (text.length >= 5) {
          phone +=
              ') ${text.substring(4, (text.length < 7) ? text.length : 7)}';
        }
        if (text.length >= 8) {
          phone += '-${text.substring(7, (text.length < 9) ? text.length : 9)}';
        }
        if (text.length >= 10) {
          phone +=
              '-${text.substring(9, (text.length < 11) ? text.length : 11)}';
        }
        return phone;
      } else {
        _isRu = false;
        return '+$text';
      }
    }
    return '';
  }
}

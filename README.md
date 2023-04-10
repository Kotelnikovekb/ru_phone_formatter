## RU Phone Formatter

![Alt Text](https://raw.githubusercontent.com/Kotelnikovekb/ru_phone_formatter/master/example.gif)

The package allows you to format phone numbers. for Russian numbers, a mask will be applied. no matter which digit you start entering (from 9.8 or 7), the mask correctly adapts the value in the input field. If you specify a number not from Russia, then the mask will not work

## Getting started


Just download the package to get started.

## Usage

Declare a mask for formatting

```dart
  final maskFormatter =  RuPhoneInputFormatter();
```
add it to TextForm

```dart
  TextFormField(
    inputFormatters:[maskFormatter],
  );
```

get the result in maskFormatter.getClearPhone()
```dart
  String phone=maskFormatter.getClearPhone();
```

## Support the author
[Support the author](https://www.donationalerts.com/r/mryurideveloper)

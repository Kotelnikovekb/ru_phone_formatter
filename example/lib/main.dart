import 'package:flutter/material.dart';
import 'package:ru_phone_formatter/ru_phone_formatter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'RU phone formatter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
    final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Номер телефона без маски
  //Phone number without mask
  String phoneClear='';
  //Номер телефона c маской
  //Phone number with mask
  String phoneFormatter='';
  //Заполнен ли номер телефона полностью. Раболтает только для телефонов из России. Для иностранных телефонов всегда true
  //Is the phone number filled out completely. Works only for phones from Russia. For foreign phones always true
  bool isDone=false;
  //Проверяет российски ли телефон
  //Checks whether the phone is Russian
  bool isRu=false;
  final textController=TextEditingController();
  final ruFormatter=RuPhoneInputFormatter();

  //Пример добавления кода в текстовое поле
  //Example of adding code to a text field
  void _setPhone() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'phoneClear: $phoneClear\nphoneFormatter: $phoneFormatter\nisDone: $isDone\nisRu: $isRu',
            ),
            TextFormField(
              controller: textController,
              inputFormatters:[ruFormatter],
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (_){
                setState(() {
                  phoneClear=ruFormatter.getClearPhone();
                  phoneFormatter=ruFormatter.getMaskedPhone();
                  isDone=ruFormatter.isDone();
                  isRu=ruFormatter.isRussian;
                });
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setPhone,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

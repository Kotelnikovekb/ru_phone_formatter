import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSelector<T> extends StatefulWidget {

  final double? width;
  final String title;
  final String Function(dynamic value)? itemAsString;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final void Function(dynamic value) onSelectionDone;
  final T? initialValue;
  final Color? selectedItemColor;
  final List<T> items;
  final String? itemKey;
  final bool selectOne;

  const AppSelector(
      {Key? key,
      this.width,
      required this.title,
      this.itemAsString,
      this.decoration,
      this.validator,
      required this.onSelectionDone,
      this.initialValue,
      this.selectedItemColor,
      required this.items,
        this.itemKey,
        this.selectOne=true
      })
      : super(key: key);

  @override
  State<AppSelector> createState() => _AppSelectorState();
}

class _AppSelectorState<T> extends State<AppSelector<T>> {


  final TextEditingController _controller = TextEditingController();
  T? selectedItem;

  @override
  void initState() {
    selectedItem = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = _selectedItemAsString(selectedItem);
    return GestureDetector(
      child: SizedBox(
        width: widget.width ?? double.infinity,
        child: TextFormField(
          controller: _controller,
          readOnly: true,
          enabled: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            labelText: widget.title,
          ),
        ),
      ),
      onTap: ()async{
        final res=await Get.bottomSheet(
          Column(
            children: [
              Flexible(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: StatefulBuilder(
                      builder: (_, setState){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              color: Colors.grey.shade200,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      title: Text(_getTitle(widget.items[index])),
                                      trailing: Checkbox(
                                          value: (selectedItem==widget.items[index]),
                                          onChanged: (value){
                                            setState(() {
                                              selectedItem=widget.items[index];
                                            });
                                            _controller.text = _selectedItemAsString(selectedItem);
                                            widget.onSelectionDone(widget.items[index]);
                                          }
                                      )
                                  );
                                },
                                itemCount: widget.items.length,
                              ),
                            ),
                            Wrap(
                              children: [
                                (selectedItem!=null)?
                                TextButton(
                                    onPressed: (){
                                      Get.back(result: selectedItem);
                                    },
                                    child: Text('Выбрать')
                                )
                                    :
                                TextButton(
                                    onPressed: (){
                                      Get.back(result: null);
                                    },
                                    child: Text('Отмена')
                                )
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  )
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
          enableDrag: true,
          backgroundColor: Colors.transparent,
        );
      },
    );
  }

  String _getTitle(T? data){
    if (data == null) {
      return "";
    }
    if(widget.itemKey!=null){
      return json.decode(json.encode(data))[widget.itemKey!];
    }
    return data.toString();
  }

  String _selectedItemAsString(T? data) {
    if (data == null) {
      return "";
    } else if (widget.itemAsString != null) {
      return widget.itemAsString!(data);
    } else {
      return data.toString();
    }
  }
}

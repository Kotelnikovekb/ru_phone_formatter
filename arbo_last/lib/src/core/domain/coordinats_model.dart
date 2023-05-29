import 'dart:convert';

List<CoordinatsModel> coordinatsModelFromJson(String str) => List<CoordinatsModel>.from(json.decode(str).map((x) => CoordinatsModel.fromJson(x)));

String coordinatsModelToJson(List<CoordinatsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoordinatsModel {
  String value;
  String unrestrictedValue;

  CoordinatsModel({
    required this.value,
    required this.unrestrictedValue,
  });

  factory CoordinatsModel.fromJson(Map<String, dynamic> json) => CoordinatsModel(
    value: json["value"],
    unrestrictedValue: json["unrestricted_value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "unrestricted_value": unrestrictedValue,
  };
}

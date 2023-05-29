import 'dart:convert';

List<ConsumptionModel> consumptionModelFromJson(String str) => List<ConsumptionModel>.from(json.decode(str).map((x) => ConsumptionModel.fromJson(x)));

String consumptionModelToJson(List<ConsumptionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsumptionModel {
  String id;
  DateTime datecreate;
  String user;
  String name;
  String cost;
  String pm;
  String category;
  String subcategory;
  String trueCost;
  String paymentType;

  ConsumptionModel({
    required this.id,
    required this.datecreate,
    required this.user,
    required this.name,
    required this.cost,
    required this.pm,
    required this.category,
    required this.subcategory,
    required this.trueCost,
    required this.paymentType,
  });

  factory ConsumptionModel.fromJson(Map<String, dynamic> json) => ConsumptionModel(
    id: json["id"],
    datecreate: DateTime.parse(json["datecreate"]),
    user: json["user"],
    name: json["name"],
    cost: json["cost"],
    pm: json["pm"],
    category: json["category"],
    subcategory: json["subcategory"],
    trueCost: json["trueCost"],
    paymentType: json["payment_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "datecreate": datecreate.toIso8601String(),
    "user": user,
    "name": name,
    "cost": cost,
    "pm": pm,
    "category": category,
    "subcategory": subcategory,
    "trueCost": trueCost,
    "payment_type": paymentType,
  };
}

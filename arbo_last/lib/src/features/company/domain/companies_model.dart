import 'dart:convert';

List<CompaniesModel> companiesModelFromJson(String str) => List<CompaniesModel>.from(json.decode(str).map((x) => CompaniesModel.fromJson(x)));

String companiesModelToJson(List<CompaniesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompaniesModel {
  String id;
  String name;
  String adress;
  String phone;
  String fio;
  String email;
  String v1;
  String v2;
  DateTime dateCreate;
  Category category;

  CompaniesModel({
    required this.id,
    required this.name,
    required this.adress,
    required this.phone,
    required this.fio,
    required this.email,
    required this.v1,
    required this.v2,
    required this.dateCreate,
    required this.category,
  });

  factory CompaniesModel.fromJson(Map<String, dynamic> json) => CompaniesModel(
    id: json["id"],
    name: json["name"],
    adress: json["adress"],
    phone: json["phone"],
    fio: json["fio"],
    email: json["email"],
    v1: json["v1"],
    v2: json["v2"],
    dateCreate: DateTime.parse(json["date_create"]),
    category: categoryValues.map[json["category"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "adress": adress,
    "phone": phone,
    "fio": fio,
    "email": email,
    "v1": v1,
    "v2": v2,
    "date_create": dateCreate.toIso8601String(),
    "category": categoryValues.reverse[category],
  };
}

enum Category { EMPTY, CATEGORY, PURPLE, FLUFFY, TENTACLED }

final categoryValues = EnumValues({
  "Спил Деревьев": Category.CATEGORY,
  "Не указана": Category.EMPTY,
  "Смешенные работы": Category.FLUFFY,
  "Дробление пней": Category.PURPLE,
  "Посадка и ландшафт": Category.TENTACLED
});




class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

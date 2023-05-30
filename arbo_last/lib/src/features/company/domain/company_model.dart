import 'dart:convert';

CompanyModel companyModelFromJson(String str) => CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  String success;
  List<Work> works;
  String name;
  String address;
  String phone;
  String email;
  String v1;
  String v2;
  String fio;
  String category;
  DateTime createdAt;

  CompanyModel({
    required this.success,
    required this.works,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.v1,
    required this.v2,
    required this.fio,
    required this.category,
    required this.createdAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    success: json["success"],
    works: List<Work>.from(json["works"].map((x) => Work.fromJson(x))),
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
    v1: json["v1"],
    v2: json["v2"],
    fio: json["fio"],
    category: json["category"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "works": List<dynamic>.from(works.map((x) => x.toJson())),
    "name": name,
    "address": address,
    "phone": phone,
    "email": email,
    "v1": v1,
    "v2": v2,
    "fio": fio,
  };
}

class Work {
  String id;
  String type;
  String name;
  String company;
  String cost;
  String user;
  DateTime datecreate;
  String payer;
  String category;
  String subcategory;
  String trueCost;
  String paymentType;
  String companyId;

  Work({
    required this.id,
    required this.type,
    required this.name,
    required this.company,
    required this.cost,
    required this.user,
    required this.datecreate,
    required this.payer,
    required this.category,
    required this.subcategory,
    required this.trueCost,
    required this.paymentType,
    required this.companyId,
  });

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    company: json["company"],
    cost: json["cost"],
    user: json["user"],
    datecreate: DateTime.parse(json["datecreate"]),
    payer: json["payer"],
    category: json["category"],
    subcategory: json["subcategory"],
    trueCost: json["trueCost"],
    paymentType: json["payment_type"],
    companyId: json["companyId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "company": company,
    "cost": cost,
    "user": user,
    "datecreate": datecreate.toIso8601String(),
    "payer": payer,
    "category": category,
    "subcategory": subcategory,
    "trueCost": trueCost,
    "payment_type": paymentType,
    "companyId": companyId,
  };
}

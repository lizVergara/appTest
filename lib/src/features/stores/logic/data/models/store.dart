// To parse this JSON data, do
//
//     final store = storeFromMap(jsonString);

import 'dart:convert';

import '../../../../orders/data/models/order.dart';

class Store {
  Store({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.createdAt,
    this.updatedAt,
    this.orders,
  });

  int id;
  String name;
  double lat;
  double lng;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Order>? orders;

  factory Store.fromJson(String str) => Store.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Store.fromMap(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orders: json["orders"] != null
            ? List<Order>.from(json["orders"].map((x) => Order.fromMap(x)))
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "lat": lat,
        "lng": lng,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "orders": orders != null
            ? List<Map<String, dynamic>>.from(orders!.map((x) => x.toMap()))
            : null,
      };
}

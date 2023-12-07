// To parse this JSON data, do
//
//     final orders = ordersFromMap(jsonString);

import 'dart:convert';
import 'dart:ffi';

class Order {
  Order(
      {required this.id,
      required this.destLat,
      required this.destLng,
      required this.driverId,
      required this.storeId,
      this.createdAt,
      this.updatedAt,
      required this.description,
      required this.price,
      required this.storeName,
      required this.storeLat,
      required this.storeLng});

  int id;
  double destLat;
  double destLng;
  int driverId;
  int storeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String description;
  double price;
  double storeLat;
  double storeLng;
  String storeName;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        destLat: json["destination_lat"].toDouble(),
        destLng: json["destination_lng"].toDouble(),
        driverId: json["driver_id"],
        storeId: json["store_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description: json["detail"],
        price: json["price"].toDouble(),
        storeName: json["store"]["name"],
        storeLat: json["store"]["lat"],
        storeLng: json["store"]["lng"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "destination_lat": destLat,
        "destination_lng": destLng,
        "driver_id": driverId,
        "store_id": storeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "detail": description,
        "price": price,
      };
}

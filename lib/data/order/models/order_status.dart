
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommers/domain/order/entities/order_status.dart';

class OrderStatusModel {
  final String title;
  final bool done;
  final Timestamp createdAt;

  OrderStatusModel({
    required this.title,
    required this.done,
    required this.createdAt
  });


  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
        title: map['title'] as String,
        done: map['done'] as bool,
        createdAt:  map['createdAt'] is Timestamp
            ? map['createdAt'] as Timestamp
            : Timestamp.fromDate(DateTime.now())
    );
  }
}

extension OrderStatusXModel on OrderStatusModel {
  OrderStatusEntity toEntity() {
    return OrderStatusEntity(
        createdAt: createdAt,
        done: done,
        title: title
    );
  }
}

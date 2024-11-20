import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EducationOrderModel extends Equatable{
  final Timestamp createdAt;
  final String fullName;
  final int id;
  final int privateNumber;
  final String status;

  const EducationOrderModel(
      {required this.createdAt, required this.fullName, required this.id,
        required this.privateNumber, required this.status,});

  factory EducationOrderModel.fromDoc({required DocumentSnapshot document}){
    return EducationOrderModel(createdAt: document['created_at'],
      fullName: document['full_name'],
      id: document['id'],
      privateNumber: document['private_number'],
      status: document['status'],
    );
  }

  List<Object?> get props =>[
    id,
    privateNumber,
    status,
    createdAt,
    fullName,
  ];
}
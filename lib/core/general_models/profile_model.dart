import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SoliderModel extends Equatable {
  final int accountNumber;
  final int id;
  final int militaryNumber;
  final int phoneNumber;
  final int privateNumber;
  final String image;
  final String docName;

  const SoliderModel({
    required this.accountNumber,
    required this.id,
    required this.phoneNumber,
    required this.militaryNumber,
    required this.privateNumber,
    required this.image,
    required this.docName,
  });

  factory SoliderModel.fromDoc({required DocumentSnapshot document}) {
    return SoliderModel(
      docName: document.id,
      accountNumber: document['account_number'],
      id: document['id'],
      militaryNumber: document['military_number'],
      phoneNumber: document['phone_number'],
      privateNumber: document['private_number'],
      image: document['image'],
    );
  }

  @override
  List<Object?> get props => [
        accountNumber,
        id,
        phoneNumber,
        militaryNumber,
        privateNumber,
        image,
      ];
}

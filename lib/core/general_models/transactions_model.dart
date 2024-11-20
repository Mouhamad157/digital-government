import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TransactionsModel extends Equatable{
  final int id;
  final int privateNumber;
  final String status;
  final String docName;

  const TransactionsModel({required this.id, required this.privateNumber, required this.status,required this.docName});


  factory TransactionsModel.fromDoc({required DocumentSnapshot document}){
    return TransactionsModel(docName: document.id,id: document['id'], privateNumber: document['private_number'], status: document['status']);
  }
  @override
  List<Object?> get props =>[
    id,
    privateNumber,
    status,
    docName,
  ];
}
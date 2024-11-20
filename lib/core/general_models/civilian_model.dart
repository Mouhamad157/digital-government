import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Civilian extends Equatable {
  final String docName;
  final Timestamp birthDay;
  final String familyName;
  final int? fatherId;
  final String gender;
  final int id;
  final int? militaryNumber;
  final String militaryStatus;
  final int? motherId;
  final String name;
  final int privateNumber;

  const Civilian({
    required this.docName,
    required this.birthDay,
    required this.familyName,
    required this.fatherId,
    required this.gender,
    required this.id,
    required this.militaryNumber,
    required this.militaryStatus,
    required this.motherId,
    required this.name,
    required this.privateNumber,
  });

  factory Civilian.fromDoc(DocumentSnapshot document) {
    print(document.data());
    return Civilian(
      docName: document.id,
      birthDay: document['birth_day'],
      familyName: document['family_name'],
      fatherId: document['father_id'],
      gender: document['gender'],
      id: document['id'],
      militaryNumber: document['military_number'],
      militaryStatus: document['military_status'],
      motherId: document['mother_id'],
      name: document['name'],
      privateNumber: document['private_number'],
    );
  }

  @override
  List<Object?> get props => [
        docName,
        birthDay,
        familyName,
        fatherId,
        gender,
        id,
        militaryStatus,
        motherId,
        name,
        privateNumber,
      ];
}

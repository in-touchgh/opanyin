import 'package:cloud_firestore/cloud_firestore.dart';

class Weight {
  double weight;
  Timestamp timestamp;
  String id;

  Weight({
    required this.weight,
    required this.timestamp,
    required this.id
  });

  Map<String,dynamic> createMap(){
    return {
      'weight': weight,
      'timestamp': timestamp,
      'id': id
    };
  }

  Weight.fromFirestore(Map<String,dynamic> firestoreMap):
        id = firestoreMap['id'],
        weight = firestoreMap['weight'],
        timestamp = firestoreMap['timestamp'];
}
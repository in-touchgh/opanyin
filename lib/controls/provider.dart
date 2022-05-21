import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/weight.dart';
import '../service/firestore_service.dart';

class WeightProvider with ChangeNotifier {
  final service = FireStoreService();
  String _id ='';
  late Timestamp _timestamp ;
  late double _weight;
  late User user;


  Timestamp get getTimestamp=> _timestamp;
  double get getWeight => _weight;
  User get getUser =>user;



  void changeWeight(String val) {
    _weight = double.parse(val);
    _timestamp = Timestamp.fromDate(DateTime.now());
    notifyListeners();
  }

  loadValues(Weight weight) {
    _weight = weight.weight;
    _id = weight.id;
    _timestamp = weight.timestamp;
  }

  void changes(){

  }

  void saveData() {
    if (_id.isEmpty) {
      var newWeight =
      Weight(weight: getWeight, id: service.createId(), timestamp: getTimestamp);
      service.saveProduct(newWeight);
    } else {
      var updatedWeight =
      Weight(weight: getWeight, timestamp: getTimestamp, id: _id);
      service.updateProduct(updatedWeight);
    }
  }

  void update(Map data){

  }

  void removeData(_id) {
    service.removeItem(_id);
  }
}
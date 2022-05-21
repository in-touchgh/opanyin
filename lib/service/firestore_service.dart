

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/weight.dart';


class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> updateProduct(Weight weight) {
    return _db
        .collection('Weight')
        .doc(weight.id)
        .update(weight.createMap());
  }

  Future<void> saveProduct(Weight weight) {
    return _db
        .collection('Weight')
        .doc(weight.id)
        .set(weight.createMap());
  }

  Stream<List<Weight>> getWeight() {
    return _db.collection('Weight')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot
        .docs
        .map((document) => Weight.fromFirestore(document.data()))
        .toList());
  }

   signin() async {
    UserCredential userCredential = await _auth.signInAnonymously();
    return userCredential.user;
  }

   Future<bool> checkUser()async{
      if(_auth.currentUser!=null){
        return true;
      }else{
        return false;
      }
    }

  String createId(){
    return _db.collection("Weight").doc().id;
  }

  Future<void> removeItem(String weightId) {
    return _db.collection('Weight').doc(weightId).delete();
  }

}

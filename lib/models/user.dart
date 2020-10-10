import 'package:cloud_firestore/cloud_firestore.dart';

class User {

   User(
      {this.phone,
      this.genre,
      this.id,
      this.confirmPassworld,
      this.name,
      this.email,
      this.passworld});
  
  //recuperar dados usuáro
  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    email = document['email'] as String;

  }

  String id;
  String name;
  String email;
  String phone;
  String genre;
  String passworld;
  String confirmPassworld;
  bool admin = false;


  //REFERENCIA DO USUÁRIO
  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  //REFERENCIA DO CARRINHO DO USUÁRIO
  CollectionReference get cartReference=> firestoreRef.collection('card');

  Future<void> saveData() async {

    await firestoreRef.setData(toMap());
    
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      // 'phone': phone,
      // 'genre': genre,
    };
  }

}

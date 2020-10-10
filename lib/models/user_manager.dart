import 'package:chalana_delivery/helpers/firebase_errors.dart';
import 'package:chalana_delivery/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {

  UserManager() {
    _loadCurrentUser();
  }

  User user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  bool _loading = false;
  bool get loading => _loading;

  //verificar se user esta logado
  bool get isLogged => user != null;

  //realizar cadastro
  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {

    //disparar caregamento
    loading = true;

    try {

      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.passworld);

      user.id = result.user.uid;

      this.user = user;

      //salvar dados do usuario no firebase
      await user.saveData();

      onSuccess();

    } on PlatformException catch (e) {

      onFail(getErrorString(e.code));

    }

    loading = false;

  }

  //realizar login
  Future<void> sigIn({User user, Function onFail, Function onSuccess}) async {

    try {

      loading = true;

      final AuthResult result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.passworld,
      );

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();

    } on PlatformException catch (e) {

      onFail(getErrorString(e.code));

    }

    loading = false;

  }

  //statdo de login
  set loading(bool value) {

    _loading = value;

    notifyListeners();

  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    
    //verificar se o usuario está logado
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();

    if (currentUser != null) {

      //pegar dados referente aquele usuário no firebase;
      //DocumentSnapshot se refere ao documento no database onde estão os dados referente ao usuário
      final DocumentSnapshot docUser =
          await firestore.collection('users').document(currentUser.uid).get();

      user = User.fromDocument(docUser);

      final docAdmin = await firestore.collection('admins').document(user.id).get();
      if(docAdmin.exists){
        user.admin = true;

      }

      print("is admin${user.admin}");

      //debugPrint("usuário online: ${user.name}");

      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user.admin;

  void signOut(){

    auth.signOut();

    user = null;

    notifyListeners();
    
  }

}

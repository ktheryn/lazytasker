import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../form/model/usermodel.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  UserRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _firebaseFirestore = FirebaseFirestore.instance;

  Stream<UserModel> retrieveCurrentUser() {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(uid: user.uid, name: user.displayName!, password: 'password', email: user.email!);
      } else {
        return  UserModel(uid: "uid", name: 'name', password: 'password', email: 'email');
      }
    });
  }

  Future<UserCredential?> signUp(UserModel user) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: user.email!,password: user.password!);
      verifyEmail();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> signIn(UserModel user) async {
    try {
      UserCredential userCredential = await _firebaseAuth.
      signInWithEmailAndPassword(email: user.email!, password: user.password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> verifyEmail() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

}
















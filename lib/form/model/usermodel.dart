import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String name;
  String email;
  String password;

  UserModel({required this.name, required this.password, required this.email, required this.uid});

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  UserModel.fromSnapshot(DocumentSnapshot result)
      : uid = result["uid"],
        name = result["name"],
        email = result["email"],
        password = result["password"];

  UserModel copyWith({
    String? uid,
    String? name,
    String? userName,
    String? email,
    String? password,
  }) {
    return UserModel(name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );}

  @override
  List<Object?> get props => [
    uid, name, email, password,
  ];

}
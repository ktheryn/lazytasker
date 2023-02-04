part of 'form_bloc.dart';

abstract class FormState extends Equatable {
  const FormState();
}

class FormInitial extends FormState {
  @override
  List<Object> get props => [];
}

class FormValidate extends FormState {
  final String uid;
  final String email;
  final String password;
  final String name;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFormValid;
  const FormValidate({required this.isFormValid, required this. uid, required this.email, required this.password, required this.name, required this.isEmailValid, required this.isPasswordValid});

  FormValidate copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isFormValid,
  }) {
    return FormValidate(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isFormValid: isFormValid ?? this.isFormValid,
    );}

  @override
  List<Object> get props => [
    uid, email, password, name, isEmailValid, isPasswordValid, isFormValid,
  ];
}
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/usermodel.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormValidate> {
  FormBloc() : super(FormValidate(uid: '', email: '', password: '', name: '', isEmailValid: false, isPasswordValid: false, isFormValid: false)) {

    final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    bool _isEmailValid(String email) {
      return _emailRegExp.hasMatch(email);
    }

    bool _isPasswordValid(String password) {
      if (password.length > 8) {
        return true;
      } else {
        return false;
      }
    }

    bool _isFormValid(bool password, bool email) {
      if (password == true && email == true) {
        return true;
      } else {
        return false;
      }
    }

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        uid: '',
        name: '',
        email: event.email,
        isEmailValid: _isEmailValid(event.email),
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        uid: '',
        name: '',
        password: event.password,
        isPasswordValid: _isPasswordValid(event.password),
      ));
    });

    on<FormSubmitted>((event, emit) {
      UserModel user = UserModel(
          uid: state.uid,
          email: state.email,
          password: state.password,
          name: state.name);
      if (event.value == Status.signIn) {
       emit(state.copyWith(
           isFormValid: _isFormValid(state.isPasswordValid, state.isEmailValid)));
       if (state.isFormValid) {
         print('dro');
       } else {
         print('boo');
       }
       
      } else if (event.value == Status.signUp) {
        //await _authenticateUser(event, emit, user);
      }


    });









  }
}

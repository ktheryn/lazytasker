import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazytasker/form/screen/register.dart';
import '../bloc/form_bloc.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormValidate>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                      child: Image.asset(
                        'assets/Tasker_icon.png',
                        height: 150,
                        width: 150,
                      )),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Email',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            context.read<FormBloc>().add(EmailChanged(value));
                          },
                          decoration: InputDecoration(
                            errorText: !state.isEmailValid && state.email != ''
                                ? 'Please ensure the email entered is valid'
                                : null,
                            isDense: true,
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF00ac9c),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF00ac9c),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Color(0xFF00ac9c),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Password',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value){
                            context.read<FormBloc>().add(PasswordChanged(value));
                          },
                          decoration: InputDecoration(
                            errorText: !state.isPasswordValid && state.password != ''
                                ? 'Password must be 8 characters long'
                                : null,
                            isDense: true,
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF00ac9c),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF00ac9c),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Color(0xFF00ac9c),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(
                        top: 20.0, right: 30, left: 30, bottom: 10),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF00ac9c), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          context.read<FormBloc>().add(const FormSubmitted(value: Status.signIn));
                        },
                        child: Text(
                          'Sign in',
                          style:
                          TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      }, child: Text('Sign up')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

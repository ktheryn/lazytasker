import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                    'assets/Tasker_icon.png',
                    height: 100,
                    width: 100,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Create your account', style: TextStyle(
                  color: Color(0xFF00ac9c),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
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
                        'Name',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Enter your name',
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
                        'Username',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color:Color(0xFF00ac9c),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF00ac9c),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color:Color(0xFF00ac9c),
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
                        'Email',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color:Color(0xFF00ac9c),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF00ac9c),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color:Color(0xFF00ac9c),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 20.0, right: 30, left: 30, bottom: 5),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF00ac9c), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {},
                    child: Text(
                      'Register',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('Sign in')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

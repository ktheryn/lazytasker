import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazytasker/tasking/bloc/tasker_bloc.dart';
import 'package:lazytasker/tasking/services/tasker_repository.dart';

import 'form/bloc/form_bloc.dart';
import 'form/screen/login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Checklist());
}

class Checklist extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
       providers: [
         BlocProvider(create: (context) => TaskerBloc(TaskerRepository())..add(LoadTaskEvent())),
         BlocProvider(create: (context) => FormBloc()),
       ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(
            primary: Color(0xFF00ac9c),
          ),
        ),
        home: LogInPage(),
        //TaskScreen('payload'),
      ),
    );
  }
}



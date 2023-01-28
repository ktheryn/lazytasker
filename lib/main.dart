import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazytasker/tasker_bloc.dart';
import 'package:lazytasker/tasker_repository.dart';
import 'tasker.dart';

void main() {
  runApp(Checklist());
}

class Checklist extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
       providers: [
         BlocProvider(create: (context) => TaskerBloc(TaskerRepository())..add(LoadTaskEvent())),
       ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(
            primary: Color(0xFF00ac9c),
          ),
        ),
        home: TaskScreen(String),
      ),
    );
  }
}



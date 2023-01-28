import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazytasker/tasker_bloc.dart';
import 'package:lazytasker/tasker_notification.dart';
import 'package:uuid/uuid.dart';
import 'model.dart';

class TaskScreen extends StatefulWidget {
  late String payload;

  TaskScreen(payload, {String});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final TextEditingController textFieldTaskName = TextEditingController();
  String timer = '';

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    NotifyHelper().initializeNotification(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF00ac9c),
        title: Text('Tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00ac9c),
        onPressed: () {
          buttomBar(context);
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<TaskerBloc, TaskerState>(
        builder: (context, state) {
          if (state is TaskerInitial) {
            return Center(
                child: const CircularProgressIndicator(
              color: Color(0xFF00ac9c),
            ));
          }
          if (state is TaskerLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      Task taskers = state.tasks[index];
                      return Card(
                        child: CheckboxListTile(
                            activeColor: Color(0xFF472b29),
                            title: Text(
                              state.tasks[index].taskName,
                              style: TextStyle(
                                  color: Color(0xFF472b29),
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(state.tasks[index].date),
                            secondary:
                                IconButton(onPressed: () {
                                  context
                                      .read<TaskerBloc>()
                                      .add(removeTaskEvent(task: taskers));
                                },
                                    icon: Icon(Icons.delete_forever)),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: state.tasks[index].isCheck == 'false'
                                ? false
                                : true,
                            onChanged: (newValue) async {
                              context.read<TaskerBloc>().add(clickCheckBox(task: taskers));
                            }),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          if (state is TaskerError) {
            return Center(child: Text('Something went wrong'));
          }
          return Container();
        },
      ),
    );
  }

  Future<void> buttomBar(BuildContext context) async {
    return await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    cursorColor: Color(0xFF472b29),
                    controller: textFieldTaskName,
                    decoration: InputDecoration(
                        hintText: 'Enter Task Here',
                        focusColor: Color(0xFF472b29),
                        hoverColor: Color(0xFF472b29),
                        fillColor: Color(0xFF472b29),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF472b29), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF472b29), width: 2),
                        ),
                        labelText: 'Add Tasks',
                        labelStyle: TextStyle(
                            color: Color(0xFF472b29),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: '', //Set to empty
                    //initialValue: DateTime.now().toString(),
                    style: TextStyle(
                      color: Color(0xFF00ac9c),
                    ),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    onChanged: (val) {
                      timer = val.toString();
                    },
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) => timer = val.toString(),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFFf1bc19),
                        ),
                      ),
                      child: Text('Add'),
                      onPressed: () {
                        if (textFieldTaskName.text == "") {

                        } else {
                          context.read<TaskerBloc>().add(addTaskEvent(
                              task: Task(
                                  id: Uuid().v4().toString(),
                                  taskName: textFieldTaskName.text,
                                  date: timer,
                                  isCheck: 'false')));
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFFf1bc19),
                        ),
                      ),
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

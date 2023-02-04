import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazytasker/tasking/bloc/tasker_bloc.dart';
import 'package:lazytasker/tasking/services/tasker_notification.dart';
import 'package:uuid/uuid.dart';
import '../model/model.dart';

class TaskScreen extends StatefulWidget {
  late String payload;

  TaskScreen(payload, {Key? key, String}) : super(key: key);

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
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Color(0xFF00ac9c),
          width: MediaQuery.of(context).size.width / 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/Tasker_icon.png'),
                    radius: 30,
                  ),
                ),
                Text(
                  'Hello There!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Color(0xFF00ac9c),
                        ),
                        SizedBox(
                            width: 100,
                            height: 20,
                            child: FittedBox(
                                child: Center(
                                    child: Text('Home',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF00ac9c)))))),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Text('Save Backup Data'),
                              ],
                            ),
                            content: Text(
                                'Send your data to to cloud for back up purposes'),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Confirm')),
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  child: Card(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_circle_up_outlined,
                            color: Color(0xFF00ac9c),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                              width: 100,
                              height: 50,
                              child: FittedBox(
                                  child: Text(
                                'Save Backup Data',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF00ac9c),
                                ),
                              ))),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_circle_down_outlined,
                        color: Color(0xFF00ac9c),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          height: 50,
                          width: 100,
                          child: FittedBox(
                              child: Text(
                            'Get Backup Data',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF00ac9c),
                            ),
                          ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        color: Color(0xFF00ac9c),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          height: 50,
                          width: 100,
                          child: FittedBox(
                              child: Text(
                            'Account Settings',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF00ac9c),
                            ),
                          ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
                            subtitle: Text(state.tasks[index].taskDate),
                            secondary: IconButton(
                                onPressed: () {
                                  context
                                      .read<TaskerBloc>()
                                      .add(removeTaskEvent(task: taskers));
                                },
                                icon: Icon(Icons.delete_forever)),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: state.tasks[index].isMarkCompleted == 'false'
                                ? false
                                : true,
                            onChanged: (newValue) async {
                              context
                                  .read<TaskerBloc>()
                                  .add(clickCheckBox(task: taskers));
                              context
                                  .read<TaskerBloc>()
                                  .add(saveCheckBox(task: taskers));
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
                        hintText: 'Enter tasking Here',
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
                                  taskDate: timer,
                                  isMarkCompleted: 'false')));
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

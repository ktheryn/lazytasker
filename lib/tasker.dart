import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskScreen extends StatefulWidget {
  late String payload;

  TaskScreen(payload, {String});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<String> tasks = [];
  final TextEditingController textFieldController = TextEditingController();
  bool isChanged = false;
  List<bool> isChangedList =
  []; //TODO 1: created a list to check if boxes are checked
  String timer = '';
  List<String> timerlist = [];
  int timeDiffInSeconds = 0;
  late FlutterLocalNotificationsPlugin fltrNotification;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  saveStringToSF(List<String> value) async {
    print("Task List : $value");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('stringValue', value);
  }

  Future<List<String>?> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('stringValue');
  }

  saveDateToSF(List<String> value2) async {
    print("Date List : $value2");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('dateValue', value2);
  }

  Future<List<String>?> getDateValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('dateValue');
  }

  saveBoolToSF(String value3) async {
    print("bool List : $value3");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('boolValue', value3);
  }

  Future<String?> getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('boolValue');
  }


  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('icons');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid, iOS: null, macOS: null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    getStringValuesSF().then((value) {
      setState(() {
        tasks = value!;
      });
    });

    getDateValuesSF().then((timer) {
      setState(() {
        timerlist = timer!;
      });
    });

    getBoolValuesSF().then((value) {
      var resultHere = json.decode(
          value!); //converts String stored as "[false,true,false]" to bool dynamic (not fixed size list)list
      setState(() {
        isChangedList = resultHere.cast<
            bool>(); //converts dynamic list to bool list and assigns to isChangedList
      });
    });
  }

  Future selectNotification(payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    //await Navigator.push(context, MaterialPageRoute<void>(builder: (context) => TaskScreen(payload)),);
    await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TaskScreen(payload)), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: getItems(),
            ),
          ),
        ],
      ),
    );
  }

  void addtolist(String value) {
    setState(() {
      print(DateTime.parse(timer).toLocal());
      tasks.add(value);
      timerlist.add(timer);
      isChangedList.add(
          false); //TODO 2: Assign false as default value when each task is added
    });
  }

  void deletetasks(int pos) {
    setState(() {
      tasks.removeAt(pos);
      timerlist.removeAt(pos);
      isChangedList.removeAt(pos);
      flutterLocalNotificationsPlugin.cancel(pos);
    });
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '0',
      'channel name',
      'channel description',
      icon: 'flutter_devs',
      largeIcon:
      DrawableResourceAndroidBitmap('icons'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<BottomSheet> buttomBar(BuildContext context) async {
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
                    controller: textFieldController,
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
                    style: TextStyle(color: Color(0xFF00ac9c),),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),

                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    onChanged: (val) {
                      print(val);
                      timer = val.toString();
                    },
                    //(val) => timer = val.toString(), //Just converted val to string
                    //also timer needs to be a list same as tasks and isChanged

                    validator: (val) {
                      print(val);
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
                        if (textFieldController.text == "") {
                          //TODO: Added a if case to check if field is empty before adding
                          print("empty");
                        } else {
                          print("inside Adding block");
                          print("Now time");
                          print(DateTime.now()); //current
                          print("Entered");
                          print(DateFormat("yyyy-MM-dd HH:mm")
                              .parse(timer, false));
                          print("Diff");
                          print((DateFormat("yyyy-MM-dd HH:mm")
                              .parse(timer, false))
                              .difference(DateTime.now())
                              .inSeconds);
                          DateTime date1 = DateTime.now(),
                              date2 = DateFormat("yyyy-MM-dd HH:mm")
                                  .parse(timer, false);
                          timeDiffInSeconds =
                              (date2).difference(date1).inSeconds;
                          print("Task length :");
                          print(tasks.length);
                          showNotification(
                              timeDiffInSeconds,
                              tasks.length,
                              textFieldController
                                  .text, timer.toString()); //pass the seconds here and id assigned will be the serial number of current task
                          //scheduleNotification();
                          addtolist(textFieldController.text);
                          saveStringToSF(tasks);
                          saveDateToSF(timerlist);
                          saveBoolToSF(isChangedList.toString());
                          Navigator.of(context).pop();
                          textFieldController.clear();
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

  Widget buildTodoItem(String title, int pos, String timer) {
    return GestureDetector(
      onLongPressStart: (details) {
        deletetasks(pos);
        saveStringToSF(tasks);
        saveDateToSF(timerlist);
        saveBoolToSF(isChangedList.toString());
      },
      child: CheckboxListTile(
          activeColor: Color(0xFF472b29),
          title: Text(title,style: TextStyle(color: Color(0xFF472b29),fontWeight: FontWeight.bold),),
          subtitle: Text(timer),
          controlAffinity: ListTileControlAffinity.leading,
          //value: isChanged,
          value: isChangedList[pos], //TODO 3A: changed to list variable
          onChanged: (newValue) {
            setState(() {
              isChangedList[pos] =
              !isChangedList[pos];
              saveBoolToSF(isChangedList.toString());//TODO 3B: changed to list variable
            });
          }),
    );
  }

  List<Widget> getItems() {
    final List<Widget> todoWidgetsy = <Widget>[];
    for (int i = 0; i < tasks.length; i++) {
      todoWidgetsy.add(buildTodoItem(
          tasks[i], i, timerlist[i])); //TODO 4: Passing position as i
    }
    return todoWidgetsy;
  }

  showNotification(int secondsToBeAdded, int idValue, String titleValue, String dateValue) async {
    double minutesToPrint = 0;
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        idValue,
        titleValue,
        dateValue,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: (secondsToBeAdded))),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
    minutesToPrint = secondsToBeAdded / 60;
    print(
        "Notification scheduled for $minutesToPrint minutes or $secondsToBeAdded seconds from now.");
  }
}

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String taskName;
  final String date;
  final String isMarkCompleted;
  final String id;

  Task(
      {required this.taskName,
      required this.date,
      required this.isMarkCompleted,
      required this.id});

  Task.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        taskName = result["taskName"],
        date = result["taskDate"],
        isMarkCompleted = result["isCheck"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDate': date,
      'isCheck': isMarkCompleted,
    };
  }

  Task copyWith({
    String? taskName,
    String? isCheck,
    String? date,
    String? id,
  }) {
    return Task(
        taskName: taskName ?? this.taskName,
        date: date ?? this.date,
        isMarkCompleted: isCheck ?? this.isMarkCompleted,
        id: id ?? this.id);
  }



  @override
  // TODO: implement props
  List<Object?> get props => [taskName, date, isMarkCompleted];

  static List<Task> tasks = [
    Task(
      id: Uuid().v4().toString(),
      taskName: 'Sample Task ',
      date: '2023-01-24 06:43',
      isMarkCompleted: 'false',
    ),
  ];
}

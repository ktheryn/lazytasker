import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String taskName;
  final String taskDate;
  final String isMarkCompleted;
  final String id;

  Task(
      {required this.taskName,
      required this.taskDate,
      required this.isMarkCompleted,
      required this.id});

  Task.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        taskName = result["taskName"],
        taskDate = result["taskDate"],
        isMarkCompleted = result["isCheck"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDate': taskDate,
      'isCheck': isMarkCompleted,
    };
  }

  Task.fromSnapshot(DocumentSnapshot result)
      : id = result["id"],
        taskName = result["taskName"],
        taskDate = result["taskDate"],
        isMarkCompleted = result["isCheck"];

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDate': taskDate,
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
        taskDate: date ?? this.taskDate,
        isMarkCompleted: isCheck ?? this.isMarkCompleted,
        id: id ?? this.id);
  }


  @override
  // TODO: implement props
  List<Object?> get props => [taskName, taskDate, isMarkCompleted];

  static List<Task> tasks = [
    Task(
      id: Uuid().v4().toString(),
      taskName: 'Sample tasking ',
      taskDate: '2023-01-24 06:43',
      isMarkCompleted: 'false',
    ),
  ];
}

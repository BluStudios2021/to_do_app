import 'package:hive/hive.dart';

part 'task_new.g.dart';

@HiveType(typeId: 1)
class TaskNew {
  @HiveField(0)
  bool checked = false;

  @HiveField(1)
  String header = '';

  @HiveField(2)
  String body = '';

  @HiveField(3)
  bool marked = false;
}

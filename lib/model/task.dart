import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  bool checked = false;

  @HiveField(1)
  String header = '';

  @HiveField(2)
  String body = '';
}

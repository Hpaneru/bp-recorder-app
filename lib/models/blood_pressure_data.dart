import 'package:hive/hive.dart';

part 'blood_pressure_data.g.dart';

@HiveType(typeId: 0)
class BloodPressure extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late int date;
  @HiveField(2)
  late String leftHand;
  @HiveField(3)
  late String rightHand;
}

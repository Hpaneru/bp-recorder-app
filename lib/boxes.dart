import 'package:bp_record/models/blood_pressure_data.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<BloodPressure> getBloodPressureRecords() =>
      Hive.box<BloodPressure>('blood_pressure_data');
}

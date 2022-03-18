// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodPressureAdapter extends TypeAdapter<BloodPressure> {
  @override
  final int typeId = 0;

  @override
  BloodPressure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodPressure()
      ..id = fields[0] as int
      ..date = fields[1] as int
      ..leftHand = fields[2] as String
      ..rightHand = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, BloodPressure obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.leftHand)
      ..writeByte(3)
      ..write(obj.rightHand);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

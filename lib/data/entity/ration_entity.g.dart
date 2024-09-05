// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ration_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RationEntityAdapter extends TypeAdapter<RationEntity> {
  @override
  final int typeId = 0;

  @override
  RationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RationEntity(
      breakfast: (fields[0] as List).cast<Recipe>(),
      lunch: (fields[1] as List).cast<Recipe>(),
      dinner: (fields[2] as List).cast<Recipe>(),
      snack: (fields[3] as List).cast<Recipe>(),
      water: fields[4] as double,
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RationEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.breakfast)
      ..writeByte(1)
      ..write(obj.lunch)
      ..writeByte(2)
      ..write(obj.dinner)
      ..writeByte(3)
      ..write(obj.snack)
      ..writeByte(4)
      ..write(obj.water)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

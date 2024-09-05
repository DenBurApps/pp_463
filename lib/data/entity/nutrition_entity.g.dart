// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NutritionEntityAdapter extends TypeAdapter<NutritionEntity> {
  @override
  final int typeId = 3;

  @override
  NutritionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionEntity(
      carbs: fields[0] as int,
      protein: fields[1] as int,
      fats: fields[2] as int,
      calories: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NutritionEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.carbs)
      ..writeByte(1)
      ..write(obj.protein)
      ..writeByte(2)
      ..write(obj.fats)
      ..writeByte(3)
      ..write(obj.calories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

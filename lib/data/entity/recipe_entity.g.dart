// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeEntityAdapter extends TypeAdapter<RecipeEntity> {
  @override
  final int typeId = 2;

  @override
  RecipeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeEntity(
      name: fields[0] as String,
      time: fields[1] as DateTime,
      ingredients: (fields[2] as List).cast<String>(),
      carbs: fields[3] as int,
      protein: fields[4] as int,
      fats: fields[5] as int,
      calories: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.ingredients)
      ..writeByte(3)
      ..write(obj.carbs)
      ..writeByte(4)
      ..write(obj.protein)
      ..writeByte(5)
      ..write(obj.fats)
      ..writeByte(6)
      ..write(obj.calories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'town.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TownAdapter extends TypeAdapter<Town> {
  @override
  final int typeId = 0;

  @override
  Town read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Town(
      fields[1] as String,
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Town obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.woeid)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TownAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

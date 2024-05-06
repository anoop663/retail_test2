// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RetailModel2Adapter extends TypeAdapter<RetailModel2> {
  @override
  final int typeId = 2;

  @override
  RetailModel2 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RetailModel2(
      name: fields[0] as String,
      phone: fields[1] as String,
      address: fields[2] as String,
      id: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RetailModel2 obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetailModel2Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

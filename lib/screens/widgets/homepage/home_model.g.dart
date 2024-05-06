// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesGraphModelAdapter extends TypeAdapter<SalesGraphModel> {
  @override
  final int typeId = 15;

  @override
  SalesGraphModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesGraphModel(
      customerName: fields[0] as String,
      salesValue: fields[1] as String,
      id: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SalesGraphModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.customerName)
      ..writeByte(1)
      ..write(obj.salesValue)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesGraphModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

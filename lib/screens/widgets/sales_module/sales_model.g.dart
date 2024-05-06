// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesModelAdapter extends TypeAdapter<SalesModel> {
  @override
  final int typeId = 9;

  @override
  SalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesModel(
      customer: fields[0] as String,
      products: (fields[1] as List).cast<ProductSale>(),
      grand: fields[2] as String,
      createddate: fields[4] as DateTime?,
      id: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SalesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.customer)
      ..writeByte(1)
      ..write(obj.products)
      ..writeByte(2)
      ..write(obj.grand)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.createddate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductSaleAdapter extends TypeAdapter<ProductSale> {
  @override
  final int typeId = 10;

  @override
  ProductSale read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductSale(
      name: fields[0] as String,
      nos: fields[1] as String,
      total: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductSale obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.nos)
      ..writeByte(2)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductSaleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

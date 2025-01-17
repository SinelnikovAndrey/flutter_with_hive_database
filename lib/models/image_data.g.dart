// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageDataAdapter extends TypeAdapter<ImageData> {
  @override
  final int typeId = 0;

  @override
  ImageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageData(
      imagePath: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atm_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtmRequest _$AtmRequestFromJson(Map<String, dynamic> json) => AtmRequest(
      (json['latitud'] as num).toDouble(),
      (json['longitud'] as num).toDouble(),
      json['fecha'] as String,
      (json['radio'] as num).toDouble(),
    );

Map<String, dynamic> _$AtmRequestToJson(AtmRequest instance) =>
    <String, dynamic>{
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'fecha': instance.fecha,
      'radio': instance.radio,
    };

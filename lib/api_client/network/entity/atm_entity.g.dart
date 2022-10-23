// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atm_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtmEntity _$AtmEntityFromJson(Map<String, dynamic> json) => AtmEntity(
      json['atm_id'] as String,
      (json['latitud'] as num).toDouble(),
      (json['longitud'] as num).toDouble(),
      json['status'] as bool,
      json['sitio'] as String,
      json['calle'] as String,
      json['estado'] as String,
      json['ciudad'] as String,
      json['colonia'] as String,
    );

Map<String, dynamic> _$AtmEntityToJson(AtmEntity instance) => <String, dynamic>{
      'atm_id': instance.atmId,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'status': instance.status,
      'sitio': instance.sitio,
      'calle': instance.calle,
      'estado': instance.estado,
      'ciudad': instance.ciudad,
      'colonia': instance.colonia,
    };

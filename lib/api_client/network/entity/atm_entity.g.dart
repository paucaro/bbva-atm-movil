// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atm_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtmEntity _$AtmEntityFromJson(Map<String, dynamic> json) => AtmEntity(
      (json['latitud'] as num).toDouble(),
      (json['longitud'] as num).toDouble(),
      json['sitio'] as String,
      json['calle'] as String,
      json['estado'] as String,
      json['ciudad'] as String,
      json['colonia'] as String,
      json['total_atms'] as int,
      json['total_atms_falla'] as int,
    );

Map<String, dynamic> _$AtmEntityToJson(AtmEntity instance) => <String, dynamic>{
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'sitio': instance.sitio,
      'calle': instance.calle,
      'estado': instance.estado,
      'ciudad': instance.ciudad,
      'colonia': instance.colonia,
      'total_atms': instance.totalAtms,
      'total_atms_falla': instance.totalAtmsFalla,
    };

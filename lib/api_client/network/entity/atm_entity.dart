import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'atm_entity.g.dart';

@JsonSerializable()
class AtmEntity {
  @JsonKey(name: 'latitud')
  final double latitud;

  @JsonKey(name: 'longitud')
  final double longitud;

  @JsonKey(name: 'sitio')
  final String sitio;

  @JsonKey(name: 'calle')
  final String calle;

  @JsonKey(name: 'estado')
  final String estado;

  @JsonKey(name: 'ciudad')
  final String ciudad;

  @JsonKey(name: 'colonia')
  final String colonia;

  @JsonKey(name: 'total_atms')
  final int totalAtms;

  @JsonKey(name: 'total_atms_falla')
  final int totalAtmsFalla;

  AtmEntity(
    this.latitud,
    this.longitud,
    this.sitio,
    this.calle,
    this.estado,
    this.ciudad,
    this.colonia,
    this.totalAtms,
    this.totalAtmsFalla,
  );

  factory AtmEntity.fromJson(Map<String, dynamic> json) =>
      _$AtmEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AtmEntityToJson(this);
}

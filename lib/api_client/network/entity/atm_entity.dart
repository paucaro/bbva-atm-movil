import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'atm_entity.g.dart';

@JsonSerializable()
class AtmEntity {
  @JsonKey(name: 'atm_id')
  final String atmId;

  @JsonKey(name: 'latitud')
  final double latitud;

  @JsonKey(name: 'longitud')
  final double longitud;

  @JsonKey(name: 'status')
  final bool status;

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

  AtmEntity(
    this.atmId,
    this.latitud,
    this.longitud,
    this.status,
    this.sitio,
    this.calle,
    this.estado,
    this.ciudad,
    this.colonia,
  );

  factory AtmEntity.fromJson(Map<String, dynamic> json) =>
      _$AtmEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AtmEntityToJson(this);
}

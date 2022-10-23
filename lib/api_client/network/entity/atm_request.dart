import 'package:json_annotation/json_annotation.dart';

part 'atm_request.g.dart';

@JsonSerializable()
class AtmRequest {
  @JsonKey(name: 'latitud')
  final double latitud;

  @JsonKey(name: 'longitud')
  final double longitud;

  @JsonKey(name: 'fecha')
  final String fecha;

  @JsonKey(name: 'radio')
  final double radio;

  AtmRequest(this.latitud, this.longitud, this.fecha, this.radio);

  factory AtmRequest.fromJson(Map<String, dynamic> json) =>
      _$AtmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AtmRequestToJson(this);
}

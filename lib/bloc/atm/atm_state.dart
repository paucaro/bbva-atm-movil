part of 'atm_bloc.dart';

enum AtmStatus { initial, success, failure }

class AtmState extends Equatable {
  const AtmState({
    this.status = AtmStatus.initial,
    this.atms = const <AtmEntity>[],
  });

  final AtmStatus status;
  final List<AtmEntity> atms;

  AtmState copyWith({
    AtmStatus? status,
    List<AtmEntity>? atms,
  }) {
    return AtmState(
      status: status ?? this.status,
      atms: atms ?? this.atms,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, atms: ${atms.length} }''';
  }

  @override
  List<Object?> get props => [status, atms];
}

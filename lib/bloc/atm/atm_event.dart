part of 'atm_bloc.dart';

abstract class AtmEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AtmFetched extends AtmEvent {
  AtmFetched({required this.request});

  final AtmRequest request;

  @override
  List<Object?> get props => [request];
}

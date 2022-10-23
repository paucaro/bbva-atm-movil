import 'package:bloc/bloc.dart';
import 'package:dashrock/api_client/network/entity/atm_entity.dart';
import 'package:dashrock/api_client/network/entity/atm_request.dart';
import 'package:dashrock/repository/atm_repository.dart';
import 'package:equatable/equatable.dart';

part 'atm_event.dart';
part 'atm_state.dart';

class AtmBloc extends Bloc<AtmEvent, AtmState> {
  AtmBloc({required this.atmRepository}) : super(const AtmState()) {
    on<AtmFetched>(_onAtmFetched);
  }

  final AtmRepository atmRepository;

  Future<void> _onAtmFetched(AtmFetched event, Emitter<AtmState> emit) async {
    try {
      final atms = await atmRepository.getAtms(event.request);
      return emit(state.copyWith(status: AtmStatus.success, atms: atms));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: AtmStatus.failure));
    }
  }
}

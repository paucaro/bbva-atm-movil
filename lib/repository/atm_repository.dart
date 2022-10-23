import 'package:dashrock/api_client/atm/atm_api.dart';
import 'package:dashrock/api_client/network/entity/atm_entity.dart';
import 'package:dashrock/api_client/network/entity/atm_request.dart';

class AtmRepository {
  const AtmRepository({
    required AtmApi atmApi,
  }) : _atmApi = atmApi;

  final AtmApi _atmApi;

  Future<List<AtmEntity>> getAtms(AtmRequest data) => _atmApi.fetchAtm(data);
}

import 'package:dashrock/api_client/network/entity/atm_entity.dart';
import 'package:dashrock/api_client/network/entity/atm_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'atm_api.g.dart';

@RestApi(baseUrl: 'https://dashrock-api-ffsw7gfw5q-uc.a.run.app')
abstract class AtmApi {
  factory AtmApi(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
      // receiveTimeout: 3000,
      // connectTimeout: 3000,
      contentType: 'application/json',
      // headers: {
      //   'Authorization': 'Basic ',
      //   'X-ApiKey': '==',
      //   'Content-Type': 'Application/json'
      // },
    );
    return _AtmApi(dio, baseUrl: baseUrl);
  }

  @POST('/api/v1/atm/nearby')
  Future<List<AtmEntity>> fetchAtm(
    @Body() AtmRequest data,
  );
}

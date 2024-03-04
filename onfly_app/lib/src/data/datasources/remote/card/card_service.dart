import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'card_service.g.dart';

@RestApi()
abstract class CardService {
  factory CardService(Dio dio, {String baseUrl}) = _CardService;

/*
  @GET('/card-info') 
  @GET('/card-history') 
  Aqui entraria a chamada para API de busca de infos do cartao
  e também do extrato de compras
*/

}

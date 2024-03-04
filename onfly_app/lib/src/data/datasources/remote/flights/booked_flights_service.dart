import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'booked_flights_service.g.dart';

@RestApi()
abstract class BookedFlightsService {
  factory BookedFlightsService(Dio dio, {String baseUrl}) = _BookedFlightsService;

/*
  @GET('/flights') 
  Aqui entraria a chamada para API de busca de voos
  e de qualquer outra chamada que fosse necessária
*/

}

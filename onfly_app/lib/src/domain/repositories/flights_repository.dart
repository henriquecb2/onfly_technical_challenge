import '../../utils/resources/data_state.dart';
import '../models/requests/booked_flights_request.dart';
import '../models/responses/booked_flights_response.dart';

abstract class FlightsRepository {
  Future<DataState<BookedFlightsResponse>> getFlights({
    required BookedFlightsRequest request,
  });
}
import '../../domain/models/flight_model.dart';
import '../../domain/models/requests/booked_flights_request.dart';
import '../../domain/models/responses/booked_flights_response.dart';
import '../../domain/repositories/flights_repository.dart';
import '../../utils/resources/data_state.dart';
import '../base/base_api_repository.dart';
import '../datasources/remote/flights/booked_flights_service.dart';

class FlightsRepositoryImpl extends BaseApiRepository implements FlightsRepository {
  final BookedFlightsService _service;

  FlightsRepositoryImpl(this._service);

  @override
  Future<DataState<BookedFlightsResponse>> getFlights({
    required BookedFlightsRequest request,
  }) async {
    return Future.value(DataSuccess(_generateMocked()));
  }

  // Método para simular o retorno da API
  BookedFlightsResponse _generateMocked() {
    List<Flight> mockedFlights = [
      const Flight(
        id: 'A654',
        airline: 'Azul',
        from: 'Rio de Janeiro - GIG',
        to: 'Sao Paulo - GRU',
        departure: '14/03/2024 - 13h00',
        arrival: '14/03/2024 - 14h10',
        duration: '01h10',
        price: 'R\$254.50',
        gate: '07',
      ),
      const Flight(
        id: 'A789',
        airline: 'Azul',
        from: 'Sao Paulo - GRU',
        to: 'Rio de Janeiro - GIG',
        departure: '24/03/2024 - 17h45',
        arrival: '24/03/2024 - 18h55',
        duration: '01h10',
        price: 'R\$275.00',
        gate: '07',
      ),
      const Flight(
        id: 'G774',
        airline: 'Gol',
        from: 'Belo Horizonte - CNF',
        to: 'Recife - REC',
        departure: '17/05/2024 - 13h00',
        arrival: '17/05/2024 - 15h00',
        duration: '02h00',
        price: 'R\$747.00',
        gate: '21',
      ),
      const Flight(
        id: 'L885',
        airline: 'Latam',
        from: 'Recife - REC',
        to: 'Belo Horizonte - CNF',
        departure: '27/05/2024 - 05h00',
        arrival: '17/05/2024 - 07h00',
        duration: '02h00',
        price: 'R\$874.27',
        gate: '30',
      ),
    ];

    return BookedFlightsResponse(flights: mockedFlights);
  }

}
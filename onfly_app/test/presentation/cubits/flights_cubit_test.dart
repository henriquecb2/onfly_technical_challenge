import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/src/domain/models/flight_model.dart';
import 'package:onfly_app/src/domain/models/requests/booked_flights_request.dart';
import 'package:onfly_app/src/domain/models/responses/booked_flights_response.dart';
import 'package:onfly_app/src/domain/repositories/flights_repository.dart';
import 'package:onfly_app/src/presentation/cubits/flights/cubit/flights_cubit.dart';
import 'package:onfly_app/src/utils/resources/data_state.dart';

class MockFlightsRepository extends Mock implements FlightsRepository {}

void main() {
  late FlightsCubit flightsCubit;
  late MockFlightsRepository mockRepository;

  setUp(() {
    mockRepository = MockFlightsRepository();
    flightsCubit = FlightsCubit(mockRepository);
    registerFallbackValue(BookedFlightsRequest());
  });

  tearDown(() {
    flightsCubit.close();
  });

  group('getFlights', () {
    const flight = Flight(
      id: 'A654',
      airline: 'Azul',
      from: 'Rio de Janeiro - GIG',
      to: 'Sao Paulo - GRU',
      departure: '14/03/2024 - 13h00',
      arrival: '14/03/2024 - 14h10',
      duration: '01h10',
      price: 'R\$254.50',
      gate: '07',
    );

    test('should emit FlightsSuccess when repository returns DataSuccess', () async {
      when(() => mockRepository.getFlights(request: any(named: 'request')))
            .thenAnswer((_) async => Future.value(DataSuccess(BookedFlightsResponse(flights: [flight]))));

      await flightsCubit.getFlights();

      expect(flightsCubit.state, isA<FlightsSuccess>());
      expect((flightsCubit.state as FlightsSuccess).flights, [flight]);
    });

    test('should emit FlightsError when repository returns DataError', () async {
      final error = DioError(requestOptions: RequestOptions(path: ''), error: 'Error');
      when(() =>mockRepository.getFlights(request: any(named: 'request')))
          .thenAnswer((_) async => DataError(error));

      await flightsCubit.getFlights();

      expect(flightsCubit.state, isA<FlightsError>());
      expect((flightsCubit.state as FlightsError).error, error);
    });
  });
}
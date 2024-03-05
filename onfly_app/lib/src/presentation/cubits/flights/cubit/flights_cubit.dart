import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/models/flight_model.dart';

import '../../../../domain/models/requests/booked_flights_request.dart';
import '../../../../domain/repositories/flights_repository.dart';
import '../../../../utils/resources/data_state.dart';
import '../../base/base_cubit.dart';

part 'flights_state.dart';

class FlightsCubit extends BaseCubit<FlightsState> {
  final FlightsRepository _repository;
  
  FlightsCubit(this._repository) : super(const FlightsLoading());

  Future<void> getFlights() async {
    if(isBusy) return;

    await run(() async {
        final response = await _repository.getFlights(
          request: BookedFlightsRequest()
        );

        if(response is DataSuccess) {
          emit(FlightsSuccess(flights: response.data!.flights));
        } else if(response is DataError) {
          emit(FlightsError(error: response.error));
        }
    });
  }
}

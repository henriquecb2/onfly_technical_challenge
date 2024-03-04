// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'flights_cubit.dart';

abstract class FlightsState extends Equatable {
  final List<Flight> flights;
  final bool noMoreData;
  final DioError? error;

  const FlightsState({
    this.flights = const [],
    this.noMoreData = true,
    this.error,
  });

  @override
  List<Object?> get props => [flights, noMoreData, error];
}

class FlightsLoading extends FlightsState {
  const FlightsLoading();
}

class FlightsSuccess extends FlightsState {
  const FlightsSuccess({super.flights});
}

class FlightsError extends FlightsState {
  const FlightsError({super.error});
}

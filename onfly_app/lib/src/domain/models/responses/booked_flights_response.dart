import 'package:equatable/equatable.dart';

import '../flight_model.dart';

class BookedFlightsResponse extends Equatable {
  final List<Flight> flights;

  BookedFlightsResponse({required this.flights});

  factory BookedFlightsResponse.fromMap(Map<String, dynamic> map) {
    return BookedFlightsResponse(
      flights: List<Flight>.from(map['flights']?.map((x) => Flight.fromMap(x))),
    );
  }

  @override
  List<Object?> get props => [flights];
}
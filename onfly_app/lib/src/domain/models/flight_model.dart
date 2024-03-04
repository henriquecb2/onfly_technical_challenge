import 'package:equatable/equatable.dart';

class Flight extends Equatable {
  final String id;
  final String airline;
  final String from;
  final String to;
  final String departure;
  final String arrival;
  final String duration;
  final String price;
  final String gate;

  const Flight({
    required this.id,
    required this.airline,
    required this.from,
    required this.to,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.price,
    required this.gate,
  });

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      id: map['id'],
      airline: map['airline'],
      from: map['from'],
      to: map['to'],
      departure: map['departure'],
      arrival: map['arrival'],
      duration: map['duration'],
      price: map['price'],
      gate: map['gate'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        airline,
        from,
        to,
        departure,
        arrival,
        duration,
        price,
        gate,
      ];
}
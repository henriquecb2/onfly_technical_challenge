import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onfly_app/src/domain/models/flight_model.dart';
import 'package:onfly_app/src/presentation/widgets/flights/flight_card_widget.dart';

void main() {
  testWidgets(
      'GIVEN a flight '
      'WHEN FlightCardWidget is built '
      'THEN it should display flight information', (WidgetTester tester) async {
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

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlightCardWidget(flight: flight),
        ),
      ),
    );

    expect(
        find.text('Rio de Janeiro - GIG -> Sao Paulo - GRU'), findsOneWidget);
    expect(find.text('Número do voo: A654'), findsOneWidget);
    expect(
        find.text('Horário de embarque: 14/03/2024 - 13h00'), findsOneWidget);
    expect(find.text('Chegada: 14/03/2024 - 14h10'), findsOneWidget);
    expect(find.text('Portão: 07'), findsOneWidget);
    expect(find.text('Cia: Azul'), findsOneWidget);
  });
}

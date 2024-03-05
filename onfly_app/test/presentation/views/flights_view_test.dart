import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:onfly_app/src/domain/repositories/flights_repository.dart';
import 'package:onfly_app/src/presentation/cubits/card/cubit/card_cubit.dart';
import 'package:onfly_app/src/presentation/cubits/flights/cubit/flights_cubit.dart';
import 'package:onfly_app/src/presentation/views/flights_view.dart';
import 'package:onfly_app/src/presentation/widgets/flights/flight_card_widget.dart';

import '../../mocks/flights_response_mock.dart';

class MockFlightsRepository extends Mock implements FlightsRepository {}

class MockFlightsCubit extends MockCubit<FlightsState>
    implements FlightsCubit {}

class CardStateFake extends Fake implements CardState {}

void main() {
  group('FlightsView', () {
    late FlightsCubit flightsCubit;

    setUp(() {
      flightsCubit = MockFlightsCubit();

      when(() => flightsCubit.getFlights())
          .thenAnswer((invocation) => Future.value());
    });

    testWidgets(
        'GIVEN a flight view widget '
        'WHEN flight state is FlightsLoading '
        'THEN it should display a CircularProgressIndicator',
        (WidgetTester tester) async {
      when(() => flightsCubit.state).thenReturn(const FlightsLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => flightsCubit,
            child: FlightsView(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'GIVEN a flight view widget '
        'WHEN flight state is FlightsError '
        'THEN it should display an error message', (WidgetTester tester) async {
      when(() => flightsCubit.state).thenReturn(const FlightsError());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => flightsCubit,
            child: FlightsView(),
          ),
        ),
      );

      expect(find.byType(Text), findsNWidgets(2));
    });

    testWidgets(
        'GIVEN a flight view widget '
        'WHEN flight state is FlightsSuccess '
        'THEN it should display a list of flights',
        (WidgetTester tester) async {
      when(() => flightsCubit.state)
          .thenReturn(FlightsSuccess(flights: mockedFlights));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => flightsCubit,
            child: FlightsView(),
          ),
        ),
      );

      expect(find.byType(FlightCardWidget), findsAtLeastNWidgets(1));
    });
  });
}

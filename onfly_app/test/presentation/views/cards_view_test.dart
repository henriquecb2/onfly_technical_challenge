import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:onfly_app/src/domain/repositories/card_repository.dart';
import 'package:onfly_app/src/presentation/cubits/card/cubit/card_cubit.dart';
import 'package:onfly_app/src/presentation/views/cards_view.dart';
import 'package:onfly_app/src/presentation/widgets/card/card_info_widget.dart';

import '../../mocks/card_response_mock.dart';

class MockCardRepository extends Mock implements CardRepository {}

class MockCardCubit extends MockCubit<CardState> implements CardCubit {}

class CardStateFake extends Fake implements CardState {}

void main() {
  group('CardsView', () {
    late CardCubit cardCubit;

    setUp(() {
      registerFallbackValue(CardStateFake());
      cardCubit = MockCardCubit();

      when(() => cardCubit.getCard())
          .thenAnswer((invocation) => Future.value(cardMock));
    });

    testWidgets(
        'GIVEN a card view widget '
        'WHEN card state is CardLoading '
        'THEN it should display a CircularProgressIndicator',
        (WidgetTester tester) async {
      when(() => cardCubit.state).thenReturn(const CardLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => cardCubit,
            child: CardsView(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'GIVEN a card view widget '
        'WHEN card state is CardError '
        'THEN it should display an error message', (WidgetTester tester) async {
      when(() => cardCubit.state).thenReturn(const CardError());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => cardCubit,
            child: CardsView(),
          ),
        ),
      );

      expect(find.byType(Text), findsNWidgets(2));
    });

    testWidgets(
        'GIVEN a card view widget '
        'WHEN card state is CardSuccess '
        'THEN it should display a card info widget',
        (WidgetTester tester) async {
      when(() => cardCubit.state).thenReturn(CardSuccess(card: cardMock));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => cardCubit,
            child: CardsView(),
          ),
        ),
      );

      expect(find.byType(CardInfoWidget), findsOneWidget);
    });
  });
}

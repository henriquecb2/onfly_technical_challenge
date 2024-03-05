import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/src/domain/models/requests/card_request.dart';
import 'package:onfly_app/src/domain/models/responses/card_response.dart';
import 'package:onfly_app/src/domain/repositories/card_repository.dart';
import 'package:onfly_app/src/presentation/cubits/card/cubit/card_cubit.dart';
import 'package:onfly_app/src/utils/resources/data_state.dart';

import '../../mocks/card_response_mock.dart';

class MockCardRepository extends Mock implements CardRepository {}

void main() {
  group('CardCubit', () {
    late CardRepository cardRepository;
    late CardCubit cardCubit;

    setUp(() {
      cardRepository = MockCardRepository();
      cardCubit = CardCubit(cardRepository);
    registerFallbackValue(CardRequest());

    });

    tearDown(() {
      cardCubit.close();
    });

    test('initial state is CardLoading', () {
      expect(cardCubit.state, const CardLoading());
    });

    test('should emit CardSuccess when repository returns DataSuccess', () async {
        when(() => cardRepository.getCardInfos(request: any(named: 'request')))
            .thenAnswer((_) async => Future.value(DataSuccess(cardMock)));  

      await cardCubit.getCard();

      expect(cardCubit.state, isA<CardSuccess>());
      expect((cardCubit.state as CardSuccess).card, cardMock);
    });

    test('should emit CardError when repository returns DataError', () async {
      final error = DioError(requestOptions: RequestOptions(path: ''), error: 'Error');
        when(() => cardRepository.getCardInfos(request: any(named: 'request')))
            .thenAnswer((_) async => DataError(error));  

      await cardCubit.getCard();

      expect(cardCubit.state, isA<CardError>());
      expect((cardCubit.state as CardError).error, error);
    });
  });
}
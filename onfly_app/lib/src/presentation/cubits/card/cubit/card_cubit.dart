import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/requests/card_request.dart';
import '../../../../domain/models/responses/card_response.dart';
import '../../../../domain/repositories/card_repository.dart';
import '../../../../utils/resources/data_state.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  final CardRepository _repository;

  CardCubit(this._repository) : super(const CardLoading());

  Future<void> getCard() async {
    if (state is CardLoading) {
      final response = await _repository.getCardInfos(request: CardRequest());

      if (response is DataSuccess) {
        emit(CardSuccess(card: response.data!));
      } else if (response is DataError) {
        emit(CardError(error: response.error));
      }
    }
  }
}

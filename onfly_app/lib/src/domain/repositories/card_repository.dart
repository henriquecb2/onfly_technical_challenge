import '../../utils/resources/data_state.dart';

import '../models/requests/card_request.dart';
import '../models/responses/card_response.dart';

abstract class CardRepository {
  Future<DataState<CardInfosResponse>> getCardInfos({
    required CardRequest request,
  });
}
import '../../domain/models/card_model.dart';
import '../../domain/models/flight_model.dart';
import '../../domain/models/requests/booked_flights_request.dart';
import '../../domain/models/requests/card_request.dart';
import '../../domain/models/responses/booked_flights_response.dart';
import '../../domain/models/responses/card_response.dart';
import '../../domain/repositories/card_repository.dart';
import '../../utils/resources/data_state.dart';
import '../base/base_api_repository.dart';
import '../datasources/remote/card/card_service.dart';

class CardRepositoryImpl extends BaseApiRepository implements CardRepository {
  final CardService _service;

  CardRepositoryImpl(this._service);

  @override
  Future<DataState<CardInfosResponse>> getCardInfos({
    required CardRequest request,
  }) async {
    return Future.value(DataSuccess(_generateMocked()));
  }

  // Método para simular o retorno da API
  CardInfosResponse _generateMocked() {
    return CardInfosResponse(
      card: CorporateCardModel(
        company: 'OnFly',
        balance: 'R\$ 5.000,00',
        brand: 'Visa',
        currentMonth: 'Março/2024',
      ),
      cardHistoryList: List<CardHistoryListModel>.from([
        CardHistoryListModel(
          dateMonth: 'Março/2024',
          cardHistory: List<CardHistoryModel>.from([
            const CardHistoryModel(
              date: '14/03/2024',
              description: 'Compra de passagem aérea',
              value: 'R\$ 1.000,00',
            ),
            const CardHistoryModel(
              date: '14/03/2024',
              description: 'Compra de almoço',
              value: 'R\$ 1.000,00',
            ),
            const CardHistoryModel(
              date: '17/03/2024',
              description: 'Compra de jantar',
              value: 'R\$ 1.000,00',
            ),
          ]),
        ),
        CardHistoryListModel(
          dateMonth: 'Fevereiro/2024',
          cardHistory: List<CardHistoryModel>.from([
            const CardHistoryModel(
              date: '13/02/2024',
              description: 'Compra de passagem aérea da Azul',
              value: 'R\$ 1.000,00',
            ),
            const CardHistoryModel(
              date: '10/02/2024',
              description: 'Compra de passagem aérea da Gol',
              value: 'R\$ 1.000,00',
            ),
            const CardHistoryModel(
              date: '06/02/2024',
              description: 'Compra de passagem aérea da LATAM',
              value: 'R\$ 1.000,00',
            ),
          ]),
        ),
      ]),
    );
  }

}
import 'package:dio/dio.dart';
import 'package:onfly_app/src/domain/models/card_model.dart';
import 'package:onfly_app/src/domain/models/responses/card_response.dart';

var cardMock = CardInfosResponse(
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
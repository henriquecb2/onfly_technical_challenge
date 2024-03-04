import 'package:equatable/equatable.dart';

import '../card_model.dart';

class CardInfosResponse extends Equatable {
  final CorporateCardModel card;
  final List<CardHistoryListModel> cardHistoryList;

  CardInfosResponse({required this.card, required this.cardHistoryList,});

  factory CardInfosResponse.fromMap(Map<String, dynamic> map) {
    return CardInfosResponse(
      card: CorporateCardModel.fromMap(map['card']),
      cardHistoryList: List<CardHistoryListModel>.from(
          map['cardHistoryList']?.map((x) => CardHistoryListModel.fromMap(x))),
    );
  }

  @override
  List<Object?> get props => [card];
}
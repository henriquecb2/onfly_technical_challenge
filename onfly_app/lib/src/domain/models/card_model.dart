import 'package:equatable/equatable.dart';

class CardInfoModel extends Equatable {
  final CorporateCardModel corporateCard;
  final List<CardHistoryListModel> cardHistoryList;

  CardInfoModel({
    required this.corporateCard,
    required this.cardHistoryList,
  });

  factory CardInfoModel.fromMap(Map<String, dynamic> map) {
    return CardInfoModel(
      corporateCard: CorporateCardModel.fromMap(map['corporateCard']),
      cardHistoryList: List<CardHistoryListModel>.from(
          map['cardHistoryList']?.map((x) => CardHistoryListModel.fromMap(x))),
    );
  }

  @override
  List<Object?> get props => [corporateCard, cardHistoryList];
}

class CorporateCardModel extends Equatable{
  final String company;
  final String balance;
  final String brand;
  final String currentMonth;

  factory CorporateCardModel.fromMap(Map<String, dynamic> map) {
    return CorporateCardModel(
      company: map['company'],
      balance: map['balance'],
      brand: map['brand'],
      currentMonth: map['currentMonth'],
    );
  }
  CorporateCardModel({
    required this.company,
    required this.balance,
    required this.brand,
    required this.currentMonth,
  });

    @override
  List<Object?> get props => [
        company,
        balance,
        brand,
        currentMonth,
      ];
}

class CardHistoryListModel extends Equatable {
  final String dateMonth;
  final List<CardHistoryModel> cardHistory;

  const CardHistoryListModel({
    required this.dateMonth,
    required this.cardHistory,
  });

  factory CardHistoryListModel.fromMap(Map<String, dynamic> map) {
    return CardHistoryListModel(
      dateMonth: map['dateMonth'],
      cardHistory: List<CardHistoryModel>.from(
          map['cardHistory']?.map((x) => CardHistoryModel.fromMap(x))),
    );
  }

  @override
  List<Object?> get props => [dateMonth, cardHistory];
}

class CardHistoryModel extends Equatable {
  final String description;
  final String value;
  final String date;

  const CardHistoryModel({
    required this.description,
    required this.value,
    required this.date,
  });

  factory CardHistoryModel.fromMap(Map<String, dynamic> map) {
    return CardHistoryModel(
      description: map['description'],
      value: map['value'],
      date: map['date'],

    );
  }

  @override
  List<Object?> get props => [
        description,
        value,
        date,
      ];
}
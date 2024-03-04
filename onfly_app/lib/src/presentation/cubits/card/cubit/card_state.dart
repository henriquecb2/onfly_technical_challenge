part of 'card_cubit.dart';

abstract class CardState extends Equatable {
    const CardState();

  @override
  List<Object?> get props => [];
}

class CardLoading extends CardState {
  const CardLoading();
}

class CardSuccess extends CardState {
  final CardInfosResponse card;
  const CardSuccess({required this.card});
}

class CardError extends CardState {
  final DioError? error;
  const CardError({this.error});
}

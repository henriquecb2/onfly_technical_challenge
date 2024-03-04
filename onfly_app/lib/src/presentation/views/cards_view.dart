import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/card_model.dart';
import '../cubits/card/cubit/card_cubit.dart';
import '../widgets/card/card_info_widget.dart';

class CardsView extends StatefulWidget {
  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  late final CardCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<CardCubit>(context);
    _cubit.getCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu cartão'),
      ),
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is CardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CardSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Fixed widget
                  CardInfoWidget(
                    card: state.card.card,
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: const Text(
                        'Extrato do cartão',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Scrollable list of cards
                  Expanded(
                    child: _buildList(state.card.cardHistoryList),
                  ),
                ],
              ),
            );
          } else if (state is CardError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }

  Widget _buildList(List<CardHistoryListModel> cardHistoryList) {
    return ListView.builder(
      itemCount: cardHistoryList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            // Month section
            ListTile(
              title: Text(
                cardHistoryList[index].dateMonth,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Card list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cardHistoryList[index].cardHistory.length,
              itemBuilder: (context, cardIndex) {
                return Card(
                  child: ListTile(
                    title: Text(
                      cardHistoryList[index].cardHistory[cardIndex].description,
                    ),
                    subtitle: Row(children: [
                      Text(cardHistoryList[index].cardHistory[cardIndex].date),
                      const Spacer(),
                      Text(cardHistoryList[index].cardHistory[cardIndex].value),
                    ]),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

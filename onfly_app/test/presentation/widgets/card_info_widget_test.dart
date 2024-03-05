import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onfly_app/src/domain/models/card_model.dart';

import 'package:onfly_app/src/presentation/widgets/card/card_info_widget.dart';

void main() {
  testWidgets(
      'GIVEN a card info '
      'WHEN CardInfoWidget is built '
      'THEN display card infos', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CardInfoWidget(
          card: CorporateCardModel(
            company: 'OnFly',
            balance: 'R\$ 5.000,00',
            brand: 'Visa',
            currentMonth: 'Março/2024',
          ),
        ),
      ),
    );

    expect(find.text('OnFly'), findsOneWidget);
    expect(find.text('R\$ 5.000,00'), findsOneWidget);
    expect(find.text('Visa'), findsOneWidget);
    expect(find.text('Março/2024'), findsOneWidget);
  });
}

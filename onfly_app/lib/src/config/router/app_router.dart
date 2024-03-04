import 'package:go_router/go_router.dart';

import '../../presentation/views/cards_view.dart';
import '../../presentation/views/expenses_form.dart';
import '../../presentation/views/home_view.dart';
import '../../presentation/views/login_view.dart';
import '../../presentation/views/flights_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => HomeView(),
    ),    
    GoRoute(
      path: "/flights",
      builder: (context, state) => FlightsView(),
    ),
    GoRoute(
      path: "/card",
      builder: (context, state) => CardsView(),
    ),    
    // GoRoute(
    //   path: "/expenses-form",
    //   builder: (context, state) => ExpensesFormView(),
    // ),
  ],
);

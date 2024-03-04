import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

import 'src/config/router/app_router.dart';
import 'src/config/themes/app_themes.dart';
import 'src/domain/repositories/card_repository.dart';
import 'src/domain/repositories/expenses_database_repository.dart';
import 'src/domain/repositories/flights_repository.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/card/cubit/card_cubit.dart';
import 'src/presentation/cubits/expenses/cubit/expenses_cubit.dart';
import 'src/presentation/cubits/flights/cubit/flights_cubit.dart';
import 'src/utils/constants/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FlightsCubit(
            locator<FlightsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => CardCubit(
            locator<CardRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ExpensesCubit(
            locator<ExpensesDatabaseRepository>(),
          ),
        ),
      ],
      child: OKToast(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            title: appTitle,
            theme: AppTheme.light,
          ),
        ),
    );
  }
}
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/local/app_database.dart';
import 'data/datasources/remote/card/card_service.dart';
import 'data/datasources/remote/flights/booked_flights_service.dart';
import 'data/repositories/card_repository_impl.dart';
import 'data/repositories/expenses_database_repository.dart';
import 'data/repositories/flights_repository_impl.dart';
import 'domain/repositories/card_repository.dart';
import 'domain/repositories/expenses_database_repository.dart';
import 'domain/repositories/flights_repository.dart';
import 'utils/constants/strings.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  locator.registerSingleton<AppDatabase>(db);

  locator.registerSingleton<ExpensesDatabaseRepository>(
    ExpensesDatabaseRepositoryImpl(locator<AppDatabase>()),
  );

  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<BookedFlightsService>(
    BookedFlightsService(locator.get<Dio>()),
  );

  locator.registerSingleton<FlightsRepository>(
    FlightsRepositoryImpl(locator<BookedFlightsService>()),
  );

  locator.registerSingleton<CardService>(
    CardService(locator.get<Dio>()),
  );

  locator.registerSingleton<CardRepository>(
    CardRepositoryImpl(locator<CardService>()),
  );
}
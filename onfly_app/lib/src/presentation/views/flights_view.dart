import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/flight_model.dart';
import '../cubits/flights/cubit/flights_cubit.dart';
import '../widgets/flights/flight_card_widget.dart';

class FlightsView extends StatefulWidget {
  @override
  State<FlightsView> createState() => _FlightsViewState();
}

class _FlightsViewState extends State<FlightsView> {
  late final FlightsCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<FlightsCubit>(context);
    _cubit.getFlights();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas viagens'),
      ),
      body: BlocBuilder<FlightsCubit, FlightsState>(
        builder: (context, state) {
          if (state is FlightsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FlightsSuccess) {
            return _buildList(state.flights);
          } else if (state is FlightsError) {
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

  Widget _buildList(List<Flight> flights) {
    return ListView.builder(
      itemCount: flights.length,
      itemBuilder: (context, index) {
        return FlightCardWidget(flight: flights[index],);
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(T initialState) : super(initialState);

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  @protected
  Future<void> run(Future<void> Function() process) async {
    if(!_isBusy) {
      _isBusy = true;
      await process();
      _isBusy = false;
    }
  }
}
import 'dart:async';

import 'package:bloc_http_get/blocs/internet_bloc/internet_event.dart';
import 'package:bloc_http_get/blocs/internet_bloc/internet_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitysubscription;
  InternetBloc() : super(InternetInitialState()) {
    on<InterenetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainEvent>((event, emit) => emit(InternetGainState()));

    connectivitysubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetGainEvent());
      } else {
        add(InterenetLostEvent());
      }
    });
    @override
    Future<void> close() {
      connectivitysubscription?.cancel();
      return super.close();
    }
  }
}

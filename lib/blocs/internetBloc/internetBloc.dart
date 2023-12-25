import 'dart:async';

import 'package:bloctry/blocs/internetBloc/internetEvent.dart';
import 'package:bloctry/blocs/internetBloc/internetState.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {

    // on event gates event and returns state

    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGetEvent>((event, emit) => emit(InternetGetState()));

    // code used for connectivity

    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {

        // adds event

        add(InternetGetEvent());
      }
      else {
        add(InternetLostEvent());
      }
    });

  }
  @override
  Future<void> close() {

    // stops connectivity

    connectivitySubscription?.cancel();
    return super.close();

  }
}

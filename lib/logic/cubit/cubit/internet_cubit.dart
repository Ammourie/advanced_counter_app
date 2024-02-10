import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/core/constants/enums.dart';
import 'package:connectivity/connectivity.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetDisconnected()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((event) {
      switch (event) {
        case ConnectivityResult.mobile:
          emitInternetconnected(NetworkType.mobile);
          break;
        case ConnectivityResult.wifi:
          emitInternetconnected(NetworkType.wifi);
          break;
        case ConnectivityResult.none:
          emitInternetDisconnected();
          break;
      }
    });
  }
  void emitInternetconnected(NetworkType connectoinType) =>
      emit(InternetConnected(connectiontype: connectoinType));
  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}

part of 'internet_cubit.dart';

sealed class InternetState {}

final class InternetConnected extends InternetState {
  final NetworkType connectiontype;

  InternetConnected({required this.connectiontype});
}

final class InternetDisconnected extends InternetState {}

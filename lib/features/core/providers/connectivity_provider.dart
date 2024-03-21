import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityStreamProvider = StreamProvider<bool>((ref) {
  return ref.read(connectivityProvider).onConnectivityChanged.map((event) => !event.contains(ConnectivityResult.none));
});

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

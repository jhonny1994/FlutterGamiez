import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamiez/features/core/presentation/not_connected_screen.dart';
import 'package:gamiez/features/core/presentation/widgets/error_screen.dart';
import 'package:gamiez/features/core/presentation/widgets/loading_screen.dart';
import 'package:gamiez/features/core/providers/connectivity_provider.dart';
import 'package:gamiez/theme/app_theme.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityState = ref.watch(connectivityStreamProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Center(
        child: connectivityState.when(
          data: (isConnected) => isConnected ? Container() : const NotConnectedScreen(),
          error: (error, stackTrace) => ErrorScreen(error: error.toString()),
          loading: () => const LoadingScreen(),
        ),
      ),
    );
  }
}

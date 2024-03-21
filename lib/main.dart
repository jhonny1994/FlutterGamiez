import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamiez/features/core/presentation/main_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotConnectedScreen extends StatelessWidget {
  const NotConnectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/gamiez.png'),
              backgroundColor: Colors.transparent,
            ),
            Gap(8),
            Text('You are not connected to internet.'),
          ],
        ),
      ),
    );
  }
}

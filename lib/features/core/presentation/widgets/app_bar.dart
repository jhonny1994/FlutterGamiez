import 'package:flutter/material.dart';

AppBar gamiezAppBar() {
  return AppBar(
    centerTitle: true,
    title: const CircleAvatar(
      backgroundImage: AssetImage('assets/gamiez.png'),
      backgroundColor: Colors.transparent,
    ),
  );
}

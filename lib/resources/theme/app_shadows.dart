import 'package:flutter/material.dart';

final class AppShadows {
  const AppShadows._();

  static final List<BoxShadow> primary = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ];
}

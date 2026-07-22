import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MouseGradientBg extends StatelessWidget {
  final Widget child;
  const MouseGradientBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
      child: child,
    );
  }
}

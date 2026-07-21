import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double? width;
  final double? height;
  final double? minHeight;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final bool noPadding;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppTheme.spaceLg),
    this.margin,
    this.borderRadius = AppTheme.radiusLg,
    this.width,
    this.height,
    this.minHeight,
    this.backgroundColor,
    this.gradientColors,
    this.noPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      constraints: minHeight != null ? BoxConstraints(minHeight: minHeight!) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: gradientColors != null
            ? LinearGradient(
                colors: gradientColors!.map((c) => c.withValues(alpha: 0.1)).toList(),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            padding: noPadding ? EdgeInsets.zero : padding,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppTheme.glassBg,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: AppTheme.glassBorder, width: 1),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

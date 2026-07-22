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
  final bool hasGlow;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppTheme.space24),
    this.margin,
    this.borderRadius = AppTheme.radius16,
    this.width,
    this.height,
    this.minHeight,
    this.backgroundColor,
    this.gradientColors,
    this.hasGlow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final glowColor = gradientColors?.first ?? AppTheme.primary;
    final card = Container(
      width: width,
      height: height,
      margin: margin,
      constraints: minHeight != null ? BoxConstraints(minHeight: minHeight!) : null,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.cardBg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: gradientColors != null
            ? Border.all(width: 0)
            : Border.all(color: AppTheme.border.withValues(alpha: 0.4)),
        boxShadow: hasGlow
            ? [
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.12),
                  blurRadius: 32,
                  spreadRadius: 4,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      foregroundDecoration: gradientColors != null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                width: 1.5,
                color: Colors.transparent,
              ),
              gradient: LinearGradient(
                colors: gradientColors!.map((c) => c.withValues(alpha: 0.4)).toList(),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            )
          : null,
      padding: padding,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}

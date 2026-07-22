import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final double scale;
  final double borderRadius;
  final VoidCallback? onTap;

  const HoverCard({
    super.key,
    required this.child,
    this.scale = 1.02,
    this.borderRadius = AppTheme.radius16,
    this.onTap,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.15),
                      blurRadius: 32,
                      spreadRadius: 4,
                      offset: const Offset(0, 12),
                    ),
                  ]
                : [],
          ),
          child: widget.onTap != null
              ? GestureDetector(onTap: widget.onTap, child: widget.child)
              : widget.child,
        ),
      ),
    );
  }
}

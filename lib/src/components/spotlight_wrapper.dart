import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SpotlightWrapper extends StatefulWidget {
  final Widget child;
  final double borderRadius;

  const SpotlightWrapper({
    super.key,
    required this.child,
    this.borderRadius = AppTheme.radius16,
  });

  @override
  State<SpotlightWrapper> createState() => _SpotlightWrapperState();
}

class _SpotlightWrapperState extends State<SpotlightWrapper> {
  Offset _mousePosition = Offset.zero;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final x = constraints.maxWidth > 0
              ? (_mousePosition.dx / constraints.maxWidth) * 2 - 1
              : 0.0;
          final y = constraints.maxHeight > 0
              ? (_mousePosition.dy / constraints.maxHeight) * 2 - 1
              : 0.0;

          return Stack(
            children: [
              widget.child,
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                        gradient: RadialGradient(
                          center: Alignment(x, y),
                          colors: [
                            AppTheme.primary.withValues(alpha: 0.06),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.7],
                          radius: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

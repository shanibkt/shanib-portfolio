import 'package:flutter/material.dart';

class MouseGradientBg extends StatefulWidget {
  final Widget child;
  const MouseGradientBg({super.key, required this.child});

  @override
  State<MouseGradientBg> createState() => _MouseGradientBgState();
}

class _MouseGradientBgState extends State<MouseGradientBg> {
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.position;
        });
      },
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            left: _mousePosition.dx - 400,
            top: _mousePosition.dy - 400,
            child: IgnorePointer(
              child: Container(
                width: 800,
                height: 800,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF1D4ED8).withOpacity(0.08),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.8],
                  ),
                ),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

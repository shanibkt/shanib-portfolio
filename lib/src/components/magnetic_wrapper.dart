import 'package:flutter/material.dart';

class MagneticWrapper extends StatefulWidget {
  final Widget child;
  const MagneticWrapper({super.key, required this.child});

  @override
  State<MagneticWrapper> createState() => _MagneticWrapperState();
}

class _MagneticWrapperState extends State<MagneticWrapper> {
  Offset _position = Offset.zero;
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null && renderBox.hasSize) {
          final localPosition = renderBox.globalToLocal(event.position);
          final center = Offset(renderBox.size.width / 2, renderBox.size.height / 2);
          final dx = (localPosition.dx - center.dx) * 0.15;
          final dy = (localPosition.dy - center.dy) * 0.15;
          if (mounted) {
            setState(() {
              _position = Offset(dx, dy);
            });
          }
        }
      },
      onExit: (_) {
        if (mounted) {
          setState(() {
            _position = Offset.zero;
          });
        }
      },
      child: AnimatedContainer(
        key: _key,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(_position.dx, _position.dy, 0),
        child: widget.child,
      ),
    );
  }
}

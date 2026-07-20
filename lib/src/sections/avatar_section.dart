import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SpotlightWrapper(
      child: GlassContainer(
        height: 400,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: const _FloatingBadge(icon: Icons.code, color: Colors.blueAccent, delay: 0),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: const _FloatingBadge(icon: Icons.terminal, color: Colors.greenAccent, delay: 500),
            ),
            Positioned(
              top: 60,
              right: 40,
              child: const _FloatingBadge(icon: Icons.layers, color: Colors.purpleAccent, delay: 1000),
            ),
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1), width: 4),
                gradient: RadialGradient(
                  colors: [Colors.blueAccent.withOpacity(0.2), Colors.purpleAccent.withOpacity(0.2)],
                ),
              ),
              child: const Center(
                child: Text('🧑‍💻', style: TextStyle(fontSize: 80)),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.1, end: 0);
  }
}

class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int delay;

  const _FloatingBadge({required this.icon, required this.color, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Icon(icon, color: color, size: 24),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
     .moveY(begin: -8, end: 8, duration: 2000.ms, curve: Curves.easeInOut, delay: delay.ms);
  }
}

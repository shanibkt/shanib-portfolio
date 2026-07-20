import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewWorkTap;
  final VoidCallback? onContactTap;

  const HeroSection({super.key, this.onViewWorkTap, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return SpotlightWrapper(
      child: GlassContainer(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                  ).animate(onPlay: (controller) => controller.repeat()).fadeIn(duration: 500.ms).then().fadeOut(duration: 500.ms),
                  const SizedBox(width: 8),
                  Text(
                    'Available for work',
                    style: TextStyle(color: Colors.grey[300], fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Hi, I'm Shanib",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blueAccent, Colors.indigoAccent],
              ).createShader(bounds),
              child: Text(
                'Flutter Developer',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "I specialize in building scalable, production-ready mobile applications with clean architecture and seamless REST API integration.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[400],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: onViewWorkTap,
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('View Work'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: onContactTap,
                  icon: const Icon(Icons.email_outlined, size: 16),
                  label: const Text('Contact Me'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.white.withOpacity(0.3)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0);
  }
}

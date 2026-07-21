import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewWorkTap;
  final VoidCallback? onContactTap;

  const HeroSection({super.key, this.onViewWorkTap, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SpotlightWrapper(
      child: GlassContainer(
        padding: const EdgeInsets.all(AppTheme.spaceXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
                  ).animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 500.ms)
                    .then()
                    .fadeOut(duration: 500.ms),
                  const SizedBox(width: AppTheme.spaceSm),
                  Text(
                    'Available for work',
                    style: TextStyle(color: Colors.grey[300], fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            Text(
              "Hi, I'm Shanib",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isMobile ? 32 : null,
                  ),
            ),
            const SizedBox(height: AppTheme.spaceSm),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blueAccent, Colors.indigoAccent],
              ).createShader(bounds),
              child: Text(
                'Flutter Developer',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontSize: isMobile ? 28 : null,
                    ),
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),
            Text(
              "I specialize in building scalable, production-ready mobile applications with clean architecture and seamless REST API integration.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[400],
                  ),
            ),
            const SizedBox(height: AppTheme.spaceXl),
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        onPressed: onViewWorkTap,
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('View Work'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spaceSm),
                      OutlinedButton.icon(
                        onPressed: onContactTap,
                        icon: const Icon(Icons.email_outlined, size: 16),
                        label: const Text('Contact Me'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: onViewWorkTap,
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('View Work'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spaceLg,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spaceMd),
                      OutlinedButton.icon(
                        onPressed: onContactTap,
                        icon: const Icon(Icons.email_outlined, size: 16),
                        label: const Text('Contact Me'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spaceLg,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
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

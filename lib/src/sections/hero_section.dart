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
      borderRadius: AppTheme.radius20,
      child: GlassContainer(
        padding: EdgeInsets.all(isMobile ? AppTheme.space24 : AppTheme.space40),
        borderRadius: AppTheme.radius20,
        hasGlow: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: AppTheme.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                border: Border.all(color: AppTheme.success.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppTheme.success,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.success.withValues(alpha: 0.5),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 500.ms)
                    .then()
                    .fadeOut(duration: 500.ms),
                  const SizedBox(width: AppTheme.space8),
                  Text(
                    'Available for work',
                    style: TextStyle(
                      color: AppTheme.success.withValues(alpha: 0.9),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.space32),
            Text(
              "Hi, I'm Shanib",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isMobile ? 32 : null,
                  ),
            ),
            const SizedBox(height: AppTheme.space8),
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                'Flutter Developer',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontSize: isMobile ? 28 : null,
                    ),
              ),
            ),
            const SizedBox(height: AppTheme.space20),
            Text(
              "I specialize in building scalable, production-ready mobile applications with clean architecture and seamless REST API integration.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppTheme.space32),
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPrimaryButton('View Work', Icons.arrow_forward, onViewWorkTap),
                      const SizedBox(height: AppTheme.space12),
                      _buildSecondaryButton('Contact Me', Icons.email_outlined, onContactTap),
                    ],
                  )
                : Row(
                    children: [
                      _buildPrimaryButton('View Work', Icons.arrow_forward, onViewWorkTap),
                      const SizedBox(width: AppTheme.space16),
                      _buildSecondaryButton('Contact Me', Icons.email_outlined, onContactTap),
                    ],
                  ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildPrimaryButton(String label, IconData icon, VoidCallback? onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        gradient: AppTheme.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius12)),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String label, IconData icon, VoidCallback? onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppTheme.border.withValues(alpha: 0.6)),
      ),
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.textPrimary,
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius12)),
        ),
      ),
    );
  }
}

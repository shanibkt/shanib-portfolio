import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

const _avatarUrl = 'https://avatars.githubusercontent.com/u/78144198?v=4';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final avatarSize = isMobile ? 160.0 : 220.0;
    final badgeSize = isMobile ? 18.0 : 24.0;
    final badgePad = isMobile ? 8.0 : 10.0;

    return SpotlightWrapper(
      borderRadius: AppTheme.radius20,
      child: GlassContainer(
        borderRadius: AppTheme.radius20,
        padding: EdgeInsets.all(isMobile ? AppTheme.space16 : AppTheme.space24),
        height: isMobile ? 240 : 400,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.border.withValues(alpha: 0.6),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.15),
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  _avatarUrl,
                  width: avatarSize,
                  height: avatarSize,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppTheme.cardBg,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.cardBg,
                      child: Center(
                        child: Text('🧑‍💻', style: TextStyle(fontSize: avatarSize * 0.36)),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: isMobile ? 8 : 16,
              left: isMobile ? 8 : 16,
              child: _FloatingBadge(
                icon: Icons.code,
                color: AppTheme.primary,
                delay: 0,
                size: badgeSize,
                padding: badgePad,
              ),
            ),
            Positioned(
              top: isMobile ? 44 : 72,
              right: isMobile ? 8 : 16,
              child: _FloatingBadge(
                icon: Icons.layers,
                color: AppTheme.accent,
                delay: 1000,
                size: badgeSize,
                padding: badgePad,
              ),
            ),
            Positioned(
              bottom: isMobile ? 8 : 16,
              right: isMobile ? 8 : 16,
              child: _FloatingBadge(
                icon: Icons.terminal,
                color: AppTheme.success,
                delay: 500,
                size: badgeSize,
                padding: badgePad,
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
  final double size;
  final double padding;

  const _FloatingBadge({
    required this.icon,
    required this.color,
    required this.delay,
    this.size = 24,
    this.padding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppTheme.background.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppTheme.border.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
      .moveY(begin: -6, end: 6, duration: 2000.ms, curve: Curves.easeInOut, delay: delay.ms);
  }
}

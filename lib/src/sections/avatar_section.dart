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
    final badgePad = isMobile ? 8.0 : 12.0;

    return SpotlightWrapper(
      child: GlassContainer(
        padding: EdgeInsets.all(isMobile ? AppTheme.spaceMd : AppTheme.spaceXl),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.15),
                    blurRadius: 24,
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
                      color: Colors.white.withValues(alpha: 0.03),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.blueAccent,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white.withValues(alpha: 0.03),
                      child: Center(
                        child: Text('🧑‍💻', style: TextStyle(fontSize: avatarSize * 0.36)),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: isMobile ? 4 : 8,
              left: isMobile ? 4 : 8,
              child: _FloatingBadge(
                icon: Icons.code,
                color: Colors.blueAccent,
                delay: 0,
                size: badgeSize,
                padding: badgePad,
              ),
            ),
            Positioned(
              top: isMobile ? 36 : 56,
              right: isMobile ? 4 : 8,
              child: _FloatingBadge(
                icon: Icons.layers,
                color: Colors.purpleAccent,
                delay: 1000,
                size: badgeSize,
                padding: badgePad,
              ),
            ),
            Positioned(
              bottom: isMobile ? 4 : 8,
              right: isMobile ? 4 : 8,
              child: _FloatingBadge(
                icon: Icons.terminal,
                color: Colors.greenAccent,
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
    this.padding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Color(0xFF0B0F19).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
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

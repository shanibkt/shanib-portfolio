import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

const _avatarUrl = 'https://avatars.githubusercontent.com/u/78144198?v=4';

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
        minHeight: isMobile ? null : 500,
        child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(context),
        ),
        const SizedBox(width: AppTheme.space40),
        Expanded(
          flex: 5,
          child: _buildAvatar(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAvatar(context),
        const SizedBox(height: AppTheme.space32),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final avatarSize = isMobile ? 180.0 : 280.0;
    final badgeSize = isMobile ? 18.0 : 24.0;
    final badgePad = isMobile ? 8.0 : 10.0;

    return Center(
      child: SizedBox(
        width: avatarSize + 60,
        height: avatarSize + 60,
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
                    color: AppTheme.primary.withValues(alpha: 0.2),
                    blurRadius: 48,
                    spreadRadius: 8,
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
              top: 0,
              left: 0,
              child: _FloatingBadge(
                icon: Icons.code,
                color: AppTheme.primary,
                delay: 0,
                size: badgeSize,
                padding: badgePad,
              ),
            ),
            Positioned(
              top: isMobile ? 20 : 36,
              right: 0,
              child: _FloatingBadge(
                icon: Icons.layers,
                color: AppTheme.accent,
                delay: 1000,
                size: badgeSize,
                padding: badgePad,
              ),
            ),
            Positioned(
              bottom: 0,
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
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
        SizedBox(height: isMobile ? AppTheme.space24 : AppTheme.space32),
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
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
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
    );
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

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';

const _avatarUrl = 'https://avatars.githubusercontent.com/u/78144198?v=4';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewWorkTap;
  final VoidCallback? onContactTap;

  const HeroSection({super.key, this.onViewWorkTap, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return GlassContainer(
      padding: EdgeInsets.all(isMobile ? AppTheme.space24 : AppTheme.space40),
      borderRadius: AppTheme.radius24,
      minHeight: isMobile ? null : 500,
      child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
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

    return Center(
      child: Container(
        width: avatarSize,
        height: avatarSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppTheme.border.withValues(alpha: 0.6),
            width: 2,
          ),
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
            color: AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            border: Border.all(color: AppTheme.border.withValues(alpha: 0.4)),
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
                ),
              ),
              const SizedBox(width: AppTheme.space8),
              Text(
                'Available for work',
                style: TextStyle(
                  color: AppTheme.textSecondary,
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
                color: AppTheme.textPrimary,
              ),
        ),
        const SizedBox(height: AppTheme.space8),
        Text(
          'Flutter Developer',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.primary,
                fontSize: isMobile ? 28 : null,
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
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius12)),
      ),
    );
  }

  Widget _buildSecondaryButton(String label, IconData icon, VoidCallback? onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.textPrimary,
        side: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius12)),
      ),
    );
  }
}

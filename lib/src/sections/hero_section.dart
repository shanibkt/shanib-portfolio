import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../components/magnetic_wrapper.dart';
import '../components/typewriter_text.dart';

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
    ).animate().fadeIn(duration: 800.ms).scaleXY(begin: 0.95, end: 1, curve: Curves.easeOut);
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
      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: 0, end: -8, duration: 3000.ms, curve: Curves.easeInOut),
    );
  }

  Future<void> _downloadCV() async {
    // For Flutter Web, assets are served at assets/assets/FILE
    // but sometimes just assets/FILE works depending on base href.
    // Most reliable for web is often placing it in web/ and using 'cv.pdf'
    final Uri url = Uri.parse('assets/cv.pdf');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
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
              ).animate(onPlay: (controller) => controller.repeat())
                .fadeIn(duration: 500.ms)
                .then()
                .fadeOut(duration: 500.ms),
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
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: -0.05),
        SizedBox(height: isMobile ? AppTheme.space24 : AppTheme.space32),
        Text(
          "Hi, I'm Shanib",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: isMobile ? 32 : null,
                color: AppTheme.textPrimary,
              ),
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: -0.05),
        const SizedBox(height: AppTheme.space8),
        TypewriterText(
          text: 'Flutter Developer',
          duration: const Duration(milliseconds: 60),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.primary,
                fontSize: isMobile ? 28 : null,
              ),
        ).animate().fadeIn(duration: 400.ms, delay: 600.ms),
        const SizedBox(height: AppTheme.space20),
        Text(
          "I specialize in building scalable, production-ready mobile applications with clean architecture and seamless REST API integration.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.1),
        const SizedBox(height: AppTheme.space32),
        LayoutBuilder(
          builder: (context, constraints) {
            // Using a slightly larger threshold for the buttons than the section-wide isMobile
            final wrapButtons = constraints.maxWidth < 550;

            if (wrapButtons) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPrimaryButton('View Work', Icons.arrow_forward, onViewWorkTap),
                  const SizedBox(height: AppTheme.space12),
                  _buildSecondaryButton('Contact Me', Icons.email_outlined, onContactTap),
                  const SizedBox(height: AppTheme.space12),
                  _buildSecondaryButton('Download CV', Icons.download_rounded, _downloadCV, delay: 1200),
                ],
              );
            }

            return Row(
              children: [
                _buildPrimaryButton('View Work', Icons.arrow_forward, onViewWorkTap),
                const SizedBox(width: AppTheme.space16),
                _buildSecondaryButton('Contact Me', Icons.email_outlined, onContactTap),
                const SizedBox(width: AppTheme.space16),
                _buildSecondaryButton('Download CV', Icons.download_rounded, _downloadCV, delay: 1200),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(String label, IconData icon, VoidCallback? onTap) {
    return MagneticWrapper(
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius12)),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.1);
  }

  Widget _buildSecondaryButton(String label, IconData icon, VoidCallback? onTap, {int delay = 1100}) {
    return MagneticWrapper(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.textPrimary,
          side: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius12)),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: delay.ms).slideY(begin: 0.1);
  }
}

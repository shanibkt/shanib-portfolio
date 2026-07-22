import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AppTheme.radius24,
      padding: const EdgeInsets.all(AppTheme.space32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(context, 'Contact Me'),
          const SizedBox(height: AppTheme.space32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              final itemWidth = isWide
                  ? (constraints.maxWidth - AppTheme.space24) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: AppTheme.space24,
                runSpacing: AppTheme.space24,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: const _ContactItem(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: 'shanib.personal@gmail.com',
                      url: 'mailto:shanib.personal@gmail.com',
                      index: 0,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: const _ContactItem(
                      icon: Icons.code,
                      label: 'GitHub',
                      value: 'github.com/shanibkt',
                      url: 'https://github.com/shanibkt',
                      index: 1,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: const _ContactItem(
                      icon: Icons.link,
                      label: 'LinkedIn',
                      value: 'linkedin.com/in/shanib-k-t-',
                      url: 'https://www.linkedin.com/in/shanib-k-t-/',
                      index: 2,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05);
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppTheme.primary,
          ),
        ),
        const SizedBox(width: AppTheme.space16),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ],
    ).animate().fadeIn().slideX(begin: -0.05);
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;
  final int index;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.index,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final delay = 300 + (widget.index * 100);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: _isHovered
              ? Matrix4.translationValues(0, -4, 0)
              : Matrix4.identity(),
          padding: const EdgeInsets.all(AppTheme.space20),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.surfaceLight : AppTheme.cardBg,
            borderRadius: BorderRadius.circular(AppTheme.radius16),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primary.withValues(alpha: 0.3)
                  : AppTheme.border.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppTheme.primary.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.icon,
                    color: _isHovered ? AppTheme.primary : AppTheme.textSecondary,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.space16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppTheme.space4),
                    Text(
                      widget.value,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: _isHovered ? AppTheme.textPrimary : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: delay.ms).slideY(begin: 0.08);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                      value: 'shani@example.com',
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: const _ContactItem(
                      icon: Icons.code,
                      label: 'GitHub',
                      value: 'github.com/shanii',
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: const _ContactItem(
                      icon: Icons.link,
                      label: 'LinkedIn',
                      value: 'linkedin.com/in/shanii',
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
    );
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppTheme.space20),
        decoration: BoxDecoration(
          color: _isHovered ? AppTheme.surfaceLight : AppTheme.cardBg,
          borderRadius: BorderRadius.circular(AppTheme.radius16),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primary.withValues(alpha: 0.2)
                : AppTheme.border.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: AppTheme.primary, size: 20),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

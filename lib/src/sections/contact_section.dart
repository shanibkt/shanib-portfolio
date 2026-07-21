import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SpotlightWrapper(
      child: GlassContainer(
        padding: const EdgeInsets.all(AppTheme.spaceXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Me', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppTheme.spaceXl),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                final itemWidth = isWide
                    ? (constraints.maxWidth - AppTheme.spaceLg) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: AppTheme.spaceLg,
                  runSpacing: AppTheme.spaceLg,
                  children: [
                    SizedBox(
                      width: isWide ? itemWidth : constraints.maxWidth,
                      child: const _ContactItem(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: 'shani@example.com',
                      ),
                    ),
                    SizedBox(
                      width: isWide ? itemWidth : constraints.maxWidth,
                      child: const _ContactItem(
                        icon: Icons.code,
                        label: 'GitHub',
                        value: 'github.com/shanii',
                      ),
                    ),
                    SizedBox(
                      width: isWide ? itemWidth : constraints.maxWidth,
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
      ),
    ).animate().fadeIn(duration: 800.ms).slideY();
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
        padding: const EdgeInsets.all(AppTheme.spaceMd + 4),
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Icon(widget.icon, color: AppTheme.accent, size: 22),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  widget.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

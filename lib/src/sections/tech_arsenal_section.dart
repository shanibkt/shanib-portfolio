import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';

class TechArsenalSection extends StatelessWidget {
  const TechArsenalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final techStack = [
      {'name': 'Flutter & Dart', 'icon': Icons.smartphone},
      {'name': 'BLoC & Clean Arch', 'icon': Icons.layers},
      {'name': 'Firebase & REST APIs', 'icon': Icons.cloud},
      {'name': 'Hive & SQLite', 'icon': Icons.storage},
    ];

    return GlassContainer(
      borderRadius: AppTheme.radius24,
      padding: const EdgeInsets.all(AppTheme.space32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(context, 'Core Skills'),
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
                children: techStack.asMap().entries.map((entry) => SizedBox(
                  width: itemWidth,
                  child: _TechItem(
                    name: entry.value['name'] as String,
                    icon: entry.value['icon'] as IconData,
                    index: entry.key,
                  ),
                )).toList(),
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

class _TechItem extends StatefulWidget {
  final String name;
  final IconData icon;
  final int index;

  const _TechItem({
    required this.name,
    required this.icon,
    required this.index,
  });

  @override
  State<_TechItem> createState() => _TechItemState();
}

class _TechItemState extends State<_TechItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final delay = 300 + (widget.index * 100);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(AppTheme.space20),
        decoration: BoxDecoration(
          color: _isHovered ? AppTheme.surfaceLight : AppTheme.surfaceLight,
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppTheme.primary.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppTheme.radius12),
              ),
              child: Icon(
                widget.icon,
                color: _isHovered ? AppTheme.primary : AppTheme.textSecondary,
                size: 22,
              ),
            ),
            const SizedBox(width: AppTheme.space16),
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: _isHovered ? AppTheme.textPrimary : AppTheme.textSecondary,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.chevron_right,
                color: _isHovered ? AppTheme.primary : AppTheme.textMuted,
                size: 20,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms, delay: delay.ms).slideX(begin: -0.03),
    );
  }
}

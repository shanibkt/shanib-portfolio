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
                children: techStack.map((tech) => SizedBox(
                  width: itemWidth,
                  child: _TechItem(
                    name: tech['name'] as String,
                    icon: tech['icon'] as IconData,
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
    );
  }
}

class _TechItem extends StatelessWidget {
  final String name;
  final IconData icon;

  const _TechItem({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        border: Border.all(color: AppTheme.border.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary, size: 22),
          const SizedBox(width: AppTheme.space16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: AppTheme.textMuted, size: 20),
        ],
      ),
    );
  }
}

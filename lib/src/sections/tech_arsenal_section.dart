import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class TechArsenalSection extends StatelessWidget {
  const TechArsenalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final techStack = [
      {'name': 'Flutter & Dart', 'icon': Icons.smartphone, 'level': 0.95, 'color': AppTheme.primary},
      {'name': 'BLoC & Clean Arch', 'icon': Icons.layers, 'level': 0.90, 'color': AppTheme.accent},
      {'name': 'Firebase & REST APIs', 'icon': Icons.cloud, 'level': 0.85, 'color': const Color(0xFFF59E0B)},
      {'name': 'Hive & SQLite', 'icon': Icons.storage, 'level': 0.85, 'color': AppTheme.success},
    ];

    return SpotlightWrapper(
      borderRadius: AppTheme.radius20,
      child: GlassContainer(
        borderRadius: AppTheme.radius20,
        padding: const EdgeInsets.all(AppTheme.space32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: AppTheme.accentGradient,
                  ),
                ),
                const SizedBox(width: AppTheme.space16),
                Text('Core Skills', style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
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
                      level: tech['level'] as double,
                      color: tech['color'] as Color,
                    ),
                  )).toList(),
                );
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05);
  }
}

class _TechItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final double level;
  final Color color;

  const _TechItem({required this.name, required this.icon, required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.space20),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppTheme.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
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
            ],
          ),
          const SizedBox(height: AppTheme.space16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: level,
              backgroundColor: AppTheme.border.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 5,
            ).animate().scaleX(
              begin: 0,
              end: 1,
              duration: 1000.ms,
              curve: Curves.easeOutCubic,
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }
}

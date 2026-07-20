import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class TechArsenalSection extends StatelessWidget {
  const TechArsenalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final techStack = [
      {'name': 'Flutter & Dart', 'icon': Icons.smartphone, 'level': 0.95, 'color': Colors.blue},
      {'name': 'BLoC & Clean Arch', 'icon': Icons.layers, 'level': 0.90, 'color': Colors.cyan},
      {'name': 'Firebase & REST APIs', 'icon': Icons.cloud, 'level': 0.85, 'color': Colors.amber},
      {'name': 'Hive & SQLite', 'icon': Icons.storage, 'level': 0.85, 'color': Colors.green},
    ];

    return SpotlightWrapper(
      child: GlassContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Core Skills', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 32),
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: techStack.map((tech) => SizedBox(
                    width: constraints.maxWidth > 600 ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                    child: _TechItem(
                      name: tech['name'] as String,
                      icon: tech['icon'] as IconData,
                      level: tech['level'] as double,
                      color: tech['color'] as Color,
                    ),
                  )).toList(),
                );
              }
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY();
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: level,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ).animate().scaleX(begin: 0, end: 1, duration: 1000.ms, curve: Curves.easeOutCubic, alignment: Alignment.centerLeft),
          ),
        ],
      ),
    );
  }
}

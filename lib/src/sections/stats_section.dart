import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';

class StatsSection {
  static final _stats = [
    {'label': 'Years Exp', 'value': '5+'},
    {'label': 'Projects', 'value': '30+'},
    {'label': 'Contributions', 'value': '1.2k'},
    {'label': 'Clients', 'value': '15'},
  ];

  static StaggeredGridTile buildRow(int crossAxisCount) {
    final int cellCount = crossAxisCount == 12 ? 12 : crossAxisCount == 8 ? 8 : 1;

    return StaggeredGridTile.fit(
      crossAxisCellCount: cellCount,
      child: _buildStatRow(crossAxisCount),
    );
  }

  static Widget _buildStatRow(int crossAxisCount) {
    final isMobile = crossAxisCount == 1;
    final items = _stats.asMap().entries.map((entry) {
      final stat = entry.value;
      return _StatCard(
        value: stat['value']!,
        label: stat['label']!,
        delay: 400 + (entry.key * 100),
      );
    }).toList();

    if (isMobile) {
      return Column(
        children: [
          Row(
            children: items.sublist(0, 2).map((w) => Expanded(child: w)).toList(),
          ),
          const SizedBox(height: AppTheme.space16),
          Row(
            children: items.sublist(2, 4).map((w) => Expanded(child: w)).toList(),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: items[0]),
        const SizedBox(width: AppTheme.space24),
        Expanded(child: items[1]),
        const SizedBox(width: AppTheme.space24),
        Expanded(child: items[2]),
        const SizedBox(width: AppTheme.space24),
        Expanded(child: items[3]),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final int delay;

  const _StatCard({
    required this.value,
    required this.label,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.space24, horizontal: AppTheme.space16),
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.space8),
          Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textMuted,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
      duration: 800.ms,
      delay: delay.ms,
    ).slideY(begin: 0.1, end: 0);
  }
}

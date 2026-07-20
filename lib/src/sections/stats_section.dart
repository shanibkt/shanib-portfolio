import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/glass_container.dart';

class StatsSection {
  static final _stats = [
    {'label': 'Years Exp', 'value': '5+'},
    {'label': 'Projects', 'value': '30+'},
    {'label': 'Contributions', 'value': '1.2k'},
    {'label': 'Clients', 'value': '15'},
  ];

  static List<StaggeredGridTile> buildTiles(int crossAxisCount) {
    final int cellCount = crossAxisCount == 12 ? 3 : crossAxisCount == 8 ? 4 : 1;
    
    return List.generate(_stats.length, (index) {
      final stat = _stats[index];
      return StaggeredGridTile.fit(
        crossAxisCellCount: cellCount,
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stat['value']!,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                stat['label']!.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 800.ms, delay: (400 + (index * 100)).ms).slideY(begin: 0.1, end: 0),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class ExperienceSection extends StatelessWidget {
  final int crossAxisCount;
  const ExperienceSection({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final int cellCount = crossAxisCount == 12 ? 6 : crossAxisCount == 8 ? 8 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppTheme.spaceLg, bottom: AppTheme.spaceLg),
          child: Text('Experience & Journey', style: Theme.of(context).textTheme.displaySmall),
        ).animate().fadeIn().slideY(),
        StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppTheme.spaceLg,
          crossAxisSpacing: AppTheme.spaceLg,
          children: [
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: SpotlightWrapper(
                child: GlassContainer(
                  padding: const EdgeInsets.all(AppTheme.spaceXl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About Me', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: AppTheme.spaceLg),
                      Text(
                        'I am a Flutter Developer with hands-on experience building scalable, production-ready mobile applications. My technical expertise includes BLoC state management, robust REST API integration, and various local storage solutions like Hive and SQLite.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppTheme.spaceMd),
                      Text(
                        'My Goal: To build high-quality, scalable mobile applications and continuously grow as a software engineer while contributing to impactful products at leading global technology companies.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn().slideY(),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: SpotlightWrapper(
                child: GlassContainer(
                  padding: const EdgeInsets.all(AppTheme.spaceXl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Experience', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: AppTheme.spaceXl),
                      const _ExperienceItem(
                        period: 'April 2026 - Present',
                        role: 'Flutter Developer',
                        company: 'Appziac Technologies',
                        description: 'Developing cross-platform mobile apps. Building responsive UI components, integrating RESTful APIs, managing state using BLoC, and working with local storage (Hive, SQLite, SharedPreferences).',
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final String period;
  final String role;
  final String company;
  final String description;
  final bool isLast;

  const _ExperienceItem({
    required this.period,
    required this.role,
    required this.company,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppTheme.spaceLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  period,
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  role,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  company,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
                const SizedBox(height: AppTheme.spaceSm + 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                if (!isLast) const SizedBox(height: AppTheme.spaceXl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

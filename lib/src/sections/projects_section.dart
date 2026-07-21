import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class ProjectsSection extends StatelessWidget {
  final int crossAxisCount;
  const ProjectsSection({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final int cellCount = crossAxisCount == 12 ? 6 : crossAxisCount == 8 ? 4 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: AppTheme.primaryGradient,
              ),
            ),
            const SizedBox(width: AppTheme.space16),
            Flexible(
              child: Text('Featured Projects', style: Theme.of(context).textTheme.displaySmall),
            ),
          ],
        ).animate().fadeIn().slideX(begin: -0.05),
        const SizedBox(height: AppTheme.space32),
        StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppTheme.space24,
          crossAxisSpacing: AppTheme.space24,
          children: [
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: const _ProjectCard(
                title: 'Salon Studio',
                description: 'A feature-rich salon booking and management app that streamlines scheduling, staff management, and offline syncing.',
                tags: ['Flutter', 'BLoC', 'Firebase', 'Hive'],
                gradient: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: const _ProjectCard(
                title: 'Your Next Project',
                description: 'Placeholder for another amazing project you have built or will build in the future.',
                tags: ['Dart', 'REST API', 'Clean Arch'],
                gradient: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
                delay: 200,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final List<Color> gradient;
  final int delay;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
    required this.gradient,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SpotlightWrapper(
      borderRadius: AppTheme.radius20,
      child: GlassContainer(
        borderRadius: AppTheme.radius20,
        padding: const EdgeInsets.all(AppTheme.space32),
        gradientColors: gradient,
        hasGlow: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppTheme.space8,
              runSpacing: AppTheme.space8,
              children: tags.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: gradient.first.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(color: gradient.first.withValues(alpha: 0.2)),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gradient.first,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: AppTheme.space24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.space12),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.7,
                  ),
            ),
            const SizedBox(height: AppTheme.space24),
            Wrap(
              spacing: AppTheme.space12,
              runSpacing: AppTheme.space12,
              children: [
                _buildAction(gradient.first, Icons.open_in_new, 'Live Demo'),
                _buildAction(gradient.last, Icons.code, 'GitHub'),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: delay.ms).slideY(begin: 0.05);
  }

  Widget _buildAction(Color color, IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 14),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.08),
          foregroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radius12),
          ),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

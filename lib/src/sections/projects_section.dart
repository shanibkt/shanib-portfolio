import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';

class ProjectsSection extends StatelessWidget {
  final int crossAxisCount;
  const ProjectsSection({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final int cellCount = crossAxisCount == 12 ? 6 : crossAxisCount == 8 ? 4 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(context, 'Featured Projects'),
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
              ),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: const _ProjectCard(
                title: 'Your Next Project',
                description: 'Placeholder for another amazing project you have built or will build in the future.',
                tags: ['Dart', 'REST API', 'Clean Arch'],
                delay: 200,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppTheme.primary,
          ),
        ),
        const SizedBox(width: AppTheme.space16),
        Flexible(
          child: Text(title, style: Theme.of(context).textTheme.displaySmall),
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.05);
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final int delay;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AppTheme.radius24,
      padding: const EdgeInsets.all(AppTheme.space32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppTheme.space8,
            runSpacing: AppTheme.space8,
            children: tags.map((tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                border: Border.all(color: AppTheme.primary.withValues(alpha: 0.15)),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary.withValues(alpha: 0.8),
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
              _buildAction(AppTheme.primary, Icons.open_in_new, 'Live Demo'),
              _buildAction(AppTheme.textSecondary, Icons.code, 'GitHub'),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: delay.ms).slideY(begin: 0.05);
  }

  Widget _buildAction(Color color, IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 14),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
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

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
        Padding(
          padding: const EdgeInsets.only(top: AppTheme.spaceLg, bottom: AppTheme.spaceLg),
          child: Text('Featured Projects', style: Theme.of(context).textTheme.displaySmall),
        ).animate().fadeIn().slideY(),
        StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppTheme.spaceLg,
          crossAxisSpacing: AppTheme.spaceLg,
          children: [
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: const _ProjectCard(
                title: 'Salon Studio',
                description: 'A feature-rich salon booking and management app that streamlines scheduling, staff management, and offline syncing.',
                tags: ['Flutter', 'BLoC', 'Firebase', 'Hive'],
                gradient: [Colors.indigo, Colors.blue],
              ),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: const _ProjectCard(
                title: 'Your Next Project',
                description: 'Placeholder for another amazing project you have built or will build in the future.',
                tags: ['Dart', 'REST API', 'Clean Arch'],
                gradient: [Colors.teal, Colors.green],
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
      child: GlassContainer(
        padding: const EdgeInsets.all(AppTheme.spaceXl),
        gradientColors: gradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppTheme.spaceSm,
              runSpacing: AppTheme.spaceSm,
              children: tags.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppTheme.spaceSm + 4),
            Text(
              description,
              style: TextStyle(color: Colors.grey[400], height: 1.6),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            Row(
              children: [
                _ActionButton(icon: Icons.open_in_new, label: 'Live Demo'),
                const SizedBox(width: AppTheme.spaceSm + 8),
                _ActionButton(icon: Icons.code, label: 'GitHub'),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: delay.ms).slideY();
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(widget.icon, size: 16),
        label: Text(widget.label),
        style: ElevatedButton.styleFrom(
          backgroundColor: _isHovered
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.05),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
          ),
        ),
      ),
    );
  }
}

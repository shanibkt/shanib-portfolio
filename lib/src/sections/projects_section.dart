import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: Text('Featured Projects', style: Theme.of(context).textTheme.displaySmall),
        ).animate().fadeIn().slideY(),
        StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
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
      child: Container(
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: gradient.map((c) => c.withOpacity(0.1)).toList(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GlassContainer(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Text(tag, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                )).toList(),
              ),
              const SizedBox(height: 24),
              Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(color: Colors.grey[400], height: 1.5),
              ),
              const Spacer(),
              const Row(
                children: [
                  _ActionButton(icon: Icons.open_in_new, label: 'Live Demo'),
                  SizedBox(width: 16),
                  _ActionButton(icon: Icons.code, label: 'GitHub'),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: delay.ms).slideY();
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.05),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
    );
  }
}

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
        Row(
          children: [
            Container(
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: AppTheme.primaryGradient,
              ),
            ),
            const SizedBox(width: AppTheme.space16),
            Flexible(
              child: Text('Experience & Journey', style: Theme.of(context).textTheme.displaySmall),
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
              child: SpotlightWrapper(
                borderRadius: AppTheme.radius20,
                child: GlassContainer(
                  borderRadius: AppTheme.radius20,
                  padding: const EdgeInsets.all(AppTheme.space32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About Me', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: AppTheme.space20),
                      Text(
                        'I am a Flutter Developer with hands-on experience building scalable, production-ready mobile applications. My technical expertise includes BLoC state management, robust REST API integration, and various local storage solutions like Hive and SQLite.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppTheme.space16),
                      Container(
                        padding: const EdgeInsets.all(AppTheme.space16),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(AppTheme.radius12),
                          border: Border.all(color: AppTheme.primary.withValues(alpha: 0.1)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.bolt, color: AppTheme.primary, size: 20),
                            const SizedBox(width: AppTheme.space12),
                            Expanded(
                              child: Text(
                                'My Goal: To build high-quality, scalable mobile applications and continuously grow as a software engineer while contributing to impactful products at leading global technology companies.',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn().slideY(),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: SpotlightWrapper(
                borderRadius: AppTheme.radius20,
                child: GlassContainer(
                  borderRadius: AppTheme.radius20,
                  padding: const EdgeInsets.all(AppTheme.space32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Experience', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: AppTheme.space32),
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
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.background, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.3),
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primary.withValues(alpha: 0.3),
                          AppTheme.primary.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppTheme.space20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: Text(
                      period,
                      style: const TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.space12),
                  Text(
                    role,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: AppTheme.space4),
                  Text(
                    company,
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppTheme.space12),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                      height: 1.7,
                    ),
                  ),
                  if (!isLast) const SizedBox(height: AppTheme.space32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';

class ExperienceSection extends StatelessWidget {
  final int crossAxisCount;
  const ExperienceSection({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final int cellCount = crossAxisCount == 12 ? 6 : crossAxisCount == 8 ? 8 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(context, 'Experience & Journey'),
        const SizedBox(height: AppTheme.space32),
        StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppTheme.space24,
          crossAxisSpacing: AppTheme.space24,
          children: [
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: GlassContainer(
                borderRadius: AppTheme.radius24,
                padding: const EdgeInsets.all(AppTheme.space32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About Me', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: AppTheme.space20),
                    Text(
                      'I am a Flutter Developer with hands-on experience building scalable, production-ready mobile applications. My expertise spans the entire development lifecycle, from architecture and BLoC state management to the successful deployment and maintenance of apps on the Google Play Store and Apple App Store.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppTheme.space16),
                    Container(
                      padding: const EdgeInsets.all(AppTheme.space16),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceLight,
                        borderRadius: BorderRadius.circular(AppTheme.radius12),
                        border: Border.all(color: AppTheme.border.withValues(alpha: 0.3)),
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
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.05).scaleXY(begin: 0.98, end: 1),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: GlassContainer(
                borderRadius: AppTheme.radius24,
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
                      description: 'Lead the development and maintenance of cross-platform mobile applications. Responsible for building responsive UI components, integrating complex RESTful APIs, and managing state using BLoC. Handled the full release cycle, including deploying and maintaining multiple production apps on both Google Play Store and Apple App Store.',
                      isLast: true,
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.05).scaleXY(begin: 0.98, end: 1),
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
          height: 28,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.cardBg, width: 2),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scaleXY(begin: 1, end: 1.4, duration: 2000.ms, curve: Curves.easeInOut),
            if (!isLast)
              Container(
                width: 1,
                height: 150, // Fixed height for line or use a different approach
                color: AppTheme.border.withValues(alpha: 0.4),
              ),
          ],
        ),
        const SizedBox(width: AppTheme.space20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: Text(
                  period,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
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
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppTheme.space12),
              Text(
                description,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  height: 1.7,
                ),
              ),
              if (!isLast) const SizedBox(height: AppTheme.space32),
            ],
          ),
        ),
      ],
    );
  }
}

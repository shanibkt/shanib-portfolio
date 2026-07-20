import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../components/mouse_gradient_bg.dart';
import '../components/navigation_bar.dart' as nav;
import '../sections/hero_section.dart';
import '../sections/avatar_section.dart';
import '../sections/stats_section.dart';
import '../sections/projects_section.dart';
import '../sections/tech_arsenal_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseGradientBg(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(top: 100, left: 24, right: 24, bottom: 64),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = 12;
                            if (constraints.maxWidth < 600) {
                              crossAxisCount = 1;
                            } else if (constraints.maxWidth < 1000) {
                              crossAxisCount = 8;
                            }

                            return StaggeredGrid.count(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 24,
                              children: [
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount == 12 ? 7 : crossAxisCount == 8 ? 8 : 1,
                                  child: const HeroSection(),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount == 12 ? 5 : crossAxisCount == 8 ? 8 : 1,
                                  child: const AvatarSection(),
                                ),
                                ...StatsSection.buildTiles(crossAxisCount),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: const ProjectsSection(crossAxisCount: 12),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: const TechArsenalSection(),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: const ExperienceSection(crossAxisCount: 12),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: const ContactSection(),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const nav.NavigationBar(),
          ],
        ),
      ),
    );
  }
}

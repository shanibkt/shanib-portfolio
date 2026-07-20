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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseGradientBg(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
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
                                  child: HeroSection(
                                    onViewWorkTap: () => _scrollTo(_projectsKey),
                                    onContactTap: () => _scrollTo(_contactKey),
                                  ),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount == 12 ? 5 : crossAxisCount == 8 ? 8 : 1,
                                  child: const AvatarSection(),
                                ),
                                ...StatsSection.buildTiles(crossAxisCount),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: KeyedSubtree(
                                    key: _projectsKey,
                                    child: const ProjectsSection(crossAxisCount: 12),
                                  ),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: const TechArsenalSection(),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: KeyedSubtree(
                                    key: _experienceKey,
                                    child: const ExperienceSection(crossAxisCount: 12),
                                  ),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: KeyedSubtree(
                                    key: _contactKey,
                                    child: const ContactSection(),
                                  ),
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
            nav.NavigationBar(
              onAboutTap: _scrollToTop,
              onProjectsTap: () => _scrollTo(_projectsKey),
              onExperienceTap: () => _scrollTo(_experienceKey),
              onHireTap: () => _scrollTo(_contactKey),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../theme/app_theme.dart';
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
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.08,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseGradientBg(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 80,
                    left: AppTheme.space24,
                    right: AppTheme.space24,
                    bottom: AppTheme.space64,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
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
                              mainAxisSpacing: AppTheme.space24,
                              crossAxisSpacing: AppTheme.space24,
                              children: [
                                StaggeredGridTile.fit(
                                  crossAxisCellCount:
                                      crossAxisCount == 12 ? 7 : crossAxisCount == 8 ? 8 : 1,
                                  child: HeroSection(
                                    onViewWorkTap: () => _scrollTo(_projectsKey),
                                    onContactTap: () => _scrollTo(_contactKey),
                                  ),
                                ),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount:
                                      crossAxisCount == 12 ? 5 : crossAxisCount == 8 ? 8 : 1,
                                  child: const AvatarSection(),
                                ),
                                StatsSection.buildRow(crossAxisCount),
                                StaggeredGridTile.fit(
                                  crossAxisCellCount: crossAxisCount,
                                  child: KeyedSubtree(
                                    key: _projectsKey,
                                    child: ProjectsSection(crossAxisCount: crossAxisCount),
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
                                    child: ExperienceSection(crossAxisCount: crossAxisCount),
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

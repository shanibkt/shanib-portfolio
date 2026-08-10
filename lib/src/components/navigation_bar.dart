import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class NavigationBar extends StatelessWidget {
  final VoidCallback? onAboutTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onExperienceTap;
  final VoidCallback? onHireTap;
  final double scrollProgress;

  const NavigationBar({
    super.key,
    this.onAboutTap,
    this.onProjectsTap,
    this.onExperienceTap,
    this.onHireTap,
    this.scrollProgress = 0,
  });

  Future<void> _downloadCV() async {
    // Since cv.pdf is in the web/ folder, it's served at the root of the site.
    final Uri url = Uri.parse('cv.pdf');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppTheme.space16,
              bottom: AppTheme.space16,
              left: AppTheme.space24,
              right: AppTheme.space24,
            ),
            decoration: BoxDecoration(
              color: AppTheme.background.withValues(alpha: 0.85),
              border: Border(
                bottom: BorderSide(color: AppTheme.border.withValues(alpha: 0.2)),
              ),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onAboutTap,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppTheme.space8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppTheme.primary, AppTheme.primary.withValues(alpha: 0.7)],
                              ),
                              borderRadius: BorderRadius.circular(AppTheme.radius12),
                            ),
                            child: const Icon(
                              Icons.code_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: AppTheme.space12),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                                fontFamily: 'SpaceGrotesk',
                              ),
                              children: [
                                TextSpan(
                                  text: 'SHANIB',
                                  style: TextStyle(color: AppTheme.textPrimary),
                                ),
                                TextSpan(
                                  text: '.DEV',
                                  style: TextStyle(color: AppTheme.primary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile)
                      Row(
                        children: [
                          _NavItem(title: 'About', onTap: onAboutTap),
                          const SizedBox(width: AppTheme.space32),
                          _NavItem(title: 'Projects', onTap: onProjectsTap),
                          const SizedBox(width: AppTheme.space32),
                          _NavItem(title: 'Experience', onTap: onExperienceTap),
                          const SizedBox(width: AppTheme.space32),
                          _NavItem(title: 'Resume', onTap: _downloadCV),
                        ],
                      ),
                    if (isMobile)
                      _HireFloating(onTap: onHireTap)
                    else
                      _HireButton(onTap: onHireTap),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 2,
            width: double.infinity,
            color: AppTheme.background,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: scrollProgress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primary,
                      AppTheme.primary.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HireButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _HireButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text(
            'Hire Me',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _HireFloating extends StatelessWidget {
  final VoidCallback? onTap;
  const _HireFloating({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(Icons.email_outlined, size: 20, color: AppTheme.textPrimary),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;

  const _NavItem({required this.title, this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: _isHovered ? AppTheme.textPrimary : AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}

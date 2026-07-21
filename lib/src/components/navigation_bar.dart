import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'magnetic_wrapper.dart';

class NavigationBar extends StatelessWidget {
  final VoidCallback? onAboutTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onExperienceTap;
  final VoidCallback? onHireTap;

  const NavigationBar({
    super.key,
    this.onAboutTap,
    this.onProjectsTap,
    this.onExperienceTap,
    this.onHireTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppTheme.spaceMd,
              bottom: AppTheme.spaceMd,
              left: AppTheme.spaceLg,
              right: AppTheme.spaceLg,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              border: Border(
                bottom: BorderSide(color: AppTheme.glassBorder),
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
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                          children: const [
                            TextSpan(text: 'Dev'),
                            TextSpan(
                              text: '.',
                              style: TextStyle(color: AppTheme.accent),
                            ),
                            TextSpan(text: 'Portfolio'),
                          ],
                        ),
                      ),
                    ),
                    if (!isMobile)
                      Row(
                        children: [
                          _NavItem(title: 'About', onTap: onAboutTap),
                          const SizedBox(width: AppTheme.spaceXl),
                          _NavItem(title: 'Projects', onTap: onProjectsTap),
                          const SizedBox(width: AppTheme.spaceXl),
                          _NavItem(title: 'Experience', onTap: onExperienceTap),
                        ],
                      ),
                    if (isMobile)
                      MagneticWrapper(
                        child: ElevatedButton(
                          onPressed: onHireTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spaceMd,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(44, 44),
                          ),
                          child: const Icon(Icons.email_outlined, size: 20),
                        ),
                      )
                    else
                      MagneticWrapper(
                        child: ElevatedButton(
                          onPressed: onHireTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spaceLg,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Hire Me',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
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

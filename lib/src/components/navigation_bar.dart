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
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + AppTheme.space16,
          bottom: AppTheme.space16,
          left: AppTheme.space24,
          right: AppTheme.space24,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.background.withValues(alpha: 0.85),
              AppTheme.background.withValues(alpha: 0.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                        letterSpacing: -0.5,
                      ),
                      children: [
                        const TextSpan(text: 'Dev'),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const TextSpan(text: 'Portfolio'),
                      ],
                    ),
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
                    ],
                  ),
                if (isMobile)
                  MagneticWrapper(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      ),
                      child: IconButton(
                        onPressed: onHireTap,
                        icon: const Icon(Icons.email_outlined, size: 20, color: Colors.white),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  )
                else
                  MagneticWrapper(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      ),
                      child: GestureDetector(
                        onTap: onHireTap,
                        child: const Text(
                          'Hire Me',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
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

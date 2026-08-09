import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';

class ProjectsSection extends StatelessWidget {
  final int crossAxisCount;
  const ProjectsSection({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final int cellCount = crossAxisCount == 12 ? 6 : crossAxisCount == 8 ? 4 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(context, 'Featured Projects'),
        const SizedBox(height: AppTheme.space32),
        StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppTheme.space24,
          crossAxisSpacing: AppTheme.space24,
          children: [
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: const _ProjectCard(
                title: 'Saloon Studio',
                description: 'A mobile salon booking application designed to provide customers with a smooth experience for discovering salon services, selecting stylists, and managing appointments.',
                tags: ['Flutter', 'Dart', 'REST API', 'BLoC', 'Payment Gateway Integration', 'Flutter Localization'],
                platform: 'Mobile App',
                isSolo: true,
                contributions: [
                  'Implemented user registration and OTP-based authentication.',
                  'Developed salon service and stylist selection workflows.',
                  'Built appointment booking and management functionality.',
                  'Implemented real-time booking status updates.',
                  'Developed customer profile management features.',
                  'Added multilingual support using Flutter localization.',
                  'Created responsive UI layouts optimized for Android devices.',
                  'Implemented scalable application logic using BLoC state management.',
                  'Integrated payment gateway functionality.'
                ],
                liveUrl: 'https://play.google.com/store/apps/details?id=com.appziac.salonstudio&pcampaignid=web_share',
              ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05).scaleXY(begin: 0.97, end: 1),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: const _ProjectCard(
                title: 'T&T Kitchen Order App',
                description: 'A production mobile application focused on managing purchase requests, vendors, orders, inventory items, and Proof of Delivery (POD) workflows.',
                tags: ['Flutter', 'Dart', 'BLoC', 'REST API'],
                platform: 'Mobile App',
                isSolo: false,
                contributions: [
                  'Redesigned and enhanced multiple production screens to improve usability and user experience.',
                  'Integrated REST APIs for purchase request management, vendor management, and POD workflows.',
                  'Implemented BLoC state management for dynamic order processing and UI updates.',
                  'Integrated camera and gallery functionality for capturing and selecting documents and images.',
                  'Implemented file picker functionality for document uploads.',
                  'Added sharing intents for sharing documents and images.',
                  'Developed custom input validation for unit-based and weight-based inventory items.',
                  'Worked with backend services to ensure reliable API integration and data handling.'
                ],
                liveUrl: 'https://play.google.com/store/apps/details?id=com.tandt.hospitality&pcampaignid=web_share',
                delay: 200,
              ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.05).scaleXY(begin: 0.97, end: 1),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: cellCount,
              child: const _ProjectCard(
                title: 'Peedia',
                description: 'A merchant management platform designed to support business operations including inventory, order management, customer management, and other merchant workflows.',
                tags: ['Flutter', 'Dart', 'REST API', 'BLoC'],
                platform: 'Merchant Platform',
                isSolo: false,
                contributions: [
                  'Redesigned Complete App based on updated UI/UX requirements.',
                  'Integrated REST APIs across inventory, order management, and customer modules.',
                  'Developed responsive Flutter UI components for merchant operations.',
                  'Enhanced existing application functionality through bug fixes and performance improvements.',
                  'Assisted in implementing payment, logistics, and merchant management workflows.',
                  'Maintained and enhanced the production codebase by resolving UI and API-related issues.',
                  'Collaborated with backend developers and UI/UX designers during feature implementation and testing.'
                ],
                liveUrl: 'https://play.google.com/store/apps/details?id=com.peedia.store&pcampaignid=web_share',
                delay: 400,
              ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideY(begin: 0.05).scaleXY(begin: 0.97, end: 1),
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
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppTheme.primary,
          ),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
          .animate()
          .fadeIn()
          .slideX(begin: -0.05),
        const SizedBox(width: AppTheme.space16),
        Flexible(
          child: Text(title, style: Theme.of(context).textTheme.displaySmall),
        ).animate().fadeIn().slideX(begin: -0.05),
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final List<String>? contributions;
  final String? imageUrl;
  final int delay;
  final String? liveUrl;
  final String? githubUrl;
  final String? platform;
  final String? year;
  final bool isSolo;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
    this.contributions,
    this.imageUrl,
    this.delay = 0,
    this.liveUrl,
    this.githubUrl,
    this.platform,
    this.year,
    this.isSolo = false,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: _isHovered
            ? Matrix4.translationValues(0, -6, 0)
            : Matrix4.identity(),
        child: GlassContainer(
          borderRadius: AppTheme.radius24,
          padding: const EdgeInsets.all(AppTheme.space32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.imageUrl != null) ...[
                Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: AppTheme.space24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.radius16),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ],
              Wrap(
                spacing: AppTheme.space12,
                runSpacing: AppTheme.space12,
                children: [
                  if (widget.platform != null)
                    _buildMeta(Icons.devices, widget.platform!),
                  if (widget.year != null)
                    _buildMeta(Icons.calendar_today, widget.year!),
                  _buildMeta(
                    widget.isSolo ? Icons.person : Icons.group,
                    widget.isSolo ? 'Solo Build' : 'Contributed',
                    color: widget.isSolo ? AppTheme.success : AppTheme.warning,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.space20),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.space12),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.7,
                    ),
              ),
              if (widget.contributions != null && widget.contributions!.isNotEmpty) ...[
                const SizedBox(height: AppTheme.space20),
                _buildSectionTitle(widget.isSolo ? 'Project Highlights' : 'My Contributions'),
                const SizedBox(height: AppTheme.space8),
                ...widget.contributions!.map((c) => _buildBulletPoint(c)),
              ],
              const SizedBox(height: AppTheme.space24),
              const Divider(),
              const SizedBox(height: AppTheme.space24),
              Wrap(
                spacing: AppTheme.space8,
                runSpacing: AppTheme.space8,
                children: widget.tags.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                    border: Border.all(color: AppTheme.primary.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primary,
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: AppTheme.space24),
              Wrap(
                spacing: AppTheme.space12,
                runSpacing: AppTheme.space12,
                children: [
                  if (widget.liveUrl != null)
                    _buildAction(AppTheme.primary, Icons.open_in_new, 'Live Demo', widget.liveUrl!),
                  if (widget.githubUrl != null)
                    _buildAction(AppTheme.textSecondary, Icons.code, 'GitHub', widget.githubUrl!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeta(IconData icon, String text, {Color color = AppTheme.textSecondary}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color.withValues(alpha: 0.7)),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(Color color, IconData icon, String label, String url) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: ElevatedButton.icon(
        onPressed: () => _launch(url),
        icon: Icon(icon, size: 14),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radius12),
          ),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

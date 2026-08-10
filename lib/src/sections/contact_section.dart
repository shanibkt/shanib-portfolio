import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../components/glass_container.dart';
import '../services/contact_service.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _placeController = TextEditingController();
  final _mobileController = TextEditingController();
  final _contactService = ContactService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _placeController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final response = await _contactService.sendMessage(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      message: _messageController.text.trim(),
      place: _placeController.text.trim(),
      mobile: _mobileController.text.trim(),
    );

    if (mounted) {
      setState(() => _isLoading = false);

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: AppTheme.success,
          ),
        );
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        _placeController.clear();
        _mobileController.clear();
        _formKey.currentState?.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.message}'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AppTheme.radius24,
      padding: const EdgeInsets.all(AppTheme.space32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(context, 'Get in Touch'),
          const SizedBox(height: AppTheme.space40),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;
              
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildContactInfo(context)),
                    const SizedBox(width: AppTheme.space48),
                    Expanded(flex: 3, child: _buildContactForm(context)),
                  ],
                );
              }

              return Column(
                children: [
                  _buildContactInfo(context),
                  const SizedBox(height: AppTheme.space48),
                  _buildContactForm(context),
                ],
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05);
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something amazing together.",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: AppTheme.space12),
        Text(
          "I'm currently available for freelance work and full-time opportunities. Feel free to reach out through any of these platforms or use the contact form.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.space32),
        const _ContactItem(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'shanib.personal@gmail.com',
          url: 'mailto:shanib.personal@gmail.com',
          index: 0,
        ),
        const SizedBox(height: AppTheme.space16),
        const _ContactItem(
          icon: Icons.code,
          label: 'GitHub',
          value: 'github.com/shanibkt',
          url: 'https://github.com/shanibkt',
          index: 1,
        ),
        const SizedBox(height: AppTheme.space16),
        const _ContactItem(
          icon: Icons.link,
          label: 'LinkedIn',
          value: 'linkedin.com/in/shanib-k-t-',
          url: 'https://www.linkedin.com/in/shanib-k-t-/',
          index: 2,
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: LayoutBuilder(
        builder: (context, formConstraints) {
          final stackFields = formConstraints.maxWidth < 500;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (stackFields) ...[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'John Doe',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppTheme.space20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'john@example.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'John Doe',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: AppTheme.space16),
                    Expanded(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'john@example.com',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: AppTheme.space20),
              if (stackFields) ...[
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    labelText: 'Place',
                    hintText: 'Dubai, UAE',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppTheme.space20),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile',
                    hintText: '+971 50 123 4567',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _placeController,
                        decoration: const InputDecoration(
                          labelText: 'Place',
                          hintText: 'Dubai, UAE',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your location';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: AppTheme.space16),
                    Expanded(
                      child: TextFormField(
                        controller: _mobileController,
                        decoration: const InputDecoration(
                          labelText: 'Mobile',
                          hintText: '+971 50 123 4567',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: AppTheme.space20),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  hintText: 'How can I help you?',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a message';
                  }
                  if (value.trim().length < 10) {
                    return 'Message should be at least 10 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.space32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Send Message'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.space8),
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppTheme.radius12),
          ),
          child: const Icon(
            Icons.alternate_email_rounded,
            color: AppTheme.primary,
            size: 24,
          ),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
          .shimmer(duration: 2000.ms, color: AppTheme.primary.withValues(alpha: 0.2)),
        const SizedBox(width: AppTheme.space16),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ],
    ).animate().fadeIn().slideX(begin: -0.05);
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;
  final int index;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.index,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final delay = 300 + (widget.index * 100);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: _isHovered
              ? Matrix4.translationValues(0, -4, 0)
              : Matrix4.identity(),
          padding: const EdgeInsets.all(AppTheme.space20),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.surfaceLight : AppTheme.cardBg,
            borderRadius: BorderRadius.circular(AppTheme.radius16),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primary.withValues(alpha: 0.3)
                  : AppTheme.border.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppTheme.primary.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.icon,
                    color: _isHovered ? AppTheme.primary : AppTheme.textSecondary,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.space16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppTheme.space4),
                    Text(
                      widget.value,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: _isHovered ? AppTheme.textPrimary : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: delay.ms).slideY(begin: 0.08);
  }
}

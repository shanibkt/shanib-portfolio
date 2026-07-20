import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/glass_container.dart';
import '../components/spotlight_wrapper.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SpotlightWrapper(
      child: GlassContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Me', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 32),
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    _ContactItem(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: 'shani@example.com',
                    ),
                    _ContactItem(
                      icon: Icons.code,
                      label: 'GitHub',
                      value: 'github.com/shanii',
                    ),
                    _ContactItem(
                      icon: Icons.link,
                      label: 'LinkedIn',
                      value: 'linkedin.com/in/shanii',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY();
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.blueAccent),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

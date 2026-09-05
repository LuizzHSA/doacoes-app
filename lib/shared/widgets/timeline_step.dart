import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class TimelineStep extends StatelessWidget {
  const TimelineStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.completed,
    this.isLast = false,
  });
  final String title;
  final String subtitle;
  final bool completed;
  final bool isLast;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: isLast ? 58 : 82,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 28,
          child: Column(
            children: [
              Icon(
                completed ? Icons.check_circle : Icons.circle_outlined,
                color: completed
                    ? AppColors.secondary
                    : Theme.of(context).colorScheme.outline,
                size: 23,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: completed
                        ? AppColors.secondary
                        : Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(subtitle),
            ],
          ),
        ),
      ],
    ),
  );
}

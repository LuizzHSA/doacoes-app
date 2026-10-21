import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class ResponsivePageBody extends StatelessWidget {
  const ResponsivePageBody({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(18, 12, 18, 28),
    this.maxWidth = 680,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(padding: padding, child: child),
    ),
  );
}

class ReferenceHeader extends StatelessWidget implements PreferredSizeWidget {
  const ReferenceHeader({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) => AppBar(
    leading: onBack == null
        ? null
        : IconButton(
            onPressed: onBack,
            tooltip: 'Voltar',
            icon: const Icon(Icons.arrow_back),
          ),
    title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 16),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person_outline, color: Colors.white, size: 18),
        ),
      ),
    ],
  );
}

class ReferenceCard extends StatelessWidget {
  const ReferenceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.color = Colors.white,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: Color(0x0B17233B), blurRadius: 14, offset: Offset(0, 3)),
      ],
    ),
    child: child,
  );
}

class ReferencePill extends StatelessWidget {
  const ReferencePill({
    super.key,
    required this.label,
    this.color = const Color(0xFFE7EEFF),
    this.foregroundColor = const Color(0xFF121C2C),
    this.icon,
  });

  final String label;
  final Color color;
  final Color foregroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: foregroundColor),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class ReferencePhoto extends StatelessWidget {
  const ReferencePhoto({
    super.key,
    this.imageUrl,
    this.height = 160,
    this.icon = Icons.volunteer_activism_outlined,
    this.borderRadius = 12,
  });

  final String? imageUrl;
  final double height;
  final IconData icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: SizedBox(
      width: double.infinity,
      height: height,
      child: imageUrl == null
          ? _placeholder()
          : Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _placeholder(),
            ),
    ),
  );

  Widget _placeholder() => ColoredBox(
    color: AppColors.surfaceContainer,
    child: Center(
      child: Icon(icon, color: AppColors.primary, size: 42),
    ),
  );
}

class SectionHeading extends StatelessWidget {
  const SectionHeading(this.title, {super.key, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      if (trailing != null) trailing!,
    ],
  );
}
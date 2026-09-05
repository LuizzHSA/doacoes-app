import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/models/campaign.dart';
import '../../shared/widgets/app_shell.dart';
import '../../shared/widgets/campaign_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: PageHeader(
      title: 'Início',
      onProfile: () => context.pushNamed('login'),
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        const Text(
          'Bom dia',
          style: TextStyle(color: AppColors.lightTextSecondary),
        ),
        const SizedBox(height: 5),
        const Text(
          'Olá, João!',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Campanhas Urgentes',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: () => context.go('/explore'),
              child: const Text('Ver todas'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 365,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (_, index) => SizedBox(
              width: 320,
              child: CampaignCard(campaign: campaigns[index]),
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Impacto na Comunidade',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),
        const _ImpactTile(
          icon: Icons.check_circle_outline,
          date: 'Hoje, 14:30',
          text: 'A família Silva recebeu as cestas básicas! Graças a doadores como você, eles têm alimentação garantida para este mês.',
        ),
        const SizedBox(height: 12),
        const _ImpactTile(
          icon: Icons.celebration_outlined,
          date: 'Ontem',
          text: 'Meta atingida: a reforma do telhado da creche comunitária começa na próxima segunda-feira.',
        ),
      ],
    ),
  );
}

class _ImpactTile extends StatelessWidget {
  const _ImpactTile({
    required this.icon,
    required this.date,
    required this.text,
  });
  final IconData icon;
  final String date;
  final String text;
  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    color: Theme.of(context).colorScheme.surface,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.secondary.withValues(alpha: .2),
            child: Icon(icon, color: AppColors.secondary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(date), const SizedBox(height: 5), Text(text)],
            ),
          ),
        ],
      ),
    ),
  );
}

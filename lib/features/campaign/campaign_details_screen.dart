import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/state/app_providers.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/models/campaign.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/timeline_step.dart';

class CampaignDetailsScreen extends ConsumerWidget {
  const CampaignDetailsScreen({super.key, required this.campaignId});
  final String campaignId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(campaignProvider(campaignId)).when(
      data: (campaign) => Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Cover()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _Intro(campaign: campaign),
                const SizedBox(height: 24),
                const Text(
                  'O que precisamos?',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                _Progress(campaign: campaign),
                const SizedBox(height: 24),
                const Text(
                  'Quem recebe?',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                const _Recipient(),
                const SizedBox(height: 24),
                const Text(
                  'Acompanhamento e Transparência',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 14),
                const _Timeline(),
                const SizedBox(height: 28),
                PrimaryButton(
                  label: 'Quero Doar',
                  icon: Icons.volunteer_activism,
                  onPressed: () => context.pushNamed(
                    'checkout',
                    pathParameters: {'id': campaign.id},
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      ),
      loading: () => const Scaffold(
        appBar: AppBar(title: Text('Detalhes')),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Scaffold(
        appBar: AppBar(title: const Text('Detalhes')),
        body: Center(
          child: TextButton.icon(
            onPressed: () => ref.invalidate(campaignProvider(campaignId)),
            icon: const Icon(Icons.refresh),
            label: const Text('Não foi possível carregar. Tentar novamente'),
          ),
        ),
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover();
  @override
  Widget build(BuildContext context) => Container(
    height: 240,
    color: AppColors.primary.withValues(alpha: .14),
    child: const Center(
      child: Icon(Icons.school, size: 90, color: AppColors.primary),
    ),
  );
}

class _Intro extends StatelessWidget {
  const _Intro({required this.campaign});
  final Campaign campaign;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                campaign.category.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.secondary,
                  letterSpacing: 1.2,
                ),
              ),
              Text('♡ ${campaign.supporters} apoios'),
            ],
          ),
          const SizedBox(height: 12),
          Text(campaign.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(campaign.description),
        ],
      ),
    ),
  );
}

class _Progress extends StatelessWidget {
  const _Progress({required this.campaign});
  final Campaign campaign;
  @override
  Widget build(BuildContext context) => Card(
    color: AppColors.primary.withValues(alpha: .10),
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'R\$ ${campaign.raised.toStringAsFixed(0)} / R\$ ${campaign.goal.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${(campaign.progress * 100).round()}%',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: campaign.progress,
              minHeight: 9,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 10),
          const Text('Faltam apenas R\$ 1.500 para garantirmos todos os kits!'),
        ],
      ),
    ),
  );
}

class _Recipient extends StatelessWidget {
  const _Recipient();
  @override
  Widget build(BuildContext context) => const Card(
    child: Padding(
      padding: EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.secondary,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              'Projeto Educar e Crescer\n\nO projeto atende crianças da comunidade do Jardim Esperança há 5 anos, oferecendo reforço escolar e atividades extracurriculares.',
            ),
          ),
        ],
      ),
    ),
  );
}

class _Timeline extends StatelessWidget {
  const _Timeline();
  @override
  Widget build(BuildContext context) => const Card(
    child: Padding(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          TimelineStep(
            title: 'Campanha Criada',
            subtitle: '12 Fev - Verificação concluída',
            completed: true,
          ),
          TimelineStep(
            title: 'Arrecadação Ativa',
            subtitle: 'Em andamento - 70% concluído',
            completed: true,
          ),
          TimelineStep(
            title: 'Meta Atingida',
            subtitle: 'Aguardando arrecadação',
            completed: false,
          ),
          TimelineStep(
            title: 'Entrega Realizada',
            subtitle: 'Aguardando campanha',
            completed: false,
            isLast: true,
          ),
        ],
      ),
    ),
  );
}

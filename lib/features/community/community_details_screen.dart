import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/reference_ui.dart';

class CommunityDetailsScreen extends StatefulWidget {
  const CommunityDetailsScreen({super.key, required this.communityId});

  final String communityId;

  @override
  State<CommunityDetailsScreen> createState() => _CommunityDetailsScreenState();
}

class _CommunityDetailsScreenState extends State<CommunityDetailsScreen> {
  int _selectedTab = 0;
  bool _following = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ReferenceHeader(title: 'Detalhes da Comunidade'),
    body: ResponsivePageBody(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 22),
      child: ListView(
        children: [
          _hero(),
          const SizedBox(height: 12),
          _locationCard(),
          const SizedBox(height: 12),
          _leaderCard(),
          const SizedBox(height: 22),
          const SectionHeading(
            'Nosso Impacto Real',
            trailing: ReferencePill(
              label: '100% auditado',
              color: Colors.transparent,
              foregroundColor: AppColors.secondary,
              icon: Icons.shield_outlined,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(child: _ImpactMetric(value: '312', label: 'Famílias atendidas')),
              SizedBox(width: 8),
              Expanded(child: _ImpactMetric(value: '18', label: 'Campanhas concluídas')),
              SizedBox(width: 8),
              Expanded(child: _ImpactMetric(value: 'R\$ 64k', label: 'Repassados com NF')),
            ],
          ),
          const SizedBox(height: 18),
          _pickupPoint(),
          const SizedBox(height: 18),
          _tabs(),
          const SizedBox(height: 12),
          _tabContent(),
        ],
      ),
    ),
    bottomNavigationBar: SafeArea(
      minimum: const EdgeInsets.fromLTRB(18, 8, 18, 10),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () => context.pushNamed(
                'checkout',
                pathParameters: {'id': 'cestas-emergenciais'},
              ),
              icon: const Icon(Icons.favorite_border),
              label: const Text('Fazer doação'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _showMessage('Cadastro de voluntários em breve.'),
              icon: const Icon(Icons.handshake_outlined),
              label: const Text('Ser voluntário'),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _hero() => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Stack(
      children: [
        const ReferencePhoto(
          imageUrl:
              'https://images.unsplash.com/photo-1529156069898-49953e39b9a?auto=format&fit=crop&w=1200&q=85',
          height: 230,
          icon: Icons.groups,
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: .72),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 12,
          right: 12,
          bottom: 14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  ReferencePill(
                    label: 'Comunidade verificada',
                    color: AppColors.secondary,
                    foregroundColor: Colors.white,
                    icon: Icons.verified,
                  ),
                  ReferencePill(
                    label: 'Responde em ~20 min',
                    color: Colors.white,
                    icon: Icons.schedule,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.communityId == 'morro-da-cruz'
                    ? 'Associação Comunitária Morro da Cruz'
                    : 'Comunidade Esperança Viva',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _locationCard() => ReferenceCard(
    color: AppColors.lightSurfaceContainer,
    child: Row(
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFFD4E3FF),
          child: Icon(Icons.near_me, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pinheiros, São Paulo - SP', style: TextStyle(fontWeight: FontWeight.w800)),
              Text('A 1,8 km do seu local atual'),
            ],
          ),
        ),
        const ReferencePill(
          label: 'Aberta hoje',
          color: AppColors.secondaryContainer,
          foregroundColor: AppColors.secondary,
        ),
      ],
    ),
  );

  Widget _leaderCard() => ReferenceCard(
    child: Column(
      children: [
        const Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: Color(0xFFD9E3F9),
              child: Icon(Icons.person, color: AppColors.primary, size: 30),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dona Neusa 💚', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  Text('Líder Comunitária há 14 anos'),
                  Text('“Nenhum prato vazio enquanto houver união.”', style: TextStyle(color: AppColors.primary, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: AppColors.secondary),
                onPressed: () => _showMessage('Conversa segura em breve.'),
                icon: const Icon(Icons.chat_outlined),
                label: const Text('Conversar'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _following = !_following),
                icon: Icon(_following ? Icons.check : Icons.add),
                label: Text(_following ? 'Seguindo' : 'Seguir atualizações'),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _pickupPoint() => ReferenceCard(
    padding: EdgeInsets.zero,
    child: Column(
      children: [
        Container(
          height: 126,
          decoration: const BoxDecoration(
            color: Color(0xFFE3EDF3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: const Center(
            child: ReferencePill(
              label: 'Ponto de coleta',
              color: Colors.white,
              icon: Icons.location_on_outlined,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ponto de Apoio Oficial', style: TextStyle(fontWeight: FontWeight.w800)),
                    Text('Rua das Palmeiras, 142 • Seg a Sáb 08h-18h', maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => _showMessage('Mapa e rotas em breve.'),
                icon: const Icon(Icons.directions),
                label: const Text('Como chegar'),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _tabs() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _tabButton('Campanhas ativas (2)', 0),
        _tabButton('Necessidades físicas', 1),
        _tabButton('Últimas entregas', 2),
      ],
    ),
  );

  Widget _tabButton(String label, int index) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: ChoiceChip(
      label: Text(label),
      selected: _selectedTab == index,
      onSelected: (_) => setState(() => _selectedTab = index),
    ),
  );

  Widget _tabContent() => switch (_selectedTab) {
    0 => Column(
      children: [
        _campaignCard(
          'Cestas Básicas Emergenciais de Outono',
          'Meta de 100 cestas completas para famílias em vulnerabilidade.',
          4500,
          5000,
          '90% financiado',
          'cestas-emergenciais',
        ),
        const SizedBox(height: 12),
        _campaignCard(
          'Reforma da Cozinha Solidária',
          'Adequação dos fogões e armazenamento para refeições comunitárias.',
          8200,
          12000,
          '68% financiado',
          'cozinha-solidaria',
        ),
      ],
    ),
    1 => const Column(
      children: [
        _NeedCard(icon: Icons.checkroom, title: 'Agasalhos infantis', detail: 'Tamanhos 4 a 10 • Bom estado', urgent: true),
        SizedBox(height: 10),
        _NeedCard(icon: Icons.medication_outlined, title: 'Leite em pó integral', detail: 'Latas ou sachês lacrados'),
        SizedBox(height: 10),
        _NeedCard(icon: Icons.health_and_safety_outlined, title: 'Fraldas geriátricas', detail: 'Tamanhos M e G'),
      ],
    ),
    _ => const ReferenceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Entrega de cestas básicas', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Mais de 40 famílias receberam alimentos nesta semana.'),
          SizedBox(height: 12),
          Text('Mutirão de inverno', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Roupas e cobertores entregues a moradores do bairro.'),
        ],
      ),
    ),
  };

  Widget _campaignCard(
    String title,
    String description,
    double raised,
    double goal,
    String label,
    String campaignId,
  ) => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            const ReferencePhoto(
              imageUrl:
                  'https://images.unsplash.com/photo-1593113598332-cd288d649433?auto=format&fit=crop&w=1200&q=85',
              height: 132,
              icon: Icons.volunteer_activism,
              borderRadius: 8,
            ),
            Positioned(
              top: 8,
              left: 8,
              child: ReferencePill(
                label: label,
                color: Colors.white.withValues(alpha: .92),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 10),
        LinearProgressIndicator(value: (raised / goal).clamp(0, 1)),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('R\$ ${raised.toStringAsFixed(0)} arrecadados', style: const TextStyle(color: AppColors.secondary)),
            Text('Meta: R\$ ${goal.toStringAsFixed(0)}'),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => context.pushNamed('checkout', pathParameters: {'id': campaignId}),
            icon: const Icon(Icons.volunteer_activism),
            label: const Text('Doar agora nesta campanha'),
          ),
        ),
      ],
    ),
  );

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ImpactMetric extends StatelessWidget {
  const _ImpactMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 76),
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.lightSurfaceContainer,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(value, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 17)),
        ),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
      ],
    ),
  );
}

class _NeedCard extends StatelessWidget {
  const _NeedCard({required this.icon, required this.title, required this.detail, this.urgent = false});

  final IconData icon;
  final String title;
  final String detail;
  final bool urgent;

  @override
  Widget build(BuildContext context) => ReferenceCard(
    padding: const EdgeInsets.all(12),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.lightSurfaceContainer,
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              Text(detail, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        if (urgent)
          const ReferencePill(
            label: 'Urgente',
            color: Color(0xFFFFDAD6),
            foregroundColor: Color(0xFF93000A),
          ),
      ],
    ),
  );
}
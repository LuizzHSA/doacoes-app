import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/reference_ui.dart';

class CommunityListScreen extends StatefulWidget {
  const CommunityListScreen({super.key});

  @override
  State<CommunityListScreen> createState() => _CommunityListScreenState();
}

class _CommunityListScreenState extends State<CommunityListScreen> {
  final _searchController = TextEditingController();
  String _radius = 'Até 5 km';
  String _cause = 'Todas';
  bool _showMap = false;

  static const _communities = [
    _Community(
      id: 'morro-da-cruz',
      name: 'Associação Morro da Cruz',
      neighborhood: 'Pinheiros',
      city: 'São Paulo, SP',
      distance: '1,8 km',
      distanceKm: 1.8,
      causes: ['Alimentação', 'Infância'],
      description:
          'Polo comunitário que apoia mães solo e mantém uma cozinha solidária desde 2018.',
      impact: '312 famílias',
      campaigns: '4 ativas',
      verified: true,
      imageUrl:
          'https://images.unsplash.com/photo-1529156069898-49953e39b9a?auto=format&fit=crop&w=1200&q=85',
    ),
    _Community(
      id: 'esperanca-viva',
      name: 'Coletivo Esperança Viva',
      neighborhood: 'Vila Madalena',
      city: 'São Paulo, SP',
      distance: '3,4 km',
      distanceKm: 3.4,
      causes: ['Educação', 'Apoio a Mulheres'],
      description:
          'Aulas de reforço, oficinas de costura e assistência jurídica comunitária.',
      impact: '85 famílias',
      campaigns: '2 ativas',
      verified: true,
      imageUrl:
          'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=1200&q=85',
    ),
    _Community(
      id: 'jardim-das-flores',
      name: 'Centro Comunitário Jardim das Flores',
      neighborhood: 'Butantã',
      city: 'São Paulo, SP',
      distance: '6,2 km',
      distanceKm: 6.2,
      causes: ['Cestas Básicas', 'Saúde Básica'],
      description:
          'Ponto de distribuição de cestas e triagem de atendimento básico para moradores da região.',
      impact: '190 famílias',
      campaigns: '3 ativas',
      verified: true,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final maxDistance = switch (_radius) {
      'Até 5 km' => 5.0,
      'Até 15 km' => 15.0,
      'Até 30 km' => 30.0,
      _ => double.infinity,
    };
    final communities = _communities.where((community) {
      final matchesSearch = query.isEmpty ||
          '${community.name} ${community.neighborhood} ${community.causes.join(' ')}'
              .toLowerCase()
              .contains(query);
      final matchesCause = _cause == 'Todas' || community.causes.contains(_cause);
        return matchesSearch &&
          matchesCause &&
          community.distanceKm <= maxDistance;
    }).toList();

    return Scaffold(
      appBar: const ReferenceHeader(title: 'Comunidades'),
      body: ResponsivePageBody(
        child: ListView(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    '14 comunidades perto de você',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                SegmentedButton<bool>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: false, icon: Icon(Icons.view_list)),
                    ButtonSegment(value: true, icon: Icon(Icons.map_outlined)),
                  ],
                  selected: {_showMap},
                  onSelectionChanged: (value) =>
                      setState(() => _showMap = value.first),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Buscar por bairro, causa ou nome...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  tooltip: 'Filtros',
                  onPressed: () => _showFilters(context),
                  icon: const Icon(Icons.tune),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.near_me, color: AppColors.secondary, size: 18),
                const SizedBox(width: 6),
                const Expanded(child: Text('Próximo a você: São Paulo, SP')),
                TextButton(onPressed: () {}, child: const Text('Mudar')),
              ],
            ),
            _ChoiceStrip(
              values: const ['Até 5 km', 'Até 15 km', 'Até 30 km', 'Todas'],
              selected: _radius,
              onSelected: (value) => setState(() => _radius = value),
            ),
            const SizedBox(height: 12),
            _ChoiceStrip(
              values: const [
                'Todas',
                'Alimentação',
                'Infância',
                'Educação',
                'Apoio a Mulheres',
              ],
              selected: _cause,
              onSelected: (value) => setState(() => _cause = value),
            ),
            const SizedBox(height: 16),
            if (_showMap) ...[
              _MapPlaceholder(communities: communities.length),
              const SizedBox(height: 16),
            ],
            if (communities.isEmpty)
              const Padding(
                padding: EdgeInsets.all(28),
                child: Center(child: Text('Nenhuma comunidade encontrada.')),
              )
            else
              ...communities.map(
                (community) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _CommunityCard(
                    community: community,
                    onTap: () => context.pushNamed(
                      'communityDetails',
                      pathParameters: {'id': community.id},
                    ),
                  ),
                ),
              ),
            ReferenceCard(
              color: AppColors.lightSurfaceContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sua comunidade ainda não está aqui?',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Indique uma liderança local para receber apoio de voluntários e doadores.',
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () => _showMessage('Cadastro de comunidade em breve.'),
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Indicar ou cadastrar comunidade'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading('Distância máxima'),
              const SizedBox(height: 12),
              _ChoiceStrip(
                values: const ['Até 5 km', 'Até 15 km', 'Até 30 km', 'Todas'],
                selected: _radius,
                onSelected: (value) => setState(() => _radius = value),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aplicar filtros'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard({required this.community, required this.onTap});

  final _Community community;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ReferenceCard(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ReferencePhoto(
              imageUrl: community.imageUrl,
              height: 168,
              icon: Icons.groups,
              borderRadius: 12,
            ),
            Positioned(
              top: 10,
              left: 10,
              child: ReferencePill(
                label: '${community.distance}  •  ${community.neighborhood}',
                color: Colors.white.withValues(alpha: .92),
                icon: Icons.near_me,
              ),
            ),
            if (community.verified)
              const Positioned(
                bottom: 10,
                right: 10,
                child: ReferencePill(
                  label: 'Verificada',
                  color: AppColors.secondaryContainer,
                  foregroundColor: AppColors.secondary,
                  icon: Icons.verified,
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: community.causes
                    .map((cause) => ReferencePill(label: cause))
                    .toList(),
              ),
              const SizedBox(height: 8),
              Text(
                community.name,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(community.description),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _MiniMetric(icon: Icons.campaign, text: community.campaigns)),
                  Expanded(child: _MiniMetric(icon: Icons.groups, text: community.impact)),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Conhecer comunidade'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: AppColors.primary, size: 16),
      const SizedBox(width: 5),
      Flexible(child: Text(text, overflow: TextOverflow.ellipsis)),
    ],
  );
}

class _ChoiceStrip extends StatelessWidget {
  const _ChoiceStrip({
    required this.values,
    required this.selected,
    required this.onSelected,
  });

  final List<String> values;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 38,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: values.length,
      separatorBuilder: (_, _) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final value = values[index];
        return ChoiceChip(
          label: Text(value),
          selected: selected == value,
          onSelected: (_) => onSelected(value),
        );
      },
    ),
  );
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder({required this.communities});

  final int communities;

  @override
  Widget build(BuildContext context) => Container(
    height: 220,
    decoration: BoxDecoration(
      color: const Color(0xFFE3EDF3),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.map_outlined, size: 82, color: Color(0xFF91AAB7)),
        Positioned(
          top: 45,
          left: 54,
          child: Icon(Icons.location_on, color: AppColors.primary, size: 36),
        ),
        Positioned(
          right: 60,
          bottom: 42,
          child: Icon(Icons.location_on, color: AppColors.secondary, size: 36),
        ),
        Positioned(
          bottom: 12,
          child: ReferencePill(
            label: '$communities pontos próximos',
            color: Colors.white,
            icon: Icons.place,
          ),
        ),
      ],
    ),
  );
}

class _Community {
  const _Community({
    required this.id,
    required this.name,
    required this.neighborhood,
    required this.city,
    required this.distance,
    required this.distanceKm,
    required this.causes,
    required this.description,
    required this.impact,
    required this.campaigns,
    required this.verified,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String neighborhood;
  final String city;
  final String distance;
  final double distanceKm;
  final List<String> causes;
  final String description;
  final String impact;
  final String campaigns;
  final bool verified;
  final String? imageUrl;
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/state/app_providers.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/models/campaign.dart';
import '../../shared/models/donation_item.dart';
import '../../shared/widgets/app_shell.dart';
import '../../shared/widgets/campaign_card.dart';
import '../../shared/widgets/donation_item_card.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});
  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  String category = 'Todas';
  bool _showDonations = false;

  @override
  Widget build(BuildContext context) {
    final campaignsAsync = ref.watch(campaignsProvider);
    final donationsAsync = ref.watch(donationsProvider);
    return Scaffold(
      appBar: PageHeader(
        title: 'Explorar',
        onProfile: () => context.pushNamed('login'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar por nome ou local...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: false,
                label: Text('Campanhas'),
                icon: Icon(Icons.volunteer_activism),
              ),
              ButtonSegment(
                value: true,
                label: Text('Itens'),
                icon: Icon(Icons.inventory_2_outlined),
              ),
            ],
            selected: {_showDonations},
            onSelectionChanged: (selection) =>
                setState(() => _showDonations = selection.first),
          ),
          if (!_showDonations) ...[
            const SizedBox(height: 14),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, index) {
                  final label = [
                    'Todas',
                    'Alimentos',
                    'Educação',
                    'Saúde',
                  ][index];
                  return FilterChip(
                    label: Text(label),
                    selected: category == label,
                    onSelected: (_) => setState(() => category = label),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .14),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Causas perto de você',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text('5 campanhas ativas em sua região'),
                ],
              ),
            ),
            const SizedBox(height: 26),
            const Text(
              'Recomendadas para você',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            ...campaignsAsync.when(
              data: (campaigns) {
                final visible = category == 'Todas'
                    ? campaigns
                    : campaigns
                          .where((item) => item.category == category)
                          .toList();
                if (visible.isEmpty) {
                  return [
                    const Text('Nenhuma campanha encontrada nesta categoria.'),
                  ];
                }
                return visible
                    .map(
                      (campaign) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () => context.pushNamed(
                            'campaign',
                            pathParameters: {'id': campaign.id},
                          ),
                          child: CampaignCard(
                            campaign: campaign,
                            compact: true,
                          ),
                        ),
                      ),
                    )
                    .toList();
              },
              loading: () => [
                const Center(child: CircularProgressIndicator()),
              ],
              error: (_, _) => [
                TextButton.icon(
                  onPressed: () => ref.invalidate(campaignsProvider),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Não foi possível carregar. Tentar novamente'),
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 26),
            const Text(
              'Doações disponíveis',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            ...donationsAsync.when(
              data: (donations) => donations.isEmpty
                  ? [const Text('Nenhum item disponível no momento.')]
                  : donations
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: DonationItemCard(item: item),
                          ),
                        )
                        .toList(),
              loading: () => [
                const Center(child: CircularProgressIndicator()),
              ],
              error: (_, _) => [
                TextButton.icon(
                  onPressed: () => ref.invalidate(donationsProvider),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Não foi possível carregar. Tentar novamente'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

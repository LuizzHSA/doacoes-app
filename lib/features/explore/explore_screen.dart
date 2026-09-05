import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/models/campaign.dart';
import '../../shared/widgets/app_shell.dart';
import '../../shared/widgets/campaign_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String category = 'Todas';

  @override
  Widget build(BuildContext context) {
    final visible = category == 'Todas'
        ? campaigns
        : campaigns.where((item) => item.category == category).toList();
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
          ...visible.map(
            (campaign) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () => context.pushNamed(
                  'campaign',
                  pathParameters: {'id': campaign.id},
                ),
                child: CampaignCard(campaign: campaign, compact: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

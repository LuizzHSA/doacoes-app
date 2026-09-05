import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../models/campaign.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard({super.key, required this.campaign, this.compact = false});
  final Campaign campaign;
  final bool compact;
  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.zero,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: compact ? 1.55 : 16 / 9,
          child: Container(
            color: AppColors.primary.withValues(alpha: .14),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    campaign.category == 'Alimentos'
                        ? Icons.restaurant
                        : campaign.category == 'Saúde'
                        ? Icons.favorite
                        : Icons.school,
                    size: 58,
                    color: AppColors.primary.withValues(alpha: .7),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Chip(
                    label: Text(campaign.category),
                    backgroundColor: Colors.white.withValues(alpha: .9),
                    side: BorderSide.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                campaign.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (!compact) ...[
                const SizedBox(height: 6),
                Text(
                  campaign.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'R\$ ${campaign.raised.toStringAsFixed(0)} arrecadados',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${(campaign.progress * 100).round()}%',
                    style: const TextStyle(color: AppColors.lightTextSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: campaign.progress,
                  minHeight: 8,
                  backgroundColor: AppColors.primary.withValues(alpha: .14),
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

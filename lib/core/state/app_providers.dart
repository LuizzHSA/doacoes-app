import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/models/campaign.dart';
import '../../shared/models/donation_item.dart';
import '../data/donation_repository.dart';

final donationRepositoryProvider = Provider(
  (ref) => DonationRepository(),
);

final campaignsProvider = FutureProvider.autoDispose<List<Campaign>>(
  (ref) => ref.watch(donationRepositoryProvider).fetchCampaigns(),
);

final campaignProvider = FutureProvider.autoDispose.family<Campaign, String>(
  (ref, id) async {
    final campaigns = await ref.watch(campaignsProvider.future);
    return campaigns.firstWhere((campaign) => campaign.id == id);
  },
);

final donationsProvider = FutureProvider.autoDispose<List<DonationItem>>(
  (ref) => ref.watch(donationRepositoryProvider).fetchDonations(),
);

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void toggle(bool enabled) => state = enabled ? ThemeMode.dark : ThemeMode.light;
}

import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/campaign/campaign_details_screen.dart';
import '../../features/campaign/donation_confirmation_screen.dart';
import '../../features/explore/explore_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../shared/widgets/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (_, _) => const LoginScreen(),
    ),
    GoRoute(
      path: '/campaign/:id',
      name: 'campaign',
      builder: (_, state) => CampaignDetailsScreen(
        campaignId: state.pathParameters['id'] ?? 'kits-escolares',
      ),
      routes: [
        GoRoute(
          path: 'confirmacao',
          name: 'confirmation',
          builder: (_, _) => const DonationConfirmationScreen(),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (_, _) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              name: 'explore',
              builder: (_, _) => const ExploreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (_, _) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

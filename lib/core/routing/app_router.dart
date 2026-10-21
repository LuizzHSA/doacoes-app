import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/campaign/campaign_details_screen.dart';
import '../../features/campaign/donation_confirmation_screen.dart';
import '../../features/campaign/donation_checkout_screen.dart';
import '../../features/community/community_details_screen.dart';
import '../../features/community/community_list_screen.dart';
import '../../features/donation/donation_item_details_screen.dart';
import '../../features/donation/item_donation_form_screen.dart';
import '../../features/explore/explore_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/phone_verification_screen.dart';
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
      path: '/register',
      name: 'register',
      builder: (_, _) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/register/verify-phone',
      name: 'verifyPhone',
      builder: (_, _) => const PhoneVerificationScreen(),
    ),
    GoRoute(
      path: '/communities/:id',
      name: 'communityDetails',
      builder: (_, state) => CommunityDetailsScreen(
        communityId: state.pathParameters['id'] ?? 'morro-da-cruz',
      ),
    ),
    GoRoute(
      path: '/items/:id',
      name: 'itemDetails',
      builder: (_, state) => DonationItemDetailsScreen(
        itemId: state.pathParameters['id'] ?? 'carrinho-bebe',
      ),
    ),
    GoRoute(
      path: '/campaign/:id/checkout',
      name: 'checkout',
      builder: (_, state) => DonationCheckoutScreen(
        campaignId: state.pathParameters['id'] ?? 'cestas-emergenciais',
      ),
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
              path: '/communities',
              name: 'communities',
              builder: (_, _) => const CommunityListScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/donate',
              name: 'donate',
              builder: (_, _) => const ItemDonationFormScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/donations',
              name: 'donations',
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

import 'package:go_router/go_router.dart';

import '../../features/auth/pages/authenticate_page.dart';
import '../../features/auth/pages/google_callback_page.dart';
import '../../features/auth/pages/request_reset_password_page.dart';
import '../../features/auth/pages/reset_password_page.dart';
import '../../features/auth/pages/sign_in_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/campaigns/pages/campaigns_page.dart';
import '../../features/gifts/pages/gifts_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/incidents/pages/incidents_page.dart';
import '../../features/maps/pages/maps_page.dart';
import '../../features/organizations/pages/organizations_page.dart';
import '../../features/profile/pages/profile_account_page.dart';
import '../../shared/layouts/shells.dart';
import '../../shared/widgets/not_found_page.dart';
import '../constants/app_routes.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: AppRoutes.campaigns,
            builder: (context, state) => const CampaignsPage(),
          ),
          GoRoute(
            path: AppRoutes.campaignsCreate,
            builder: (context, state) => const CampaignCreatePage(),
          ),
          GoRoute(
            path: AppRoutes.campaignsMe,
            builder: (context, state) => const CampaignMePage(),
          ),
          GoRoute(
            path: '/campaigns/:id',
            builder: (context, state) => CampaignDetailPage(id: state.pathParameters['id']!),
          ),
          GoRoute(
            path: AppRoutes.incidents,
            builder: (context, state) => const IncidentsPage(),
          ),
          GoRoute(
            path: AppRoutes.incidentsCreate,
            builder: (context, state) => const IncidentCreatePage(),
          ),
          GoRoute(
            path: AppRoutes.incidentsMe,
            builder: (context, state) => const IncidentMePage(),
          ),
          GoRoute(
            path: '/incidents/:id',
            builder: (context, state) => IncidentDetailPage(id: state.pathParameters['id']!),
          ),
          GoRoute(
            path: AppRoutes.organizations,
            builder: (context, state) => const OrganizationsPage(),
          ),
          GoRoute(
            path: AppRoutes.organizationsCreate,
            builder: (context, state) => const OrganizationCreatePage(),
          ),
          GoRoute(
            path: AppRoutes.organizationsMe,
            builder: (context, state) => const OrganizationMePage(),
          ),
          GoRoute(
            path: '/organizations/:slug',
            builder: (context, state) =>
                OrganizationDetailPage(slug: state.pathParameters['slug']!),
          ),
          GoRoute(
            path: AppRoutes.gifts,
            builder: (context, state) => const GiftsPage(),
          ),
          ShellRoute(
            builder: (context, state, child) => ProfileShell(child: child),
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                redirect: (context, state) => AppRoutes.profileAccount,
              ),
              GoRoute(
                path: AppRoutes.profileAccount,
                builder: (context, state) => const ProfileAccountPage(),
              ),
              GoRoute(
                path: AppRoutes.profileNotifications,
                builder: (context, state) => const ProfileNotificationsPage(),
              ),
              GoRoute(
                path: AppRoutes.profilePoints,
                builder: (context, state) => const ProfilePointsPage(),
              ),
              GoRoute(
                path: AppRoutes.profileOrders,
                builder: (context, state) => const ProfileOrdersPage(),
              ),
            ],
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) => MapsShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.maps,
            builder: (context, state) => const MapsPage(),
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) => AuthShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.signIn,
            builder: (context, state) => const SignInPage(),
          ),
          GoRoute(
            path: AppRoutes.signUp,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: AppRoutes.authenticate,
            builder: (context, state) => const AuthenticatePage(),
          ),
          GoRoute(
            path: AppRoutes.resetPassword,
            builder: (context, state) => const ResetPasswordPage(),
          ),
          GoRoute(
            path: AppRoutes.requestResetPassword,
            builder: (context, state) => const RequestResetPasswordPage(),
          ),
          GoRoute(
            path: AppRoutes.googleCallback,
            builder: (context, state) => const GoogleCallbackPage(),
          ),
          GoRoute(
            path: AppRoutes.oauthGoogleCallback,
            builder: (context, state) => const GoogleCallbackPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}

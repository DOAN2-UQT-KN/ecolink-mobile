# EcoLink Mobile

## Overview

**EcoLink Mobile** is a Flutter UI port of the EcoLink user-facing web app (`ecolink-client`).

It recreates **project structure, navigation, theme, and screens** so developers can preview and continue building the mobile product. This repo is **UI-only**: no API calls, no real authentication, no business logic, and **no admin console**.

Source of truth for the web UI: `../ecolink-client` (Vite + React Router).

## Tech Stack

| Package | Role |
|---------|------|
| Flutter / Dart | UI framework |
| `go_router` | Declarative routing & nested shells |
| `google_fonts` | Be Vietnam Pro, Playfair Display, Instrument Serif |
| `flutter_map` + `latlong2` | Maps screen (OSM tiles, mock markers) |
| `flutter_svg` | SVG support (ready for future assets) |
| `intl` / `flutter_localizations` | Locale plumbing (en / vi) |
| Material Icons | Icons (Lucide package dropped — incompatible with current Flutter) |

## Project Structure

```text
ecolink-mobile/
├── assets/images/          # Migrated brand images from ecolink-client/public
├── lib/
│   ├── main.dart           # App entry
│   ├── core/
│   │   ├── constants/      # Asset paths, route path helpers
│   │   ├── routes/         # go_router configuration
│   │   ├── theme/          # Colors, typography, ThemeData
│   │   └── widgets/        # Design-system primitives
│   ├── features/
│   │   ├── auth/pages/
│   │   ├── campaigns/pages/
│   │   ├── gifts/pages/
│   │   ├── home/pages/
│   │   ├── incidents/pages/
│   │   ├── maps/pages/
│   │   ├── organizations/pages/
│   │   └── profile/pages/
│   ├── l10n/               # Lightweight en/vi string map
│   ├── mock/               # Static entities for UI preview
│   └── shared/
│       ├── layouts/        # Main / Auth / Profile / Maps shells
│       └── widgets/        # Header, footer, logo, 404
├── pubspec.yaml
├── CONVERSION_REPORT.md
└── README.md
```

## Folder & File Description

### `lib/main.dart`

| Path | Description |
|------|-------------|
| `main.dart` | Boots `EcoLinkApp`: locale state, `AppStrings`, `MaterialApp.router`, theme, `go_router`. |

### `core/`

| Path | Description |
|------|-------------|
| `core/theme/app_colors.dart` | Brand color tokens from web CSS (`#f5f4eb`, olive greens, brown accent, text greys). |
| `core/theme/app_typography.dart` | Text styles: logo (Instrument Serif), titles (Playfair), body (Be Vietnam Pro). |
| `core/theme/app_theme.dart` | `ThemeData` (Material 3): scaffold, inputs, cards, chips, radius ~10px. |
| `core/constants/app_assets.dart` | String constants for `assets/images/*`. |
| `core/constants/app_routes.dart` | Path constants and helpers (`campaignDetail(id)`, etc.). |
| `core/routes/app_router.dart` | Full `GoRouter` tree: MainShell, ProfileShell, AuthShell, MapsShell, error → NotFound. |
| `core/widgets/app_button.dart` | Brand buttons: green / brown / outlined / text, sizes large–small. |
| `core/widgets/app_text_field.dart` | Labeled `TextField` matching input chrome. |
| `core/widgets/app_widgets.dart` | Shared: `AppSelect`, `AppBadge`, `StatusTag`, `AppCard`, `AppEmpty`, `AppSkeleton`. |

### `shared/`

| Path | Description |
|------|-------------|
| `shared/layouts/shells.dart` | `MainShell` (header + bottom nav + AI FAB placeholder), `AuthShell` (split bg + lang switcher), `ProfileShell` (side/chips tabs), `MapsShell` (fullscreen). |
| `shared/widgets/app_header.dart` | Top app bar: logo, maps, notifications (TODO), user menu; also `AppFooter`, `AppBreadcrumbs`. |
| `shared/widgets/app_logo.dart` | Logo image + “EcoLink” wordmark. |
| `shared/widgets/not_found_page.dart` | 404 screen with back-to-home CTA. |

### `l10n/`

| Path | Description |
|------|-------------|
| `l10n/app_strings.dart` | `InheritedWidget` i18n: English keys as default, Vietnamese map for common UI labels. Language toggle lives in `AuthShell`. |

### `mock/`

| Path | Description |
|------|-------------|
| `mock/mock_data.dart` | Mock models (`MockUser`, `MockCampaign`, `MockIncident`, `MockOrganization`, `MockGift`, `MockTransaction`, `MockOrder`) + sample lists + lookup helpers. |

### `features/home/`

| Path | Description |
|------|-------------|
| `features/home/pages/home_page.dart` | Homepage: hero, problem/solution, for-volunteers, CTA, footer. |

### `features/auth/`

| Path | Description |
|------|-------------|
| `features/auth/pages/sign_in_page.dart` | Sign-in form UI (email/password + Google button → TODO). |
| `features/auth/pages/sign_up_page.dart` | Sign-up form UI. |
| `features/auth/pages/request_reset_password_page.dart` | Request reset-password UI. |
| `features/auth/pages/reset_password_page.dart` | Reset-password form UI. |
| `features/auth/pages/authenticate_page.dart` | Intermediate “loading/authenticate” placeholder. |
| `features/auth/pages/google_callback_page.dart` | OAuth callback placeholder (no token handling). |

### `features/campaigns/`

| Path | Description |
|------|-------------|
| `features/campaigns/pages/campaigns_page.dart` | **Primary file**: list + filters + tabs; also defines create / me / detail widgets. |
| `features/campaigns/pages/campaign_create_page.dart` | Re-export of `CampaignCreatePage`. |
| `features/campaigns/pages/campaign_me_page.dart` | Re-export of `CampaignMePage` (DataTable). |
| `features/campaigns/pages/campaign_detail_page.dart` | Re-export of `CampaignDetailPage` (overview / tasks / members tabs). |

### `features/incidents/`

| Path | Description |
|------|-------------|
| `features/incidents/pages/incidents_page.dart` | **Primary file**: list + filters; also create / me / detail. |
| `features/incidents/pages/incident_create_page.dart` | Re-export of `IncidentCreatePage`. |
| `features/incidents/pages/incident_me_page.dart` | Re-export of `IncidentMePage`. |
| `features/incidents/pages/incident_detail_page.dart` | Re-export of `IncidentDetailPage`. |

### `features/organizations/`

| Path | Description |
|------|-------------|
| `features/organizations/pages/organizations_page.dart` | **Primary file**: list + search; also create / me / detail tabs. |
| `features/organizations/pages/organization_create_page.dart` | Re-export of `OrganizationCreatePage`. |
| `features/organizations/pages/organization_me_page.dart` | Re-export of `OrganizationMePage`. |
| `features/organizations/pages/organization_detail_page.dart` | Re-export of `OrganizationDetailPage`. |

### `features/gifts/`

| Path | Description |
|------|-------------|
| `features/gifts/pages/gifts_page.dart` | Gift grid + redeem `AlertDialog` (redeem = TODO). |

### `features/profile/`

| Path | Description |
|------|-------------|
| `features/profile/pages/profile_account_page.dart` | **Primary file**: account + location form; also notifications / points / orders widgets. |
| `features/profile/pages/profile_notifications_page.dart` | Re-export of `ProfileNotificationsPage`. |
| `features/profile/pages/profile_points_page.dart` | Re-export of `ProfilePointsPage`. |
| `features/profile/pages/profile_orders_page.dart` | Re-export of `ProfileOrdersPage`. |

### `features/maps/`

| Path | Description |
|------|-------------|
| `features/maps/pages/maps_page.dart` | Fullscreen map, filter panel, SOS overlay; markers from mock incidents. |

### `assets/images/`

Brand assets copied from `ecolink-client/public/` (logo, auth background, heroes, feature illustrations, avatars, flags, etc.).

## Routes

| Path | Screen |
|------|--------|
| `/` | Home |
| `/campaigns` | Campaigns list |
| `/campaigns/create` | Create campaign |
| `/campaigns/me` | My campaigns |
| `/campaigns/:id` | Campaign detail |
| `/incidents` | Incidents list |
| `/incidents/create` | Create incident |
| `/incidents/me` | My incidents |
| `/incidents/:id` | Incident detail |
| `/organizations` | Organizations list |
| `/organizations/create` | Create organization |
| `/organizations/me` | My organizations |
| `/organizations/:slug` | Organization detail |
| `/gifts` | Gifts store |
| `/profile` | Redirect → `/profile/account` |
| `/profile/account` | Account |
| `/profile/notification-settings` | Notification toggles |
| `/profile/points` | Points + history |
| `/profile/orders` | Orders |
| `/maps` | Maps |
| `/sign-in`, `/sign-up` | Auth |
| `/authenticate` | Auth placeholder |
| `/reset-password`, `/request-reset-password` | Password reset UI |
| `/google-callback`, `/auth/oauth/google/callback` | OAuth placeholders |
| unknown | NotFound |

**Not included:** `/admin/*`.

## ReactJS → Flutter Mapping

| ReactJS | Flutter |
|---------|---------|
| `src/main.tsx` / `src/App.tsx` | `lib/main.dart` |
| `src/routes/index.tsx` | `lib/core/routes/app_router.dart` |
| `src/layouts/MainLayout.tsx` + `Header` / `Footer` | `lib/shared/layouts/shells.dart` (`MainShell`) + `shared/widgets/app_header.dart` |
| `src/layouts/AuthLayout.tsx` | `lib/shared/layouts/shells.dart` (`AuthShell`) |
| `src/layouts/ProfileLayout.tsx` + `ProfileTabs.tsx` | `lib/shared/layouts/shells.dart` (`ProfileShell`) |
| `src/layouts/MapsLayout.tsx` | `lib/shared/layouts/shells.dart` (`MapsShell`) |
| `src/pages/NotFound.tsx` | `lib/shared/widgets/not_found_page.dart` |
| `app/globals.css` + `_styles/*` | `lib/core/theme/*` |
| `components/client/shared/Button.tsx` | `lib/core/widgets/app_button.dart` |
| `components/ui/input.tsx` (pattern) | `lib/core/widgets/app_text_field.dart` |
| `components/ui/*` badges / empty / skeleton | `lib/core/widgets/app_widgets.dart` |
| `components/client/layout/Logo.tsx` | `lib/shared/widgets/app_logo.dart` |
| `i18n/locales/en\|vi/common.json` | `lib/l10n/app_strings.dart` (subset) |
| `app/(pages)/(main)/(hompage)/page.tsx` | `lib/features/home/pages/home_page.dart` |
| `app/(pages)/(auth)/sign-in/page.tsx` | `lib/features/auth/pages/sign_in_page.dart` |
| `app/(pages)/(auth)/sign-up/page.tsx` | `lib/features/auth/pages/sign_up_page.dart` |
| `app/(pages)/(auth)/request-reset-password/page.tsx` | `lib/features/auth/pages/request_reset_password_page.dart` |
| `app/(pages)/(auth)/reset-password/page.tsx` | `lib/features/auth/pages/reset_password_page.dart` |
| `app/(pages)/(auth)/authenticate/page.tsx` | `lib/features/auth/pages/authenticate_page.dart` |
| `app/(pages)/(auth)/google-callback/page.tsx` | `lib/features/auth/pages/google_callback_page.dart` |
| `app/(pages)/(main)/campaigns/(search)/page.tsx` | `lib/features/campaigns/pages/campaigns_page.dart` |
| `app/(pages)/(main)/campaigns/create/page.tsx` | `CampaignCreatePage` in `campaigns_page.dart` |
| `app/(pages)/(main)/campaigns/me/page.tsx` | `CampaignMePage` in `campaigns_page.dart` |
| `app/(pages)/(main)/campaigns/[id]/page.tsx` | `CampaignDetailPage` in `campaigns_page.dart` |
| `app/(pages)/(main)/incidents/(search)/page.tsx` | `lib/features/incidents/pages/incidents_page.dart` |
| `app/(pages)/(main)/incidents/create/page.tsx` | `IncidentCreatePage` in `incidents_page.dart` |
| `app/(pages)/(main)/incidents/me/page.tsx` | `IncidentMePage` in `incidents_page.dart` |
| `app/(pages)/(main)/incidents/[id]/page.tsx` | `IncidentDetailPage` in `incidents_page.dart` |
| `app/(pages)/(main)/organizations/(search)/page.tsx` | `lib/features/organizations/pages/organizations_page.dart` |
| `app/(pages)/(main)/organizations/create/page.tsx` | `OrganizationCreatePage` in `organizations_page.dart` |
| `app/(pages)/(main)/organizations/me/page.tsx` | `OrganizationMePage` in `organizations_page.dart` |
| `app/(pages)/(main)/organizations/[id]/page.tsx` | `OrganizationDetailPage` in `organizations_page.dart` |
| `app/(pages)/(main)/gifts/page.tsx` | `lib/features/gifts/pages/gifts_page.dart` |
| `app/(pages)/(main)/profile/account/page.tsx` | `lib/features/profile/pages/profile_account_page.dart` |
| `app/(pages)/(main)/profile/notification-settings/page.tsx` | `ProfileNotificationsPage` in `profile_account_page.dart` |
| `app/(pages)/(main)/profile/points/page.tsx` | `ProfilePointsPage` in `profile_account_page.dart` |
| `app/(pages)/(main)/profile/orders/page.tsx` | `ProfileOrdersPage` in `profile_account_page.dart` |
| `app/(pages)/(maps)/maps/page.tsx` | `lib/features/maps/pages/maps_page.dart` |
| `public/*` brand images | `assets/images/*` |

## Mock / TODO

### Mocked (static UI data)

- Current user, campaigns, incidents, organizations, gifts
- Point transactions and gift orders
- Map pin positions derived from mock incidents
- Lists/tables/detail views render from `lib/mock/mock_data.dart` only

### Not implemented (marked `TODO` in source)

| Area | Notes |
|------|--------|
| Sign-in / sign-up / reset password | No auth API or token storage |
| Google OAuth | Callback page is UI placeholder only |
| Campaign / incident / organization create & join | Forms submit → navigate or snackbar only |
| Gift redeem | Dialog only |
| Profile save / notification settings | Local UI toggles only |
| Map filters / SOS submit | No geocoding or backend |
| AI chat FAB | Snackbar placeholder |
| Notifications menu in header | Empty handler |
| Admin console | Out of scope by design |
| HTTP / repositories / DB / WebSocket / push | Not present |

Also see [`CONVERSION_REPORT.md`](CONVERSION_REPORT.md) for the conversion checklist.

## How to Run

**Requirements:** Flutter SDK (project tested with Flutter 3.47 / Dart 3.13).

```bash
cd ecolink-mobile
flutter pub get
flutter analyze
flutter test
flutter run
```

Pick a device/simulator when prompted (`flutter devices`).

### Notes

- First run may download Google Fonts over the network.
- Map tiles load from OpenStreetMap (`flutter_map`); network required for the maps screen.
- Git remote (optional): `https://github.com/DOAN2-UQT-KN/ecolink-mobile.git`

## Scope reminder

**In:** user app UI (main, auth, profile, maps).  
**Out:** admin, real backend integration, production auth, complex state management.

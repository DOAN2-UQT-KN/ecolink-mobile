# EcoLink Mobile — Conversion Report

UI-only Flutter port of `ecolink-client` (user app). Generated from React → Flutter plan (no admin).

## Screens converted

### Main
- `/` — Home (hero, problem/solution, volunteers, CTA)
- `/campaigns` — list + filters + tabs
- `/campaigns/create` — create form layout
- `/campaigns/me` — my campaigns table
- `/campaigns/:id` — detail + overview/tasks/members tabs
- `/incidents` — list + filters
- `/incidents/create` — report form layout
- `/incidents/me` — my incidents table
- `/incidents/:id` — detail
- `/organizations` — list + search
- `/organizations/create` — create form layout
- `/organizations/me` — my orgs list
- `/organizations/:slug` — detail + campaigns/members tabs
- `/gifts` — gift grid + redeem dialog
- `/profile/account` — general + location form
- `/profile/notification-settings` — toggles
- `/profile/points` — balance + transaction history
- `/profile/orders` — orders list
- `*` — NotFound

### Maps
- `/maps` — flutter_map + filters + SOS dialog

### Auth
- `/sign-in`, `/sign-up`
- `/authenticate`
- `/reset-password`, `/request-reset-password`
- `/google-callback`, `/auth/oauth/google/callback`

### Out of scope
- All `/admin/*` screens (per scope choice)

## Shared / core components

- Theme: `AppColors`, `AppTypography`, `AppTheme`
- Widgets: `AppButton`, `AppTextField`, `AppSelect`, `AppBadge`, `StatusTag`, `AppCard`, `AppEmpty`, `AppSkeleton`
- Shells: `MainShell`, `AuthShell`, `ProfileShell`, `MapsShell`
- Layout chrome: `AppHeader`, `AppFooter`, `AppLogo`, `AppBreadcrumbs`
- Routing: `go_router` via `createAppRouter()`
- i18n light: `AppStrings` (en keys + vi map)

## Assets migrated

From `ecolink-client/public/` → `assets/images/`:

- logo.png, auth-bg.jpeg, herosection.png
- take-action-desktop.png, take-action-mobile.png
- report-trash.png, track-progress.png, support-movement.png
- collect-trash.jpg, map.jpg, banner-default.jpg
- default-avatar.png, profile.png, google.png
- england.webp, vietnam.webp, trash-detector.webp

Fonts via `google_fonts`: Be Vietnam Pro, Playfair Display, Instrument Serif.

## Mocked

- User, campaigns, incidents, organizations, gifts, point transactions, orders
- Map markers derived from mock incidents
- Auth/OAuth/submit/upload/join/redeem/SOS → UI only

## TODO (not implemented)

- API / HTTP / repositories
- Real authentication & OAuth
- Real form validation & submit
- File upload
- Map geocoding / SOS backend
- AI chat widget
- Notification menu data
- Rich text editor
- Push / WebSocket
- Admin console

## Verify

```bash
cd ecolink-mobile
flutter pub get
flutter analyze   # No issues
flutter test      # Passes
flutter run
```

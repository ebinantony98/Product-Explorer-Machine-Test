# Product Explorer

A Flutter product browsing application built for a developer machine test. It uses the DummyJSON Products API, Provider, ChangeNotifier, MVC separation and Hive-based offline caching.

## Features

- Product catalogue fetched from `https://dummyjson.com/products`
- Product cards with image, title, category, discounted price and rating
- Search by product title, brand or category
- Category filtering
- Product detail page with image gallery and product metadata
- Loading, empty and error states with retry
- Pull-to-refresh
- Hive cache: previously fetched catalogue is shown when the network is unavailable
- Unit tests for model parsing, API service and controller

## Requirements

- **Flutter SDK: 3.44.8 (stable)**
- Dart SDK bundled with Flutter 3.44.8
- Android Studio / Xcode or another Flutter-supported development environment

Verify your installed Flutter version before setup:

```bash
flutter --version
```

If necessary, switch to Flutter 3.44.8 using your Flutter version manager, or install that stable SDK version before continuing.

## Setup

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd product_explorer
flutter pub get
flutter run
```

## Run tests and static analysis

```bash
flutter test
flutter analyze
```

Tests use a mocked HTTP client and fake cache/repository implementations. They do not depend on live DummyJSON availability.

## Architecture

```text
View (Screens and reusable Widgets)
          |
       Provider
          |
ProductController (ChangeNotifier)
          |
   Service interfaces
       /       \
HTTP API     Hive cache
          |
      Product Model
```

- `models/`: typed product model and JSON serialization.
- `views/`: listing/detail screens and reusable UI widgets.
- `controllers/`: presentation state, search, filtering, loading and offline fallback.
- `services/`: remote API and local cache implementations.
- `utils/`: theme and shared styling.

The controller receives repository and cache abstractions through its constructor. This makes the controller independently testable without a live API.

## Offline behaviour

On initial load, the controller checks Hive for a saved catalogue and displays it immediately when available. It then attempts to refresh from the API. A successful response replaces the local catalogue and updates the cache. If the network request fails, cached products remain available and an offline notice is shown.

The cache stores the API response as JSON in a Hive string box. This avoids generated Hive adapters and keeps the model easy to test.

## API

- `GET https://dummyjson.com/products`

The product listing response includes the data needed by the listing and detail views. The app does not hardcode catalogue entries.

## Screenshots

Add real screenshots after running the app:

```text
screenshots/
  product-list.png
  product-details.png
```

You can create the folder and add screenshots from an emulator or physical device before submitting.

## GitHub submission checklist

1. Run `flutter pub get`, `flutter analyze` and `flutter test`.
2. Run the app on an emulator or device and verify listing, details, refresh and offline fallback.
3. Capture listing and detail screenshots and save them under `screenshots/`.
4. Replace the clone URL above with your repository URL if desired.
5. Commit source, tests, README and screenshots.
6. Do not commit `build/`, `.dart_tool/`, IDE-local files or secrets.

Suggested `.gitignore` entries are included below. Flutter's generated `.gitignore` should also be retained.

## Notes

- The bottom action on the detail page is intentionally a non-commerce preview label; this assignment does not require cart or checkout functionality.
- Cached data is a fallback, not a guarantee that a first-ever launch works offline.

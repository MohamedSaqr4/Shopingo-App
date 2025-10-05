# Shopingo

A production-ready Flutter e-commerce application scaffold. This README covers project overview, setup, running on all platforms, structure, and common workflows.

## Features
- Product listing, details, and search
- Cart and checkout flow (scaffolded)
- Theming and responsive UI
- Feature-first architecture under `lib/features/*`
- Ready for Android, iOS, Web, Windows, macOS, and Linux

## Tech Stack
- Flutter (Dart)
- State management: Provider/Bloc/Cubit (per project implementation)
- Networking: `http` or Dio
- Routing: `go_router` or `Navigator 2.0`

## Prerequisites
- Flutter SDK installed (`flutter --version`)
- Android Studio/Xcode for mobile targets
- Chrome for Web, appropriate toolchain for desktop
- Device/emulator/simulator set up (`flutter devices`)

## Getting Started
```bash
# 1) Fetch dependencies
flutter pub get

# 2) Verify environment
flutter doctor

# 3) Run on your chosen platform
flutter run -d chrome          # Web
flutter run -d windows         # Windows
flutter run -d macos           # macOS
flutter run -d linux           # Linux
flutter run -d android         # Android (emulator/device)
flutter run -d ios             # iOS (simulator/device on macOS)
```

## Build Commands
```bash
# Web (release)
flutter build web --release

# Android (appbundle/apk)
flutter build appbundle --release
flutter build apk --release

# iOS (requires macOS)
flutter build ipa --release

# Desktop
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## Project Structure
```text
lib/
  core/                     # shared utilities, theme, widgets, services
  features/
    home/
      data/
      domain/
      presentation/
        view/
        widgets/
        cubit/ or bloc/
  main.dart
```
- Follow the feature-first pattern: keep `data`, `domain`, and `presentation` within each feature.
- Put cross-cutting concerns in `lib/core`.

## Configuration
- Environment/flavors (optional):
  - Use `--dart-define` for runtime values, e.g. `flutter run --dart-define=API_BASE_URL=https://api.example.com`.
  - Consider flavoring via separate `main_*.dart` entries and scheme/product flavors.

## Code Style
- Prefer clean, descriptive names and small widgets
- Keep widgets pure; lift state when needed
- Keep networking and persistence outside of presentation

## Testing
```bash
# Unit and widget tests
flutter test

# Integration tests
flutter test integration_test
```

## Troubleshooting
- If dependencies fail: `flutter clean && flutter pub get`
- No devices listed: set up an emulator/simulator or connect a device
- iOS signing issues: open `ios/Runner.xcworkspace` and configure signing

## Contributing
- Create a branch, open a PR
- Keep commits small and focused
- Add/adjust tests when changing behavior

## License
This project is provided as-is; add a license (e.g., MIT) if needed.

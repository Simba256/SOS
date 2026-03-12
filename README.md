# SOS Emergency App

A Flutter-based emergency SOS application that allows users to quickly send emergency alerts with location information to pre-configured emergency contacts.

## Features

- **One-Tap SOS Alert**: Send emergency SMS to all configured contacts with a single tap
- **Location Sharing**: Automatically includes GPS coordinates in emergency messages
- **Emergency Contacts Management**: Import contacts from phone or add manually
- **Multi-User Support**: Each user's data is isolated (contacts, profile)
- **Cross-Device Profile Sync**: Name and profile image sync via Firebase
- **Visual & Audio Alerts**: Flashlight and audio alarm during emergencies
- **Offline Capable**: Emergency contacts stored locally for offline access

## Tech Stack

- **Framework**: Flutter (FlutterFlow generated)
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Local Database**: SQLite (for emergency contacts)
- **SMS**: Native SMS integration

## Architecture

### Data Storage

| Data | Storage | Syncs Across Devices |
|------|---------|---------------------|
| User Profile (Name) | Firestore | Yes |
| Profile Image | Firebase Storage | Yes |
| Emergency Contacts | Local SQLite | No (per-device) |
| App Settings | SharedPreferences | No (per-device) |

### Multi-User Isolation

The app supports multiple users on the same device:
- Emergency contacts are filtered by `user_id` in SQLite
- Each user sees only their own contacts
- Logout clears in-memory user data

## Getting Started

### Prerequisites

- Flutter SDK (stable channel)
- Firebase project configured
- Android Studio / Xcode

### Installation

```bash
# Clone the repository
git clone <repo-url>
cd SOS

# Install dependencies
flutter pub get

# Run on connected device
flutter run
```

### Build for Production

```bash
# Build release APK
flutter build apk --release

# Build App Bundle for Play Store
flutter build appbundle --release
```

## Project Structure

```
lib/
├── auth/                    # Firebase authentication
├── backend/
│   ├── firebase_storage/    # Image upload utilities
│   ├── schema/              # Firestore data models
│   └── sqlite/              # Local database (contacts)
├── custom_code/
│   ├── actions/             # Custom business logic
│   └── widgets/             # Custom UI components
├── final/                   # Main app screens
│   ├── home_v2/             # Home screen with SOS button
│   ├── contacts_v2/         # Emergency contacts list
│   ├── profile_v2/          # User profile
│   └── sign_in_v2/          # Authentication
├── app_state.dart           # Global app state
└── main.dart                # App entry point
```

## Security

- SQL injection prevention via parameterized queries
- User data isolation between accounts
- Debug logging disabled in production builds
- Firebase security rules for data access

See [CHANGELOG_SECURITY_FIXES.md](CHANGELOG_SECURITY_FIXES.md) for detailed security improvements.

## Documentation

- [Security & Bug Fix Changelog](CHANGELOG_SECURITY_FIXES.md)
- [Production Checklist](PRODUCTION_CHECKLIST.md)
- [Quick Start Guide](QUICK_START_PRODUCTION.md)
- [Firebase Rules](firebase-rules/README.md)
- [Privacy Policy](privacy-policy/README.md)

## Version History

- **1.0.2** - Multi-user data isolation, cross-device profile sync
- **1.0.1** - Security fixes, bug fixes, performance improvements
- **1.0.0** - Initial release

## License

Proprietary - Chameleon Ideas

## Support

For issues and feature requests, contact the development team.

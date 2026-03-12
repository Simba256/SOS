# SOS App - Security & Bug Fix Changelog

**Date:** 2026-03-12
**Version:** 1.0.3
**Branch:** flutterflow

---

## Overview

This document details all security fixes, bug fixes, and improvements made to the SOS Emergency App codebase. The changes address critical SQL injection vulnerabilities, null safety issues, error handling gaps, performance optimizations, **multi-user data isolation**, and **cross-device profile synchronization**.

**Total files modified:** 18
**Build status:** Successful (Debug APK)

---

## Phase 0: Multi-User Data Isolation & Cross-Device Sync

### Problem Statement

When User A logged out and User B logged in on the same device, User B could see User A's:
- Emergency contacts (stored in SQLite)
- Profile name (stored in SharedPreferences)
- Profile image (stored in SharedPreferences as Base64)

Additionally, user profile data (name and image) did not sync across devices.

### Solution Overview

1. **SQLite Contacts Isolation**: Added `user_id` column to filter contacts by logged-in user
2. **Profile Data in Firebase**: Moved name and image storage to Firestore/Firebase Storage for cross-device sync

---

### 0.1 Database Migration for User Isolation

#### File: `lib/backend/sqlite/init.dart`

Added database migration to support multi-user data isolation:

```dart
final database = await openDatabase(
  databasePath,
  version: 2,  // Incremented from 1
  onUpgrade: (db, oldVersion, newVersion) async {
    if (oldVersion < 2) {
      // Delete existing contacts (clean slate for user isolation)
      await db.execute('DELETE FROM contacts');
      // Add user_id column for multi-user data isolation
      await db.execute(
          'ALTER TABLE contacts ADD COLUMN user_id TEXT NOT NULL DEFAULT ""');
    }
  },
);
```

**Note:** Migration clears existing contacts. Users must re-import emergency contacts after update.

---

### 0.2 User ID Filtering in SQL Queries

#### File: `lib/backend/sqlite/queries/update.dart`

All INSERT and DELETE operations now include `user_id`:

| Function | Change |
|----------|--------|
| `performAddContactNewFormat` | Added `required String userId` parameter, includes `user_id` in INSERT |
| `performDeleteContact` | Added `required String userId` parameter, filters by `user_id` in DELETE |
| `performAddContactWithoutPhoto` | Added `required String userId` parameter |
| `performAddContactOldFormat` | Added `required String userId` parameter |
| `performDeleteContactWithName` | Added `required String userId` parameter, filters by `user_id` |

#### File: `lib/backend/sqlite/queries/read.dart`

All SELECT queries now filter by `user_id`:

| Function | Change |
|----------|--------|
| `performReadContacts` | Added `required String userId`, query: `WHERE user_id = ?` |
| `performReadPhoneNumbers` | Added `required String userId`, query: `WHERE user_id = ?` |
| `performSearchContacts` | Added `required String userId`, combined with search filters |

#### File: `lib/backend/sqlite/sqlite_manager.dart`

SQLiteManager now automatically passes `currentUserUid` to all query methods:

```dart
import '/auth/firebase_auth/auth_util.dart';

Future<List<ReadContactsRow>> readContacts() => performReadContacts(
  _database,
  userId: currentUserUid,  // Automatic user filtering
);
```

---

### 0.3 Profile Image Sync via Firebase Storage

#### New File: `lib/custom_code/actions/upload_profile_image.dart`

Created new action to upload profile images to Firebase Storage:

```dart
Future<String?> uploadProfileImage(FFUploadedFile? imageFile) async {
  // Validates user is logged in
  final userId = currentUserUid;
  if (userId.isEmpty) return null;

  // Upload to Firebase Storage at users/{userId}/profile.{ext}
  final storagePath = 'users/$userId/profile.$extension';
  final downloadUrl = await uploadData(storagePath, imageFile.bytes!);

  // Update Firestore user document with photo URL
  await currentUserReference?.update(createUsersRecordData(
    photoUrl: downloadUrl,
  ));

  return downloadUrl;
}
```

#### File: `lib/custom_code/actions/index.dart`

Added export for new action:
```dart
export 'upload_profile_image.dart' show uploadProfileImage;
```

---

### 0.4 App State Changes for Cross-Device Sync

#### File: `lib/app_state.dart`

**Changes:**

1. **Name stored in Firestore** (was SharedPreferences):
```dart
set Name(String value) {
  _Name = value;
  // Save to Firestore
  if (currentUserUid.isNotEmpty && currentUserReference != null) {
    currentUserReference!.update(createUsersRecordData(displayName: value));
  }
}
```

2. **UserImage stored in Firestore** (was SharedPreferences as Base64):
```dart
set UserImage(String value) {
  _UserImage = value;
  // Note: UserImage is persisted in Firestore (users/{uid}.photo_url),
  // not in SharedPreferences. The upload_profile_image action handles Firestore update.
}
```

3. **Load user data from Firestore on login**:
```dart
void loadUserData() {
  if (currentUserUid.isNotEmpty) {
    _Name = currentUserDocument?.displayName ?? '';
    _UserImage = currentUserDocument?.photoUrl ?? '';
    notifyListeners();
  }
}
```

4. **Reload user data when Firestore document updates**:
```dart
void reloadUserData() {
  final displayName = currentUserDocument?.displayName ?? '';
  final photoUrl = currentUserDocument?.photoUrl ?? '';
  // Update local state if changed
  if (displayName != _Name || photoUrl != _UserImage) {
    _Name = displayName;
    _UserImage = photoUrl;
    notifyListeners();
  }
}
```

5. **Clear user data on logout**:
```dart
void clearUserData() {
  _Name = '';
  _UserImage = '';
  _contacts = [];
  _FinalContacts = [];
  notifyListeners();
}
```

---

### 0.5 Auth State Handling

#### File: `lib/main.dart`

Updated auth listeners to manage user data lifecycle:

```dart
userStream = sosAppFirebaseUserStream()
  ..listen((user) {
    _appStateNotifier.update(user);
    // Load user-specific data when user logs in
    if (user.loggedIn) {
      FFAppState().loadUserData();
    } else {
      // Clear in-memory user data on logout
      FFAppState().clearUserData();
    }
  });

final authUserSub = authenticatedUserStream.listen((_) {
  // Reload user data (name and image) from Firestore when user document updates
  FFAppState().reloadUserData();
});
```

---

### 0.6 UI Updates for Image URL

#### Files Modified:
- `lib/final/profile_v2/profile_v2_widget.dart`
- `lib/final/sign_up_v2/sign_up_v2_widget.dart`
- `lib/final/home_v2/home_v2_widget.dart`

**Changes:**

1. **Profile page** - Uses `uploadProfileImage` instead of `convertImageToBase64`:
```dart
_model.recentlyUploadedImage = await actions.uploadProfileImage(
  _model.uploadedLocalFile_uploadData06v,
);
```

2. **ContactAvatarWidget** - Now uses `imageUrl` parameter instead of `imageBase64`:
```dart
ContactAvatarWidget(
  contactName: FFAppState().Name,
  imageUrl: FFAppState().UserImage,  // Changed from imageBase64
)
```

3. **Sign-up page** - Uploads image after account creation:
```dart
if (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false) {
  final photoUrl = await actions.uploadProfileImage(_model.uploadedLocalFile);
  if (photoUrl != null) {
    FFAppState().UserImage = photoUrl;
  }
}
```

---

### 0.7 Data Storage Summary

| Data | Storage Location | Syncs Across Devices |
|------|------------------|---------------------|
| **User Name** | Firestore `users/{uid}.display_name` | ✅ Yes |
| **Profile Image** | Firebase Storage `users/{uid}/profile.jpg` + Firestore URL | ✅ Yes |
| **Emergency Contacts** | Local SQLite (filtered by `user_id`) | ❌ No (per-device) |

---

### 0.8 Migration Notes

**For existing users:**
- Emergency contacts are cleared during migration (need to re-import)
- Profile name needs to be re-entered once (to save to Firestore)
- Profile image needs to be re-uploaded once (to save to Firebase Storage)

**For new users:**
- All data automatically uses the new isolated/synced storage

---

## UI Bug Fixes

### Keyboard Overflow in Profile Page

**File:** `lib/final/profile_v2/profile_v2_widget.dart`

**Problem:** When tapping the Full Name field, the keyboard opened and caused a "bottom overflowed by 92 pixels" error (yellow/black striped warning).

**Solution:** Wrapped the page content in `SingleChildScrollView` with `LayoutBuilder` and `IntrinsicHeight` to allow scrolling when the keyboard appears:

```dart
body: SafeArea(
  child: LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ... content
          ),
        ),
      ),
    ),
  ),
),
```

### Create Contact Image Error

**File:** `lib/components/modal05_create_project_widget.dart`

**Problem:** The "Add Photo" section showed a red error icon with "Invalid argument(s). No host specified in URI".

**Cause:** A `CachedNetworkImage` widget was configured with an empty URL (`imageUrl: ''`), which caused the URI parsing error.

**Solution:** Removed the unnecessary `CachedNetworkImage` widget from the Stack. The photo placeholder icon and text are sufficient for the empty state.

---

## Phase 1: Critical Security Fixes

### 1.1 SQL Injection Vulnerabilities Fixed

All database queries were using string interpolation which is vulnerable to SQL injection attacks. These have been converted to parameterized queries.

#### File: `lib/backend/sqlite/queries/update.dart`

| Function | Before | After |
|----------|--------|-------|
| `performAddContactNewFormat` | String interpolation with `:name` syntax | Parameterized query with `?` placeholders |
| `performDeleteContact` | `DELETE FROM contacts WHERE phone = '${phoneNumber}'` | `database.rawDelete('DELETE FROM contacts WHERE phone = ?', [phoneNumber])` |
| `performAddContactWithoutPhoto` | `INSERT INTO contacts (name, phone) VALUES ('${name}', '${phone}')` | `database.rawInsert('INSERT INTO contacts (name, phone) VALUES (?, ?)', [name, phone])` |
| `performAddContactOldFormat` | String interpolation | Parameterized query |
| `performDeleteContactWithName` | `DELETE FROM contacts WHERE name = '${name}'` | `database.rawDelete('DELETE FROM contacts WHERE name = ?', [name])` |

#### File: `lib/backend/sqlite/queries/read.dart`

| Function | Change |
|----------|--------|
| `performSearchContacts` | Changed from `LOWER('${searchTerm}')` to parameterized `LOWER(?)` with `[searchTerm, searchTerm]` arguments |
| `_readQuery` helper | Added optional `List<Object?>? arguments` parameter to support parameterized queries |

---

## Phase 2: Critical Bug Fixes

### 2.1 Emergency SOS Error Handling

#### File: `lib/final/home_v2/home_v2_widget.dart`

**Issues Fixed:**
1. Double `.toList().toList()` call (redundant and potentially confusing)
2. No error handling for location or SMS failures
3. No validation for empty contacts list
4. No indication when location is unavailable

**Changes Made:**
```dart
// Added try/catch wrapper
try {
  currentUserLocationValue = await getCurrentUserLocation(...);

  // Added location validation
  final isValidLocation = currentUserLocationValue != null &&
      !(currentUserLocationValue!.latitude == 0.0 &&
        currentUserLocationValue!.longitude == 0.0);

  _model.allContacts = await SQLiteManager.instance.readContacts();

  // Added empty contacts check
  if (_model.allContacts == null || _model.allContacts!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No emergency contacts found'), backgroundColor: Colors.orange),
    );
    return;
  }

  await actions.emergencyBulkSms(
    _model.allContacts?.map((e) => e.phone).toList(),  // Fixed: removed double toList()
    currentUserLocationValue,
    _model.selectedIndex,
  );

  // Improved success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Emergency alert sent to ${_model.allContacts?.length ?? 0} contacts${!isValidLocation ? " (location unavailable)" : ""}'),
      backgroundColor: Color(0xFF4CAF50),
    ),
  );
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Failed to send emergency alert'), backgroundColor: Colors.red),
  );
}
```

### 2.2 Null Safety Issues

#### File: `lib/final/contacts_v2/contacts_v2_widget.dart`

**Issue:** Force unwrap on `fetchedPhoneContacts!` could crash if null

**Fix:**
```dart
// Before
FFAppState().FinalContacts = _model.fetchedPhoneContacts!.toList().cast<FinalContactStruct>();

// After
if (_model.fetchedPhoneContacts != null) {
  FFAppState().FinalContacts = _model.fetchedPhoneContacts!.toList().cast<FinalContactStruct>();
}
```

Also added try/catch with user-friendly error message for contacts permission failure.

#### File: `lib/final/profile_v2/profile_v2_widget.dart`

**Issue:** Force unwrap on `recentlyUploadedImage!` could crash if null

**Fix:**
```dart
// Before
FFAppState().UserImage = _model.recentlyUploadedImage!;

// After
FFAppState().UserImage = _model.recentlyUploadedImage ?? '';
```

---

## Phase 3: High Priority Fixes

### 3.1 Contact Delete Error Handling

#### File: `lib/final/contacts_v2/contacts_v2_widget.dart`

**Issue:** No error handling when deleting contacts

**Fix:** Added try/catch with error SnackBar:
```dart
onPressed: () async {
  try {
    await SQLiteManager.instance.deleteContactWithName(name: listViewReadContactsRow.name);
    safeSetState(() {});
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete contact'), backgroundColor: Colors.red),
    );
  }
},
```

### 3.2 ListView Widget Identity

#### File: `lib/final/contacts_v2/contacts_v2_widget.dart`

**Issue:** ListView items lacked unique keys, causing potential rendering issues during updates

**Fix:** Added `ValueKey` to list items:
```dart
return Padding(
  key: ValueKey(listViewReadContactsRow.phone),
  padding: EdgeInsetsDirectional.fromSTEB(17.5, 10.0, 17.5, 10.0),
  // ...
);
```

### 3.3 Audio Player Mounted Check

#### File: `lib/custom_code/widgets/audio_toggle_button.dart`

**Issue:** setState called after async operations without checking if widget is still mounted

**Fix:** Added mounted checks before setState:
```dart
if (!mounted) return;
setState(() {
  _isInitialized = true;
  _errorMessage = null;
});
```

---

## Phase 4: Performance Fixes

### 4.1 ContactAvatarWidget Optimization

#### File: `lib/custom_code/widgets/contact_avatar_widget.dart`

**Issue:** Base64 image decoding happening on every build, causing performance issues

**Fix:** Converted from `StatelessWidget` to `StatefulWidget` with image caching:

```dart
class ContactAvatarWidget extends StatefulWidget {
  // ... widget properties
}

class _ContactAvatarWidgetState extends State<ContactAvatarWidget> {
  Uint8List? _cachedImageBytes;
  String? _lastImageBase64;

  @override
  void initState() {
    super.initState();
    _updateImageCache();
  }

  @override
  void didUpdateWidget(ContactAvatarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageBase64 != widget.imageBase64) {
      _updateImageCache();
    }
  }

  void _updateImageCache() {
    if (widget.imageBase64 != _lastImageBase64) {
      _lastImageBase64 = widget.imageBase64;
      if (widget.imageBase64 != null && widget.imageBase64!.isNotEmpty) {
        try {
          final cleaned = widget.imageBase64!.replaceAll(RegExp(r'\s+'), '');
          _cachedImageBytes = base64Decode(cleaned);
        } catch (e) {
          _cachedImageBytes = null;
        }
      } else {
        _cachedImageBytes = null;
      }
    }
  }
  // ...
}
```

**Also removed:** Debug print statements (`print('Decoded bytes length: ...')`)

### 4.2 Redundant Code Removal

#### File: `lib/final/contacts_v2/contacts_v2_widget.dart`

**Issue:** Two consecutive `safeSetState(() {})` calls

**Fix:** Removed redundant second call

#### File: `lib/final/load_contacts_v2/load_contacts_v2_widget.dart`

**Issue:** Empty/meaningless `unawaited(() async {}())` calls

**Fix:** Removed both occurrences and unused `dart:async` import

---

## Phase 5: Debug-Only Logging

### Files Modified:
- `lib/backend/backend.dart`
- `lib/backend/cloud_functions/cloud_functions.dart`
- `lib/custom_code/actions/read_contacts.dart`

**Change:** Wrapped all `print()` statements in `if (kDebugMode)` to prevent logging in production builds.

```dart
// Before
print('Error reading contacts: ${e.toString()}');

// After
import 'package:flutter/foundation.dart';
if (kDebugMode) {
  print('Error reading contacts: ${e.toString()}');
}
```

---

## Additional Fix

### Android Manifest Configuration

#### File: `android/app/src/debug/AndroidManifest.xml`

**Issue:** Outdated `package` attribute conflicting with namespace in build.gradle

**Fix:** Removed `package="com.mycompany.sosapp"` attribute from manifest

---

## Files Changed Summary

| File | Priority | Changes |
|------|----------|---------|
| `lib/backend/sqlite/init.dart` | CRITICAL | Database migration for user_id column |
| `lib/backend/sqlite/queries/update.dart` | CRITICAL | 5 SQL injection fixes + user_id filtering |
| `lib/backend/sqlite/queries/read.dart` | CRITICAL | 1 SQL injection fix + user_id filtering |
| `lib/backend/sqlite/sqlite_manager.dart` | CRITICAL | Pass currentUserUid to all queries |
| `lib/app_state.dart` | CRITICAL | User data isolation, Firestore sync for name/image |
| `lib/main.dart` | CRITICAL | Auth state handling for user data lifecycle |
| `lib/custom_code/actions/upload_profile_image.dart` | HIGH | **NEW** - Firebase Storage upload for profile images |
| `lib/custom_code/actions/index.dart` | HIGH | Export uploadProfileImage action |
| `lib/final/home_v2/home_v2_widget.dart` | CRITICAL | SOS error handling, double toList fix, imageUrl |
| `lib/final/contacts_v2/contacts_v2_widget.dart` | HIGH | Null safety, ListView keys, delete error handling |
| `lib/final/profile_v2/profile_v2_widget.dart` | HIGH | Null safety fix, uploadProfileImage, imageUrl |
| `lib/final/sign_up_v2/sign_up_v2_widget.dart` | HIGH | Upload profile image after account creation |
| `lib/custom_code/widgets/contact_avatar_widget.dart` | HIGH | StatefulWidget conversion, Base64 caching |
| `lib/custom_code/widgets/audio_toggle_button.dart` | MEDIUM | Added mounted checks |
| `lib/final/load_contacts_v2/load_contacts_v2_widget.dart` | MEDIUM | Removed empty unawaited, unused import |
| `lib/backend/backend.dart` | MEDIUM | Debug-only logging |
| `lib/backend/cloud_functions/cloud_functions.dart` | MEDIUM | Debug-only logging |
| `lib/custom_code/actions/read_contacts.dart` | MEDIUM | Debug-only logging |
| `android/app/src/debug/AndroidManifest.xml` | LOW | Fixed manifest conflict |

---

## Testing Checklist

### Core Functionality
- [ ] App launches without crashes
- [ ] Add a new contact (tests SQL injection fix)
- [ ] Delete a contact (tests error handling)
- [ ] Search contacts (tests parameterized query)
- [ ] Trigger SOS with location enabled
- [ ] Trigger SOS with location disabled (tests error handling)
- [ ] Trigger SOS with no contacts (tests empty list handling)
- [ ] Enable/disable audio toggle
- [ ] Navigate to all pages without crashes
- [ ] Upload profile image (tests null safety)
- [ ] Import contacts from phone (tests permission error handling)

### Multi-User Data Isolation
- [ ] Login as User A, add contacts, set profile image
- [ ] Logout
- [ ] Login as User B - should see empty contacts and no profile image
- [ ] Add contacts as User B
- [ ] Logout and login as User A - should see only User A's contacts
- [ ] Verify SOS sends only to logged-in user's contacts

### Cross-Device Profile Sync
- [ ] Login on Device 1, set name and profile image
- [ ] Login on Device 2 (or clear app data and re-login) - name and image should appear
- [ ] Update name on Device 1 - should sync to Device 2 on next login
- [ ] Update profile image - should sync across devices

### Edge Cases
- [ ] First-time user sees empty state correctly
- [ ] Logout clears in-memory state (no data leakage)
- [ ] App works offline (except profile sync)

---

## Post-Implementation Notes

1. **API Keys:** Consider rotating all exposed API keys in Firebase/Google Cloud Console
2. **Version Bump:** Update version in `pubspec.yaml` before Play Store upload
3. **Firebase Rules:** Review storage rules separately in Firebase Console
4. **Twilio:** Consider moving SMS functionality to Cloud Functions for enhanced security

---

## Build Commands

```bash
# Clean and rebuild
flutter clean && flutter pub get && flutter build apk --debug

# Run on device
flutter run -d <device_id> --release

# Build release bundle for Play Store
flutter build appbundle --release
```

Output location: `build/app/outputs/bundle/release/app-release.aab`

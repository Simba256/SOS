# Quick Start: Production Release Guide

This is a condensed version of the full production checklist for quick reference.

## 🚨 Critical Path (Must Do Before Launch)

### 1. Security Setup (2-3 hours)

```bash
# 1. Firebase Security Rules
# Go to: https://console.firebase.google.com
# Navigation: Firestore Database → Rules
# Copy rules from PRODUCTION_CHECKLIST.md Phase 1
# Test and Publish

# 2. API Key Restrictions
# Go to: https://console.cloud.google.com/apis/credentials
# Restrict each API key to specific apps/domains
```

### 2. App Signing (1-2 hours)

**Android:**
```bash
# Generate keystore (if not exists)
keytool -genkey -v -keystore ~/sos-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias sos-key

# Create android/key.properties
echo "storePassword=YOUR_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=sos-key
storeFile=/absolute/path/to/sos-release-key.jks" > android/key.properties

# Test build
flutter build apk --release
```

**iOS:**
```bash
# In Xcode:
# 1. Open ios/Runner.xcworkspace
# 2. Select Runner → Signing & Capabilities
# 3. Select your team
# 4. Enable "Automatically manage signing"

# Test build
flutter build ios --release
```

### 3. Privacy Policy (1-2 hours)

- [ ] Create privacy policy (use template generator)
- [ ] Host on GitHub Pages or your website
- [ ] Add URL to both stores
- [ ] Add link in app settings

**Quick template:** Use https://www.privacypolicygenerator.info/

### 4. Store Metadata (2-3 hours)

**Screenshots needed:**
- 2-6 phone screenshots (1080x2400 for Android, 1290x2796 for iOS)
- Show: Home screen, SOS activation, Contacts list, Settings

**Descriptions:**
```
Short (80 chars):
Emergency SOS app with instant location sharing and emergency contact alerts

Full description:
[Write 200-500 words highlighting]:
- One-tap SOS alert
- GPS location sharing
- Multiple emergency contacts
- Different emergency types
- Audio and flashlight alerts
- Works offline
```

### 5. Testing Checklist (2-4 hours)

**Must test on release build:**
```bash
# Build release version
flutter build apk --release

# Install on device
adb install build/app/outputs/flutter-apk/app-release.apk

# Test critical flows:
```

- [ ] Sign up → Add contacts → Trigger SOS → Verify SMS sent
- [ ] Test with GPS disabled (should show error)
- [ ] Test with no internet (should still work locally)
- [ ] Test background location
- [ ] Test all emergency types

## 📦 Build & Submit Commands

### Google Play Store

```bash
# 1. Build release AAB (preferred)
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab

# 2. Upload to Google Play Console
# https://play.google.com/console
# → All apps → Your app → Production → Create new release

# 3. Fill out store listing
# → Store presence → Main store listing
```

### Apple App Store

```bash
# 1. Build iOS release
flutter build ipa --release

# Output: build/ios/archive/Runner.xcarchive

# 2. Upload via Xcode or Transporter
# Open Xcode → Window → Organizer → Archives → Distribute App

# 3. Submit via App Store Connect
# https://appstoreconnect.apple.com
# → My Apps → Your app → + Version
```

## ⚡ Most Common Issues & Fixes

### Issue 1: "Release build crashes immediately"
```bash
# ProGuard might be breaking something
# Edit android/app/build.gradle:
# Change: minifyEnabled true
# To: minifyEnabled false
# Then rebuild
```

### Issue 2: "Location not working in release"
```bash
# Check permissions in release build
# Android: Settings → Apps → SOS-APP → Permissions
# Verify: Location = "Allow all the time"

# iOS: Settings → SOS-APP → Location
# Verify: "Always" is selected
```

### Issue 3: "Firebase auth not working"
```bash
# 1. Check SHA-1 fingerprint is added to Firebase
keytool -list -v -keystore ~/sos-release-key.jks -alias sos-key

# 2. Add SHA-1 to Firebase Console
# → Project Settings → Your apps → Android app → Add fingerprint
```

### Issue 4: "App rejected by Apple for background location"
```
# Add detailed explanation in review notes:
"This emergency SOS app requires background location access to:
1. Send accurate location during emergencies even when app is closed
2. Continue tracking for ongoing emergency situations
3. Ensure help can reach the user quickly

Users are clearly informed and must explicitly grant this permission."
```

### Issue 5: "Signing error on iOS"
```bash
# Clear derived data and rebuild
rm -rf ~/Library/Developer/Xcode/DerivedData/*
flutter clean
flutter build ios --release
```

## 🎯 Minimum Viable Launch Checklist

If you're in a hurry, do **at least** these items:

- [x] Critical security issues fixed ✅ (We did this!)
- [ ] Firebase Security Rules configured
- [ ] Release signing set up (Android & iOS)
- [ ] Privacy policy created and linked
- [ ] Test on 3+ real devices
- [ ] Screenshots created (minimum 2 per platform)
- [ ] Store listings completed
- [ ] Crashlytics configured

**Time estimate:** 1-2 days with focused effort

## 📞 Need Help?

### Resources
- **Flutter Docs:** https://docs.flutter.dev/deployment
- **Firebase Console:** https://console.firebase.google.com
- **Google Play Console:** https://play.google.com/console
- **App Store Connect:** https://appstoreconnect.apple.com

### Community
- **Flutter Discord:** https://discord.gg/flutter
- **Stack Overflow:** Tag questions with `flutter`, `firebase`

---

**Next Steps:**
1. Review PRODUCTION_CHECKLIST.md for complete details
2. Start with Phase 1 (Security)
3. Work through each phase systematically
4. Use this guide for quick reference

Good luck! 🚀

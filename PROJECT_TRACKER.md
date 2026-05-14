# Project Tracker

> Last updated: 2026-05-14

## Project Summary
SOS Emergency App - one-tap emergency alert app that sends SMS with GPS coordinates to emergency contacts.

## Current Status
**Status**: Active - Fixing policy rejection, resubmitting v1.0.4

## In Progress
- [ ] Resubmit v1.0.4+4 to Google Play production after SMS permission fix

## Recently Completed
- [x] SOS morse pattern retimed to spec (S: 1/1×3, O: 2/1×3, S: 1/1×3, 2s pause) in `s_o_s_animated_widget.dart`; torch/audio/screen-flash already share `FFAppState().currentSOSState` so they stay in sync — (2026-05-14)
- [x] v1.0.4+4 built — removed telephony plugin, SEND_SMS permission, proguard rule (2026-04-15)
- [x] Diagnosed rejection: unused `telephony` plugin was manifest-merging SMS permissions (2026-04-15)
- [x] First production submission rejected for SMS/Call log permission policy — (2026-04-14)
- [x] Google Play production access granted — (2026-04-11)
- [x] Applied for production access — (2026-04)
- [x] 14-day closed testing period completed — (2026-03-27)
- [x] 20 testers milestone reached — (2026-03)
- [x] v1.0.3 approved for Closed Testing on Google Play — (2026-03-12)
- [x] Closed testing release v3 (1.0.3) — available to selected testers in Canada, Pakistan (2026-03-12)
- [x] Fix keyboard overflow and create contact image error — (2026-03-12)
- [x] Multi-user data isolation — (2026-03-12)
- [x] Cross-device profile sync — (2026-03-12)

## Upcoming / Planned
- [ ] Prepare and submit production release to Google Play
- [ ] Set up production listing (full description, screenshots, feature graphic)
- [ ] Expand target countries beyond Canada/Pakistan if desired

## Blockers
- None

## Key Decisions
- (2026-04-15) Removed `telephony` plugin entirely — app uses intent-based SMS (`sms:`/`smsto:` URIs via url_launcher), so telephony was dead code that was manifest-merging SEND_SMS into the APK and triggering policy rejection.

## Key Decisions
- (2026-03-12) Target countries: Canada, Pakistan for closed testing
- (2026-03-12) App ID: com.chameleonideas.sosapp
- (2026-03-12) Feedback email: simba.dev256@gmail.com

## Notes
- Test link: https://play.google.com/apps/testing/com.chameleonideas.sosapp
- Install link: https://play.google.com/store/apps/details?id=com.chameleonideas.sosapp

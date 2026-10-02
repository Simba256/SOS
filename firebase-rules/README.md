# Firebase Security Rules - SOS Emergency App

This directory contains production-ready security rules for your Firebase backend.

## 📄 Files

- **`firestore.rules`** - Security rules for Firestore Database
- **`storage.rules`** - Security rules for Firebase Storage

## 🔒 What These Rules Protect

### Firestore Security Rules

**User Profiles:**
- ✅ Users can only read/write their own profile
- ✅ 100KB size limit per profile
- ✅ Must be authenticated

**Emergency Contacts:**
- ✅ Users can only access their own emergency contacts
- ✅ 10KB size limit per contact
- ✅ No one else can see your contacts

**SOS Alerts:**
- ✅ Users can create their own alerts
- ✅ Users can read alerts where they're the creator OR an emergency contact
- ✅ Users can update/delete only their own alerts
- ✅ 50KB size limit per alert

**Location Sharing:**
- ✅ Users control who can see their shared location
- ✅ Only creator and specified contacts can access
- ✅ 5KB size limit

**Default Deny:**
- ❌ All other paths are blocked by default

### Storage Security Rules

**Profile Images:**
- ✅ Anyone can view profile images (public)
- ✅ Users can only upload their own profile images
- ✅ Must be an image file
- ✅ 5MB size limit

**SOS Alert Attachments:**
- ✅ Users can upload photos/videos to their alerts
- ✅ Only authenticated users can view
- ✅ 20MB size limit (for videos)

**Emergency Contact Photos:**
- ✅ Users can only upload photos for their own contacts
- ✅ 2MB size limit
- ✅ Private to the user

## 🚀 How to Deploy These Rules

### Step 1: Open Firebase Console
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your **SOS Emergency App** project

### Step 2: Deploy Firestore Rules
1. In the left sidebar, click **Firestore Database**
2. Click the **Rules** tab at the top
3. You'll see the current rules (probably the default test rules)
4. **Delete all existing rules**
5. **Copy and paste** the entire content from `firestore.rules`
6. Click **Publish** button
7. Wait for confirmation: "Rules published successfully"

### Step 3: Deploy Storage Rules
1. In the left sidebar, click **Storage**
2. Click the **Rules** tab at the top
3. You'll see the current rules
4. **Delete all existing rules**
5. **Copy and paste** the entire content from `storage.rules`
6. Click **Publish** button
7. Wait for confirmation: "Rules published successfully"

### Step 4: Test the Rules
1. Go back to **Firestore Database** → **Rules** tab
2. Click on **Rules Playground** (if available)
3. Test a few scenarios:
   - Try reading `/users/{your-uid}` → Should succeed
   - Try reading `/users/{different-uid}` → Should fail
   - Try creating `/sos_alerts/{id}` while authenticated → Should succeed

## ✅ Verification Checklist

After deploying, verify:

- [ ] Firestore rules deployed successfully
- [ ] Storage rules deployed successfully
- [ ] Test authentication in your app
- [ ] Verify users can access only their own data
- [ ] Verify emergency contacts are private
- [ ] No errors in Firebase Console → Usage tab

## 🔐 Security Features Included

✅ **Authentication Required** - All operations require authenticated users
✅ **User Isolation** - Users can only access their own data
✅ **Size Limits** - Prevents abuse with reasonable size restrictions
✅ **Type Validation** - Only allowed file types can be uploaded
✅ **Emergency Contact Privacy** - Contacts are private to each user
✅ **SOS Alert Sharing** - Alerts are shared only with specified emergency contacts
✅ **Default Deny** - Everything not explicitly allowed is denied

## 📊 Size Limits Summary

| Data Type | Size Limit | Reason |
|-----------|-----------|--------|
| User Profile | 100KB | Adequate for profile data |
| Emergency Contact | 10KB | Name + phone + basic info |
| SOS Alert | 50KB | Location + message + metadata |
| Location Share | 5KB | GPS coordinates + timestamp |
| Profile Image | 5MB | High-quality profile photos |
| Contact Photo | 2MB | Imported contact photos |
| Alert Attachments | 20MB | Photos/videos from emergency |

## 🚨 Important Notes

1. **Test Before Production** - Test these rules in a development environment first if possible
2. **Monitor Usage** - Check Firebase Console for denied requests after deployment
3. **User Impact** - Existing users will need to be authenticated; anonymous access is blocked
4. **Backup First** - Save your current rules before replacing them
5. **Emergency Contacts Access** - Emergency contacts can read SOS alerts they're part of

## 🐛 Troubleshooting

**If users can't access their data:**
- Check that `userId` in documents matches `request.auth.uid`
- Verify users are properly authenticated
- Check Firestore Console → Usage tab for errors

**If file uploads fail:**
- Check file size is within limits
- Verify file type (must be image for most cases)
- Check user is authenticated

**If you need to make changes:**
- Edit the `.rules` files
- Redeploy through Firebase Console
- Rules take effect immediately (no app update needed)

## 📞 Support

If you encounter issues:
1. Check Firebase Console → Usage → Errors
2. Review denied requests in the logs
3. Verify your app's authentication is working
4. Check that document paths match the rules

---

**Created:** December 13, 2025
**Version:** 1.0
**Status:** Production Ready ✅

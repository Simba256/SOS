# SOS Emergency App - Privacy Policy & Terms

This directory contains the Privacy Policy and Terms of Service pages for the SOS Emergency App.

## 📄 Files

- `index.html` - Privacy Policy page
- `terms.html` - Terms of Service page
- `vercel.json` - Vercel deployment configuration
- `README.md` - This file

## 🚀 Deploy to Vercel

### Option 1: Using Vercel CLI (Recommended)

1. **Install Vercel CLI** (if not already installed):
   ```bash
   npm install -g vercel
   ```

2. **Navigate to this directory**:
   ```bash
   cd privacy-policy
   ```

3. **Deploy**:
   ```bash
   vercel
   ```

4. **Follow the prompts**:
   - Link to existing project or create new
   - Confirm settings
   - Deploy!

5. **Get your URL**:
   - The CLI will provide a deployment URL (e.g., `https://sos-app-privacy.vercel.app`)
   - Use this URL in your Play Store and App Store listings

### Option 2: Using Vercel Dashboard

1. **Go to** [vercel.com](https://vercel.com)
2. **Sign in** with GitHub, GitLab, or Bitbucket
3. **Click "Add New Project"**
4. **Import this directory**:
   - If using Git: Select your repository and set root directory to `privacy-policy`
   - If not using Git: Drag and drop the `privacy-policy` folder
5. **Deploy**
6. **Copy your deployment URL**

### Option 3: Using GitHub + Vercel (Automatic Deployments)

1. **Push this directory to GitHub**:
   ```bash
   cd /media/shared/Chameleon-Ideas/SOS
   git add privacy-policy/
   git commit -m "Add privacy policy and terms pages"
   git push
   ```

2. **Connect to Vercel**:
   - Go to [vercel.com](https://vercel.com)
   - Import your GitHub repository
   - Set root directory: `privacy-policy`
   - Deploy

3. **Automatic updates**:
   - Any future changes will auto-deploy when you push to GitHub

## 🔗 URLs You'll Get

After deployment, you'll have URLs like:
- **Privacy Policy**: `https://your-project.vercel.app/` or `https://your-project.vercel.app/index.html`
- **Terms of Service**: `https://your-project.vercel.app/terms.html`

Alternative URLs that also work:
- `https://your-project.vercel.app/privacy`
- `https://your-project.vercel.app/privacy-policy`

## 📱 Add URLs to App Stores

### Google Play Store
1. Go to [Google Play Console](https://play.google.com/console)
2. Select your app
3. Go to: **Store presence** → **Main store listing**
4. Add Privacy Policy URL: `https://your-project.vercel.app/`
5. Add Website URL (optional): `https://your-project.vercel.app/`

### Apple App Store
1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Select your app
3. Go to: **App Information**
4. Add Privacy Policy URL: `https://your-project.vercel.app/`
5. Add Terms of Use URL: `https://your-project.vercel.app/terms.html`

## 🛠️ Customization

### Update Contact Email
In both `index.html` and `terms.html`, update:
```html
<p><strong>Email:</strong> support@chameleon-ideas.com</p>
```

### Update Company Information
Replace "Chameleon Ideas" and "Karachi, Sindh, Pakistan" with your information if needed.

### Custom Domain (Optional)
1. Purchase a domain (e.g., `sos-app.com`)
2. In Vercel dashboard: **Settings** → **Domains**
3. Add your custom domain
4. Update DNS records as instructed
5. Use custom URL in app store listings

## ✅ What's Included

### Privacy Policy Covers:
- ✅ Data collection (location, contacts, user info)
- ✅ How data is used
- ✅ Data sharing and security
- ✅ User rights (GDPR, CCPA)
- ✅ Permissions explanation
- ✅ Children's privacy
- ✅ Contact information

### Terms of Service Covers:
- ✅ Emergency disclaimer
- ✅ User responsibilities
- ✅ Service limitations
- ✅ Liability limitations
- ✅ Account termination
- ✅ Intellectual property
- ✅ Governing law

## 📊 Compliance

These documents are designed to comply with:
- ✅ Google Play Store requirements
- ✅ Apple App Store requirements
- ✅ GDPR (European Union)
- ✅ CCPA (California)
- ✅ General privacy best practices

## 🔐 Security Headers

The `vercel.json` configuration includes security headers:
- X-Content-Type-Options
- X-Frame-Options
- X-XSS-Protection

## 📝 Notes

- Remember to update the "Last Updated" date when making changes
- Keep both pages accessible and easy to read
- Test all links before submitting to app stores
- Consider having legal counsel review if handling sensitive data

## 🆘 Need Help?

If you need to modify the content:
1. Edit `index.html` for Privacy Policy
2. Edit `terms.html` for Terms of Service
3. Redeploy to Vercel
4. Updated content will be live immediately

---

**Created for:** SOS Emergency App
**Organization:** Chameleon Ideas
**Date:** December 13, 2025

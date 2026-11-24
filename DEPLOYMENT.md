# Deployment Guide — AI Virtual Healthcare Assistant

This package is pre-configured for one-click deployment on **Render**, **Railway**, or **Google Cloud Run**.

## 1. Required Environment Variables
Set these in your cloud provider's **Environment / Variables** settings:

| Variable | Required | Description |
| :--- | :--- | :--- |
| `GEMINI_API_KEY` | **Yes** | Your Google Gemini API key for AI Health Chat, Symptom Checker, and Prescription Scanner. |
| `SESSION_SECRET` | **Yes** | Any random 32+ character secret string for signing session tokens. |
| `ADMIN_PASSWORD` | Recommended | Password for `admin@medassist.in` (if omitted, claim it on first visit via the Admin Login page). |
| `GOOGLE_MAPS_API_KEY` | Optional | Google Maps JavaScript & Places API key for the Clinic Locator. |
| `NODE_ENV` | **Yes** | Set to `production`. |

---

## 2. Deploy on Render (Easiest — Uses `render.yaml`)
1. Create a new GitHub repository and upload all files from this ZIP (`.env` and `data/db.json` are automatically ignored).
2. Log in to [Render](https://render.com) -> **New +** -> **Blueprint** (or **Web Service**).
3. Connect your GitHub repository:
   - **Build Command:** `npm install && npm run build`
   - **Start Command:** `npm start`
   - **Health Check Path:** `/api/health`
4. Add `GEMINI_API_KEY` (and optional `ADMIN_PASSWORD`, `GOOGLE_MAPS_API_KEY`) in **Environment Variables**.
5. Click **Deploy Web Service**.

---

## 3. Deploy on Railway (Uses `railway.toml` + `Dockerfile`)
1. Push this folder to GitHub.
2. Open [Railway](https://railway.app) -> **New Project** -> **Deploy from GitHub repo**.
3. Railway automatically detects `Dockerfile` and `railway.toml` (which bundles both Node.js 20 and Python 3).
4. Add `GEMINI_API_KEY`, `SESSION_SECRET`, and `NODE_ENV=production` in **Variables**.
5. Generate a public domain under **Settings -> Networking**.

---

## 4. Deploy on Google Cloud Run (Uses `Dockerfile`)
```bash
gcloud run deploy ai-virtual-healthcare-assistant \
  --source . \
  --platform managed \
  --allow-unauthenticated \
  --set-env-vars "NODE_ENV=production,GEMINI_API_KEY=YOUR_KEY,SESSION_SECRET=YOUR_32_CHAR_SECRET"
```

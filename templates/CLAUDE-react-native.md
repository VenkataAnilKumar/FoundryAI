# CLAUDE.md — React Native AI Mobile App

Drop this file into your project root. It tells Claude Code your stack and how to use the agent team.

---

## Project Overview

**Type**: AI-powered mobile app
**Stack**: React Native (Expo) + FastAPI + PostgreSQL + Claude API
**Platforms**: iOS + Android
**Stage**: [Prototype / Alpha / TestFlight / Production]

---

## Tech Stack

```
Mobile:     React Native, Expo SDK 51+, TypeScript
Navigation: Expo Router (file-based)
State:      Zustand / Jotai
API client: React Query (TanStack Query)
AI:         Anthropic Claude API (via backend), on-device ML via TFLite/Core ML
Auth:       Clerk Expo / Supabase Auth
Storage:    MMKV (fast), Expo SecureStore (sensitive), AsyncStorage (general)
Backend:    FastAPI, PostgreSQL, Redis
Push:       Expo Notifications / FCM / APNs
Deploy:     EAS Build + Submit (App Store + Play Store)
```

---

## Agent Routing

### Mobile
- All React Native / Expo work → `ai-mobile-engineer`
- Complex mobile + backend features → `ai-mobile-engineer` + `ai-backend-engineer`
- On-device ML (Core ML, TFLite) → `ai-mobile-engineer` + `ai-engineer`

### AI Features
- LLM integration, Claude API → `ai-engineer`
- Streaming responses in mobile → `ai-mobile-engineer` + `ai-engineer`
- Prompt design → `ai-prompt-engineer`
- Eval for AI features → `ai-qa-engineer`

### Backend
- API endpoints → `ai-backend-engineer`
- Push notifications, background jobs → `ai-backend-engineer`
- DB schema, migrations → `ai-database-engineer`

### Design & UX
- Mobile UX flows, screens → `ai-ux-designer`
- AI interaction patterns → `ai-ux-designer` + `ai-engineer`

### Quality
- Mobile accessibility → `ai-accessibility-engineer`
- Performance (render, memory, battery) → `ai-performance-engineer`
- Security (storage, auth, API) → `ai-security-engineer`

### Launch
- App Store / Play Store submission → `ai-devops-engineer`
- Analytics, crash reporting → `ai-analytics-engineer`
- Privacy policy, permissions → `ai-legal-engineer`

### Everything else
- `/founder "describe task"` — routes automatically

---

## Coding Conventions

```
- TypeScript strict — no any, no ts-ignore
- Expo Router for all navigation — no React Navigation directly
- Components in /components, screens in /app (Expo Router)
- All API calls through /lib/api.ts (React Query hooks)
- All AI calls through /lib/ai.ts — never call Claude API directly from mobile
- Sensitive data in Expo SecureStore — never AsyncStorage
- No hardcoded API keys — use EAS secrets
- StyleSheet.create() or NativeWind — no inline styles
```

## Mobile AI Conventions
```
- Streaming responses: SSE via backend, displayed with typewriter effect
- Offline mode: cache last AI responses in MMKV
- Error states: always show user-friendly message when AI fails
- Loading states: skeleton screens while AI responds
- Context window: summarize conversation history after 10 turns
- On-device models: use for < 50ms tasks (classification, embeddings)
```

## Directory Structure
```
app/                   ← Expo Router screens (file = route)
  (auth)/              ← auth flow screens
  (tabs)/              ← main tab screens
  _layout.tsx          ← root layout
components/
  ui/                  ← reusable UI components
  ai/                  ← AI-specific components (chat, streaming)
lib/
  api.ts               ← React Query client + all API calls
  ai.ts                ← AI/LLM calls (proxied through backend)
  storage.ts           ← MMKV + SecureStore wrappers
  auth.ts              ← auth utilities
stores/                ← Zustand stores
assets/                ← images, fonts, icons
backend/               ← FastAPI backend (same repo or separate)
```

## Common Tasks

```bash
# Start dev
npx expo start         # starts Expo dev server
npx expo start --ios   # iOS simulator
npx expo start --android  # Android emulator

# Build
eas build --platform ios --profile preview     # TestFlight build
eas build --platform android --profile preview # Internal testing
eas build --platform all --profile production  # App Store + Play Store

# Submit
eas submit --platform ios      # Submit to App Store
eas submit --platform android  # Submit to Play Store

# OTA update (no app store review)
eas update --branch production --message "Fix AI response parsing"

# Tests
npx jest                # unit tests
npx maestro test flows/ # E2E with Maestro
```

## Key Files to Know
```
app.json / eas.json    ← Expo + EAS config
app/(tabs)/_layout.tsx ← Tab bar configuration
lib/api.ts             ← Every API call goes through here
lib/ai.ts              ← Every AI call goes through here
stores/                ← Global state — check here before adding useState
```

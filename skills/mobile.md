---
description: Build mobile apps — iOS/Android/React Native/Flutter patterns, on-device AI, app store, performance, offline
argument-hint: Describe the mobile app, feature, or challenge
---

You are a mobile engineer. Build native-quality experiences. Users have zero tolerance for slow, janky, or battery-draining apps — they will uninstall before filing a bug report.

## Mobile App or Feature
$ARGUMENTS

---

## Step 1: Choose the Right Platform

| Approach | Best for | Trade-offs |
|---|---|---|
| **React Native** | Web team wanting mobile, JS/TS expertise, shared business logic | Bridge overhead, native modules needed for advanced features |
| **Flutter** | Custom UI, cross-platform consistency, fast animations | Dart language, large binary size |
| **Swift (iOS native)** | Maximum iOS performance, latest Apple APIs, on-device ML | iOS only, steeper learning curve |
| **Kotlin (Android native)** | Maximum Android performance, latest Android APIs | Android only |
| **Expo (RN managed)** | Fastest start, over-the-air updates, easy CI | Less control, Expo SDK constraints |

**Decision rule:**
- If team is web-first and needs mobile fast → React Native / Expo
- If UI/animation quality is primary differentiator → Flutter
- If deep platform integration (ARKit, HealthKit, NFC) → Native
- If on-device AI is the core feature → Native (CoreML/TFLite) or Flutter with native plugins

---

## 2. Architecture Patterns

### State Management

**React Native:**
```
Simple app (< 10 screens):     useState + useContext + React Query
Medium app:                     Zustand (minimal boilerplate)
Complex app:                    Redux Toolkit (predictable, excellent DevTools)
Server state everywhere:        React Query / TanStack Query (cache + sync)
```

**Flutter:**
```
Simple:       setState / Provider
Medium:       Riverpod (safe, testable)
Complex:      BLoC (predictable state streams, great for enterprise)
```

### Navigation

**React Native:**
- React Navigation (standard choice — community, documentation, flexibility)
- Expo Router (file-based, like Next.js, great for Expo projects)

**Flutter:**
- GoRouter (declarative, deep link support)
- Auto Route (code generation, type-safe)

**Navigation structure:**
```
Stack navigator         — linear flows (onboarding, checkout)
Tab navigator           — main app sections (bottom tabs)
Drawer navigator        — secondary navigation
Modal stack             — overlays and sheets
Nested navigators       — combine the above
```

### Offline-First Architecture
```
Network request
    ↓
Local cache (SQLite / MMKV / Core Data)
    ↓
Display cached data immediately
    ↓
Background sync when network available
    ↓
Optimistic UI updates (show change before server confirms)
    ↓
Conflict resolution on sync (last-write-wins or field-level merge)
```

---

## 3. On-Device AI

### Model Formats and Runtimes

| Framework | Platform | Model format | Use case |
|---|---|---|---|
| **Core ML** | iOS/macOS only | .mlpackage / .mlmodel | Apple-native, best iOS performance |
| **TFLite** | iOS + Android | .tflite | Cross-platform, good ecosystem |
| **ONNX Runtime Mobile** | iOS + Android | .onnx | Good for models trained in PyTorch/sklearn |
| **MediaPipe** | iOS + Android | MediaPipe graph | Google's pre-built vision/audio tasks |
| **Executorch (PyTorch)** | iOS + Android | .pte | Meta's mobile PyTorch runtime |

### When to Use On-Device vs. API

| Factor | On-device | API call |
|---|---|---|
| Latency requirement | < 100ms | > 200ms acceptable |
| Offline requirement | Required | Not required |
| Privacy | Sensitive data (health, biometrics) | Non-sensitive |
| Model size | < 100MB practical, < 10MB ideal | Any size |
| Compute cost | One-time (included in app) | Per-call cost |
| Model freshness | Static (update via app update) | Always latest |

### Model Optimization for Mobile
```
1. Quantization: float32 → int8 reduces size 4x, minimal accuracy loss
   - Post-training quantization: fast, slight accuracy drop
   - Quantization-aware training: slower, better accuracy

2. Pruning: remove low-weight connections (30–50% size reduction)

3. Knowledge distillation: train small "student" model to mimic large "teacher"

4. Format: Convert to CoreML / TFLite after training on PyTorch / TF
   - coremltools: PyTorch → CoreML
   - TFLite converter: TF / ONNX → TFLite
```

---

## 4. Performance

### Render Performance

**React Native — common causes of jank:**
```
1. Heavy JS on main thread     → Move to worklet (Reanimated 2/3)
2. Too many re-renders         → React.memo, useMemo, useCallback
3. Large lists not virtualized → FlatList or FlashList (preferred)
4. Images not cached           → FastImage or Expo Image
5. Shadow calculations         → Use elevation (Android) / shadowOpacity (iOS) sparingly
6. Bridge calls in animation   → Use Reanimated animated values (JS-free)
```

**Flutter — common causes of jank:**
```
1. Build methods doing heavy work → Move to isolates or compute()
2. Too many widgets in tree       → const constructors, RepaintBoundary
3. Images not cached              → CachedNetworkImage
4. Scroll jank                    → ListView.builder, not ListView with children
5. Animation using setState       → AnimationController + Tween
```

### Memory Management
```
- Never store large bitmaps decoded — display size, not full resolution
- Cancel async operations on component unmount / dispose
- Use pagination for lists (never fetch all records at once)
- Profile with Xcode Instruments (iOS) / Android Profiler before shipping
```

### Battery & Network Efficiency
```
- Background tasks: use OS-scheduled background fetch (not polling loops)
- Network: batch requests, use HTTP/2, cache aggressively
- Location: use significant location change vs. continuous GPS when possible
- Push notifications vs. polling: always prefer push
- Avoid wake locks unless absolutely necessary
```

---

## 5. App Store Preparation

### iOS App Store (Apple)

**Review preparation checklist:**
- [ ] App functions completely offline if claiming offline support
- [ ] All referenced features in description are actually in the app
- [ ] No placeholder content, lorem ipsum, or test data
- [ ] Login required? Provide demo credentials in App Review notes
- [ ] Privacy nutrition label completed (data types, purposes, linked/unlinked)
- [ ] App Tracking Transparency (ATT) prompt if using IDFA
- [ ] No private API usage (App Store rejects these — use Entitlements check)
- [ ] Minimum iOS version set appropriately (target iOS 16+ for new apps)
- [ ] App icon in all required sizes (use Asset Catalog)

**Common rejection reasons:**
- Guideline 2.1: Crashes or broken flows
- Guideline 4.0: Copycat or thin-wrapper apps
- Guideline 5.1: Privacy violations (data collected not disclosed)
- Guideline 3.1: Payments not using IAP for digital goods

### Google Play Store

**Checklist:**
- [ ] Target API 34+ (required for new apps in 2024+)
- [ ] 64-bit support enabled
- [ ] App Bundle (.aab) not APK (required for new submissions)
- [ ] Permissions declared with rationale
- [ ] Data safety form completed
- [ ] Content rating questionnaire completed
- [ ] Production track requires minimum 20 internal testers before rollout

---

## 6. Testing Strategy

```
Unit tests:       Business logic, state management, pure functions
Integration tests: Navigation flows, API integration
Component tests:  React Native Testing Library / Flutter widget tests
E2E tests:        Detox (RN) / Patrol or Integration tests (Flutter)
                  Run on real devices in CI — simulators miss OS-level bugs
Device testing:   Physical devices for: camera, biometrics, NFC, GPS, notifications
```

**CI/CD for mobile:**
- Build + test on every PR
- Distribute test builds via TestFlight (iOS) / Firebase App Distribution (Android)
- Fastlane for automated signing, versioning, and store submission
- Bitrise, Codemagic, or GitHub Actions with self-hosted macOS runner

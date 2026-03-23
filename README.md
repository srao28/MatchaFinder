# MatchaFinder

iOS app (SwiftUI) for discovering matcha shops. **Iteration 1** delivers a navigable UI skeleton with mock data, SwiftData persistence for favorites and ratings, and MapKit + Core Location—without live Google Places or other HTTP APIs.

**Course documentation** (UML, use cases, walkthrough notes) lives next to this repo: **`MatchaFinder-project-docs/`** under the same CSE 335 parent folder. 

---

## What’s done so far

### App structure
- **Tab bar**: Explore, Map, Favorites, Settings (`ContentView`).
- **Theme**: Primary colour = green (`AccentColor` asset); secondary = white (`MatchaTheme`).
- **MVVM-style layout**: Models, `ViewModels/`, `Views/`, `Services/` (API stub only).

### Screens
- **Explore**: Searchable list of mock shops → detail.
- **Map**: San Francisco default region; mock shop pins; user location and `MapUserLocationButton` when location is authorized.
- **Favorites**: SwiftData-backed list; swipe to remove from favorites; navigation to the same detail screen.
- **Settings**: App name; location permission helpers; placeholder toggle for “notify when near favorites”; demo button to request notification permission (no geofences yet).

### Data
- **`MatchaShop`**: Plain struct for UI (name, address, coordinates, mock rating, hours text).
- **`MockShopData`**: Single source of hardcoded shops (keyed by `placeId`).
- **SwiftData**
  - **`PersistedShop`**: Unique `placeId`, optional `favoriteSavedAt`, optional `userStarRating` (1–5).
  - **`RecentlyViewedShop`**: Unique `placeId`, `viewedAt` (updated when a shop’s detail is opened).

### Detail screen
- Mock venue rating, address, hours placeholder.
- User star rating (persisted; tap same star to clear).
- Add/remove favorite (SwiftData).
- **ShareLink** sharing shop name + address (plain text).

### Location & notifications
- **`LocationManager`**: When-in-use authorization; publishes user coordinate for distances on lists.
- **Info.plist keys** (via Xcode build settings): location and user-notification usage descriptions.

### Places / network
- **`PlacesAPIService`**: Empty stub with a TODO for iteration 2 (no `URLSession`, no API keys).

### Project
- Xcode project uses a **synchronized folder** for `MatchaFinder/`; new Swift files in that folder are included automatically.
- **Build**: Open in Xcode and build (⌘B), or `xcodebuild -scheme MatchaFinder -destination 'generic/platform=iOS Simulator' build`.

---

## What’s not built yet (planned / course follow-on)

### Remote services
- **Google Places (or similar)**: Fetch names, addresses, ratings, hours, photos; parse JSON asynchronously; replace or augment `MockShopData`.
- Wire **`PlacesAPIService`** (or equivalent) with real endpoints, error handling, and loading states.

### Map & location
- Optional polish: recentering behavior, custom annotation views, richer callouts.
- **Proximity / geofencing**: Region monitoring or significant-location flows tied to favorites; the Settings toggle is UI-only for now.

### Data & UI
- **Recently viewed**: Persisted in SwiftData, but **no dedicated list or section** in the UI yet.
- **Tests**: Unit/UI tests are still minimal templates; no coverage for view models or SwiftData yet.

### Product / polish
- Real images (URLs or assets) instead of placeholders.
- Accessibility pass, localization, and App Store assets as needed.
- Any professor-specific extras (e.g. additional persistence rules or reporting).

---

## Repository layout (main app target)

| Area | Contents |
|------|----------|
| `MatchaFinderApp.swift` | App entry, SwiftData `ModelContainer`, shared environments. |
| `ContentView.swift` | Root `TabView`. |
| `MockShopData.swift` | Mock catalog. |
| `Models/` | `MatchaShop`, `PersistedShop`, `RecentlyViewedShop`. |
| `ViewModels/` | `ShopDirectoryViewModel`. |
| `Views/` | Explore, Map, Favorites, Settings, detail, row. |
| `Services/` | `LocationManager`, `PlacesAPIService` (stub). |
| `Theme/` | `MatchaTheme`. |

---

## Requirements snapshot (course alignment)

| Area | Status in repo |
|------|----------------|
| SwiftData (favorites, ratings, recently viewed rows) | Done (recently viewed **data** only; no list screen). |
| MVVM with SwiftUI | Done at skeleton level. |
| Lists + navigation | Done (Explore + Favorites). |
| MapKit + user location | Done (mock pins + permission flow). |
| Remote Places API | **Not** implemented (stub only). |
| Proximity notifications | Preference + demo auth only; **no** real geofences. |

If you extend the app, update this README so it stays a truthful checklist for demos and grading.

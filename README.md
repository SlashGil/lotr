# 💍 Middle-Earth Lore — Lord of the Rings Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-3.13+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.6.1-blue?style=for-the-badge&logo=dart&logoColor=white)](https://riverpod.dev)
[![GoRouter](https://img.shields.io/badge/GoRouter-14.8.1-green?style=for-the-badge&logo=flutter&logoColor=white)](https://pub.dev/packages/go_router)
[![Dio](https://img.shields.io/badge/Dio-5.11.1-orange?style=for-the-badge&logo=dart&logoColor=white)](https://pub.dev/packages/dio)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

A modern, immersive **Lord of the Rings (LOTR)** Flutter application designed with a **Feature-First Architecture** and an **Earthy Fantasy Minimalist Dark Theme**. The app connects to [The One API](https://the-one-api.dev/) to fetch characters, lore, realms, and attributes from J.R.R. Tolkien's legendarium.

---

## ✨ Features

- 📜 **Middle-Earth Character Directory**: Explore iconic characters including Aragorn, Gandalf, Frodo, Legolas, Galadriel, Sauron, and more.
- 🔍 **Real-time Search & Filtering**: Instant filter by character name, race (Elf, Human, Hobbit, Maiar, Dwarf), or realm (Gondor, Rivendell, Shire, Mordor).
- 🎨 **Earthy Fantasy Aesthetics**: Custom dark palette inspired by deep forest greens, muted moss surfaces, and One Ring gold accents.
- ✒️ **Cinematic Typography**: Custom Google Fonts pairing (*Cinzel* serif for medieval headings and *Lato* for body legibility).
- ⚡ **Reactive State Management**: Powered by **Riverpod** with automatic caching, pull-to-refresh, loading skeletons, and error handling.
- 🌐 **Robust API Integration**: Uses **Dio** with HTTP interceptors for Bearer Token authentication and automatic offline mock fallback.
- 🗺️ **Declarative Routing**: Clean, type-safe navigation handled by **GoRouter**.

---

## 🎨 Color Palette & Typography

| Swatch | Color Name | Hex Code | Role in UI |
| :---: | :--- | :--- | :--- |
| 🟩 | **Deep Forest** | `#1A1F1B` | App background |
| 🌿 | **Muted Moss** | `#2A322C` | Surface cards & input containers |
| 🔱 | **One Ring Gold** | `#D4AF37` | Primary accent, headers & hover highlights |
| 🤍 | **Soft White** | `#F3F3F3` | Primary text |
| 🩶 | **Sage Grey** | `#A5B0A8` | Secondary labels & subheaders |

* **Headings**: [Cinzel](https://fonts.google.com/specimen/Cinzel) — A classical serif font inspired by first-century Roman inscriptions.
* **Body Text**: [Lato](https://fonts.google.com/specimen/Lato) — Clean, highly readable sans-serif typeface.

---

## 🏗️ Architecture & Project Structure

The project follows a **Feature-First Architecture**, separating core cross-cutting concerns from feature-specific data, domain, and presentation layers:

```text
lib/
├── main.dart                   # Entry point (ProviderScope, MaterialApp.router)
├── core/
│   ├── network/                # Dio client setup, interceptors, base API configuration
│   │   └── dio_client.dart
│   ├── routing/                # GoRouter route definitions & parameters
│   │   └── app_router.dart
│   └── theme/                  # App colors, custom typography & ThemeData
│       ├── app_colors.dart
│       └── app_theme.dart
└── features/
    └── characters/             # Character feature module
        ├── data/               # Models & API Repository
        │   ├── models/
        │   │   └── character.dart
        │   └── repositories/
        │       └── character_repository.dart
        ├── providers/          # Riverpod state providers
        │   └── character_providers.dart
        └── presentation/       # UI Screens & Reusable Widgets
            ├── character_list_screen.dart
            ├── character_detail_screen.dart
            └── widgets/
                └── character_card.dart
```

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your system:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.13.5`)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/lotr-flutter.git
   cd lotr-flutter
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure API Key** *(Optional)*:
   Get a free API key from [The One API](https://the-one-api.dev/signup).
   You can supply your token directly in `lib/core/network/dio_client.dart` or via environment variables:
   ```dart
   static const String defaultApiKey = 'YOUR_API_TOKEN';
   ```
   > *Note: If no API key is provided or if network calls fail, the app automatically falls back to an offline mock dataset.*

4. **Run the Application**:
   ```bash
   flutter run
   ```

---

## 🧪 Testing & Analysis

To verify code quality and run automated tests:

- **Run Static Code Analysis**:
  ```bash
  flutter analyze
  ```

- **Execute Unit & Widget Tests**:
  ```bash
  flutter test
  ```

---

## 🛠️ Tech Stack & Packages

- **[Flutter](https://flutter.dev)** — Cross-platform UI toolkit.
- **[Flutter Riverpod](https://pub.dev/packages/flutter_riverpod)** — Reactive state management & dependency injection.
- **[Dio](https://pub.dev/packages/dio)** — Powerful HTTP client with interceptors & global configuration.
- **[GoRouter](https://pub.dev/packages/go_router)** — Declarative routing system.
- **[Google Fonts](https://pub.dev/packages/google_fonts)** — Dynamic font loading (*Cinzel* & *Lato*).

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<p align="center">
  <i>"Not all those who wander are lost." — J.R.R. Tolkien</i>
</p>

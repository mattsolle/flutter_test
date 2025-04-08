# Restaurant Tour – Showcase Documentation

## 🔍 Overview

Restaurant Tour is a Flutter-based showcase application developed to demonstrate production-ready Flutter development practices, scalable architecture, and robust state management. The application allows users to browse a list of restaurants, view detailed information, and manage a list of favorites—all backed by Yelp’s GraphQL API.

This is a **showcase project**, not a client application, and is designed to reflect clean code principles, testability, and real-world use of Flutter frameworks.

---

## 🏗 Architecture Overview

The project follows **Domain-Driven Design (DDD)** principles, structured into clearly separated layers:

- **Data Layer**: Responsible for data retrieval and persistence. This includes API service calls, DTOs, and repositories.
- **Domain Layer**: Contains business logic, use cases, and entities. It defines abstract contracts implemented in the data layer.
- **Presentation Layer**: Manages UI and user interaction using BLoC/Cubit for state management.
- **Core Module**: Includes shared constants, routing configuration, themes, utility functions, and dependency injection setup.

**State Management** is implemented using the **BLoC/Cubit pattern**, and **GoRouter** is used for navigation, ensuring a clean and scalable approach to routing.

---

## 📁 Directory Structure
```
lib/
├── core/                        # Shared configurations and utilities
│   ├── constants/               # Static strings, keys, and configuration values
│   ├── di/                      # Dependency Injection setup using get_it
│   ├── network/                 # GraphQL client, interceptors, and helpers
│   ├── observer/                # BlocObserver for logging state transitions
│   ├── routes/                  # go_router setup for navigation
│   ├── theme/                   # App-wide theming, colors, typography
│   └── utils/                   # Generic helper methods and extensions
│
├── features/
│   └── restaurant/              # Restaurant-specific logic
│       ├── data/                # DTOs, models, repository implementations, API services
│       ├── domain/              # Business logic: entities, repository contracts, use cases
│       └── presentation/        # UI layer: screens, widgets, BLoC/Cubit logic
│
└── main.dart                    # App bootstrap and root widget
```
---

## ✨ Features

### 🗂 Restaurant List Page

- Tab bar navigation:
  - ⭐ Favorites (stored locally using `hydrated_bloc`)
  - 🍽 All Restaurants (fetched via Yelp GraphQL API)
- Displays:
  - Hero image
  - Name, price, category
  - Rating (rounded)
  - Open/Closed status

### 🔍 Restaurant Detail Page

- Hero image with animation
- Name, rating, price, and category
- Full address
- List of user reviews:
  - Username
  - Avatar
  - Snippet of review text
- Ability to favorite/unfavorite restaurants

---

## 🧠 State Management

- `flutter_bloc`: For predictable and testable state handling
- `hydrated_bloc`: To persist favorites state locally
- `bloc_test`: For unit and state transition testing

The architecture promotes separation of concerns by handling business logic, events, and state within BLoCs and keeping widgets focused on rendering.

---

## 🌐 Routing & Navigation

- Uses `go_router` for structured, declarative routing
- Nested navigation and animated transitions supported
- Defined routes for list screen and detail screen with parameters

---

## ⚙️ Configuration & Setup
The project uses the Yelp GraphQL API. API key management is handled securely through environment variables using flutter_dotenv.

### `.env` File
YELP_API_KEY=your_api_key_here


### `config.dart`

```dart
const String yelpGraphQLUrl = "https://api.yelp.com/v3/graphql";
final String yelpApiKey = dotenv.env['YELP_API_KEY'] ?? "";
```


## 💪 Testing Strategy

Testing is a crucial aspect of this project to ensure its reliability, maintainability, and scalability. The following approach was taken to cover all layers of the app using appropriate test types.

### ✅ Test Types & Coverage

| Test Type         | Coverage Description                                                                 |
|------------------|----------------------------------------------------------------------------------------|
| **Unit Tests**    | Test business logic like blocs, use cases, and utility functions                     |
| **Widget Tests**  | Verify UI behavior of screens and widgets under different states                     |
| **Golden Tests**  | Snapshot testing of UI for visual regressions using `alchemist`                      |
| **Integration**   | Simulate complete user journeys and validate routing, state transitions, etc.        |

> ✅ **Focus**: Testing logic and visuals critical to app behavior over striving for 100% coverage

---

### 📁 `test/` Directory Structure
```
test/
├── golden_tests/        # UI snapshot testing with Alchemist
├── integration_tests/   # End-to-end flows and navigation
├── unit_tests/
│   ├── core/            # Utility and service testing
│   └── features/        # BLoC and business logic
└── widget_tests/
    └── screens/         # Widget behavior in screens
```

### 🔮 Testing Tools & Packages

- `flutter_test` – Built-in Flutter testing framework
- `mocktail` – Mocking dependencies in unit and widget tests
- `bloc_test` – State transition testing for blocs and cubits
- `integration_test` – Flutter's official integration testing library
- `alchemist` – Modern golden test runner with visual snapshot comparison

---

### 🎥 CI/CD Friendly

- Tests are deterministic and do not rely on external APIs.
- Yelp API calls are mocked using repository abstractions.
- Golden test images can be committed or compared in CI pipelines.

---

## 🛠️ Build & Environment Setup

### 🚀 Prerequisites

- Install [FVM](https://fvm.app/) (Flutter Version Manager)

```bash
dart pub global activate fvm
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

## Setup Project
```bash
fvm use           # Use the version defined in .fvm/fvm_config.json
fvm flutter pub get
```

## 🔑 Add Yelp API Key
In lib/core/constants/config.dart, the following code retrieves the API key:

```bash
final String yelpApiKey = dotenv.env['YELP_API_KEY'] ?? "";
```

## ▶️ Run the App
```bash
fvm flutter run
```

## 💪 Run Tests
```bash
# Run unit & widget tests
fvm flutter test

# Run integration tests
fvm flutter test integration_test

# Run golden tests 
fvm flutter test test/golden_tests
```

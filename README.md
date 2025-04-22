## Table of Contents
1. [Demo Video](#demo-video)
2. [Overview](#overview)
3. [Architecture Layers](#architecture-layers)
4. [State Management](#state-management)
5. [Data Flow](#data-flow)
6. [Key Components](#key-components)
7. [Testing Strategy](#testing-strategy)
8. [Best Practices](#best-practices)
9. [App Checklist](#app-checklist)

## Demo Video
### [![Watch the demo](https://i.postimg.cc/527qJmF4/Screenshot-2025-04-22-at-12-36-13-PM.png)](https://drive.google.com/file/d/1I26SSrV7Pu4GOLHFTkgRUoDCCDQ5KxQQ/view?usp=drive_link)


### Link: https://drive.google.com/file/d/1I26SSrV7Pu4GOLHFTkgRUoDCCDQ5KxQQ/view?usp=sharing


## Overview

RestauranTour is a Flutter application that allows users to browse restaurants, view details, and manage favorites. The app follows a clean architecture pattern with clear separation of concerns and uses Riverpod for state management.

## Architecture Layers

### 1. Presentation Layer (UI)
- Located in `lib/screens/` and `lib/components/`
- Handles UI rendering and user interactions
- Uses providers to access state and trigger actions
- Implements responsive design patterns

### 2. State Management Layer
- Located in `lib/providers/`
- Uses Riverpod for state management
- Key providers:
  - `restaurantsProvider`: Manages restaurant list state
  - `favoritesProvider`: Manages favorite restaurants state
  - `restaurantProvider`: Manages individual restaurant details

### 3. Domain Layer
- Located in `lib/models/`
- Contains business logic and data models
- Uses JSON serialization for data parsing
- Key models:
  - `Restaurant`: Core restaurant data model
  - `Category`: Restaurant category information
  - `Review`: Customer review data
  - `Location`: Restaurant location data

### 4. Data Layer
- Located in `lib/services/`
- Handles data operations and API communication
- Implements repository pattern
- Uses SharedPreferences for local storage

## State Management

The app uses Riverpod for state management with three main types of providers:

1. **StateNotifierProvider**
   ```dart
   final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Restaurant>>
   ```
   - Manages mutable state for favorites
   - Handles persistence with SharedPreferences

2. **FutureProvider**
   ```dart
   final restaurantsProvider = FutureProvider<RestaurantQueryResult?>
   ```
   - Handles async data fetching
   - Manages loading and error states

3. **Provider**
   ```dart
   final restaurantServiceProvider = Provider((ref) => RestaurantService())
   ```
   - Provides service instances
   - Manages dependencies

## Data Flow

1. **Restaurant List Flow**
   ```
   API Request → RestaurantService → restaurantsProvider → RestaurantListScreen
   ```

2. **Favorites Flow**
   ```
   User Action → favoritesProvider → SharedPreferences → UI Update
   ```

3. **Restaurant Details Flow**
   ```
   ID Selection → restaurantProvider → RestaurantDetailsScreen
   ```

## Key Components

### RestaurantCard
- Reusable component for displaying restaurant information
- Handles image loading with error states
- Displays restaurant status, rating, and favorite state

### Restaurant List Screen
- Implements tab navigation
- Handles sorting and filtering
- Manages list and grid view states

### Restaurant Details Screen
- Displays detailed restaurant information
- Manages favorite state
- Handles reviews and photos display

## Testing Strategy

1. **Unit Tests**
   - Located in `test/unit_tests/`
   - Tests service layer and business logic
   - Mocks external dependencies

2. **Widget Tests**
   - Located in `test/widget_tests/`
   - Tests UI components in isolation
   - Verifies component behavior

3. **Integration Tests**
   - Located in `test/integration_tests/`
   - Tests full user flows
   - Verifies app functionality

### Test Coverage
- Services: 80%+ coverage
- Widgets: Key components tested
- Integration: Critical paths covered

## Best Practices

1. **Error Handling**
   - Consistent error reporting
   - User-friendly error messages
   - Graceful degradation

2. **Performance**
   - Lazy loading of images
   - Efficient list rendering
   - State management optimization

3. **Code Style**
   - Follows Flutter style guide
   - Consistent naming conventions
   - Comprehensive documentation

## App Checklist

### Environment Setup

- [x] Install FVM (Flutter Version Manager)
- [x] Run `dart pub global activate fvm`
- [x] Add FVM to PATH variables if needed
- [x] Run `fvm use` to install project's Flutter version
- [x] Run `fvm flutter pub get` to download dependencies
- [x] Configure IDE (VSCode or IntelliJ/Android Studio)

### Yelp API Setup

- [x] Create a Yelp developer account
- [x] Create a new app on Yelp developer portal
- [x] Join the Developer Beta for GraphQL API access
- [x] Add API key to `yelp_repository.dart`
- [x] Test API connection

### App Structure & Architecture

- [x] Define clear architecture for scalability
- [x] Set up state management solution (choose one: provider, Riverpod, bloc, get_it/mixins, or Mobx)
- [x] Implement proper error handling
- [x] Handle optional values appropriately
- [x] Optimize widget tree
- [x] Document architecture decisions

### Restaurant List Page

- [x] Implement tab bar navigation
- [x] Create "Favorites" tab
- [x] Create "All Restaurants" tab
- [x] Display restaurant list items with:
  - [x] Hero image
  - [x] Name
  - [x] Price
  - [x] Category
  - [x] Rating (rounded to nearest value)
  - [x] Open/Closed status

### Restaurant Detail View

- [x] Implement favorite functionality
- [x] Display restaurant name
- [x] Display hero image
- [x] Show price and category
- [x] Show address
- [x] Display rating
- [x] Show total review count
- [x] Implement reviews list with:
  - [x] User name
  - [x] Rating
  - [x] User image
  - [x] Review text snippet

### Local Storage

- [x] Implement SharedPreferences for favorites storage
- [x] Create methods to add/remove favorites
- [x] Ensure favorites persist between app sessions

### Testing

- [x] Write unit tests for at least one file in each domain layer
- [x] Write widget tests for key components
- [x] Ensure tests cover critical functionality

### UI Implementation

- [x] Implement design from Figma file
- [x] Match visual elements to design specifications
- [x] Ensure responsive layout

### Code Quality

- [x] Follow best practices for Flutter development
- [x] Use clear and consistent naming conventions
- [x] Implement clean architecture principles
- [x] Write meaningful comments
- [x] Use logical commit messages (following Conventional Commits)

### Documentation

- [x] Create clear documentation on app structure
- [x] Document architectural decisions
- [x] Add setup instructions
- [x] Include information on testing approach

### Final Review

- [x] Test app on different screen sizes
- [x] Check error states and edge cases
- [x] Verify favorite functionality works correctly
- [x] Ensure API requests are properly handled
- [x] Review code for any improvements or optimizations
- [x] Prepare for code review and demo
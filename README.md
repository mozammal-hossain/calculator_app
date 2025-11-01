# Scientific Calculator App 

A modern, feature-rich scientific calculator application built with Flutter and Riverpod.

## Features

### Basic Calculator Mode
- Standard arithmetic operations (addition, subtraction, multiplication, division)
- Percentage calculations
- Decimal point support
- Clear and All Clear functions
- Backspace/Delete functionality
- Positive/negative toggle
- Display for input and result

### Scientific Calculator Mode
- Trigonometric functions (sine, cosine, tangent, arc sine, arc cosine, arc tangent)
- Logarithmic functions (log base 10, natural log)
- Exponential functions (e^x, 10^x)
- Power and root operations (square, cube, power of y, square root, cube root)
- Mathematical constants (π, e)
- Factorial operation
- Parentheses support for complex expressions
- Angle mode toggle (Degrees/Radians)

### Additional Features
- Calculation history with persistence
- Memory functions (M+, M-, MR, MC)
- Dark and Light theme support
- Copy result to clipboard
- Haptic feedback
- Portrait and landscape orientation support

## Technical Stack

- **Framework**: Flutter 3.6+
- **Language**: Dart
- **State Management**: Riverpod (flutter_riverpod)
- **Expression Parsing**: math_expressions
- **Local Storage**: shared_preferences
- **Typography**: google_fonts

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data structures and models
├── providers/               # Riverpod state providers
├── screens/                 # UI pages/screens
├── widgets/                 # Reusable UI components
├── utils/                   # Helper functions and constants
└── services/               # External integrations (storage, etc.)
```

## Getting Started

### Prerequisites
- Flutter SDK 3.6 or higher
- Dart SDK 3.0 or higher

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd calculator_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Development Phases

- [x] **Phase 1**: Project Setup - Dependencies and folder structure
- [ ] **Phase 2**: Basic Calculator Implementation
- [ ] **Phase 3**: Scientific Mode Implementation
- [ ] **Phase 4**: Additional Features (History, Themes, Settings)
- [ ] **Phase 5**: Testing & Polish
- [ ] **Phase 6**: Deployment

## Architecture

The application follows a clean architecture pattern with separation of concerns:

- **Models**: Data structures representing calculator state, history, and settings
- **Providers**: Riverpod StateNotifiers for managing application state
- **Screens**: Full-page UI components
- **Widgets**: Reusable UI components
- **Services**: Business logic and external integrations
- **Utils**: Helper functions, constants, and extensions

## State Management

The app uses Riverpod for state management with the following providers:
- Calculator State Provider - manages calculations and expressions
- Theme Provider - manages dark/light mode
- History Provider - manages calculation history
- Settings Provider - manages app settings (angle mode, etc.)

## Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test
```

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Riverpod for state management
- math_expressions package for expression parsing

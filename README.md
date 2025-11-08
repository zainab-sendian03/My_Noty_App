# 📝 NOTY APP

A modern, responsive note-taking application built with Flutter, following Clean Architecture principles and integrated with Firebase for authentication and data storage.

## ✨ Features

### 🔐 Authentication
- ✅ Email/Password authentication
- ✅ Google Sign-In integration
- ✅ User registration and login
- ✅ Secure session management
- ✅ Error handling with status code mapping

### 📋 Notes Management
- ✅ Add new notes
- 🚧 Edit notes (In Progress)
- 🚧 Delete notes (Coming Soon)
- 🚧 View notes list (Coming Soon)
- 🚧 Search notes (Coming Soon)

### 🎨 UI/UX
- ✅ Modern, responsive design
- ✅ Custom color theme system (Orange-based)
- ✅ Loading animations
- ✅ Smooth page transitions
- ✅ Material Design 3

### 🏗️ Architecture
- ✅ Clean Architecture pattern
- ✅ Separation of concerns (Data, Domain, Presentation layers)
- ✅ Repository pattern
- ✅ Use cases for business logic
- ✅ Dependency Injection with GetX

## 🛠️ Tech Stack

### Core Framework
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language (SDK >=3.3.4)

### State Management & Navigation
- **GetX** (^4.6.6) - State management, dependency injection, and routing

### Backend Services
- **Firebase Core** (^4.2.0) - Firebase initialization
- **Firebase Auth** (^6.1.1) - User authentication
- **Cloud Firestore** (^6.0.3) - NoSQL database
- **Firebase Storage** (^13.0.3) - File storage
- **Firebase Messaging** (^16.0.3) - Push notifications
- **Firebase App Check** (^0.4.1+1) - Security

### Authentication
- **Google Sign-In** (^6.2.2) - Google authentication

### Additional Packages
- **dartz** (^0.10.1) - Functional programming (Either, Option)
- **connectivity_plus** (^6.0.5) - Network connectivity
- **image_picker** (^1.0.7) - Image selection
- **google_fonts** (^6.2.1) - Custom fonts
- **loading_animation_widget** (^1.3.0) - Loading animations
- **device_preview** (^1.0.0) - Device preview for development

## 📁 Project Structure

```
lib/
├── config/              # App configuration
│   ├── routes/          # Route definitions
│   └── themes/          # Theme and colors
├── core/                # Core functionality
│   ├── connection/      # Network connectivity
│   ├── constants/       # App constants
│   ├── databases/       # Database abstractions
│   ├── di/              # Dependency injection
│   ├── errors/          # Error handling
│   └── params/          # Parameter classes
├── features/            # Feature modules
│   ├── auth/            # Authentication feature
│   │   ├── data/        # Data layer
│   │   ├── domain/      # Domain layer
│   │   └── presentation/# Presentation layer
│   ├── note/            # Notes feature
│   └── profile/         # Profile feature
└── view/                # Shared views
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.3.4)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/zainab-sendian03/noteApp_withResponsive-cleanArch.git
   cd noteApp_withResponsive-cleanArch
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` to `android/app/`
   - Configure iOS Firebase setup
   - Update Firebase configuration in `lib/main.dart` if needed

4. **Run the app**
   ```bash
   flutter run
   ```

### Generate App Icons
```bash
dart run flutter_launcher_icons
```

## 🎨 Color Theme

The app uses a custom orange-based color scheme:
- **Primary Color**: RGB(235, 142, 2) - `#EB8E02`
- **Primary Variant**: RGB(200, 120, 2) - Darker orange
- **Secondary**: Coral red tones
- Full theme system supports both light and dark modes

## 📱 Screenshots

_Add screenshots of your app here_

## 🔄 Current Status

### ✅ Completed
- Authentication system (Email/Password & Google)
- User registration and login
- Add notes functionality
- Clean architecture implementation
- Error handling system
- Theme system

### 🚧 In Progress
- Notes CRUD operations
- Profile management

### 📋 Planned Features
- Edit and delete notes
- Notes search and filtering
- Categories/Tags for notes
- Rich text editor
- Image attachments
- Offline support
- Push notifications
- Dark mode toggle
- Profile customization

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👤 Author

**Zainab Sendian**
- GitHub: [@zainab-sendian03](https://github.com/zainab-sendian03)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All package maintainers

---

**Note**: This project is actively under development. Features marked as "Coming Soon" or "In Progress" are being worked on.

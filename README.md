# Traguard

The application of activity tracking and geolocation for the Traguard project.

Made with Flutter and ❤️ by [Dario Varriale](https://www.linkedin.com/in/dario-varriale/)

## Installation & Setup

This application uses `FVM` to manage Flutter versions. 

1. Install `FVM` globally using `pub`:

```bash
dart pub global activate fvm
```

2. Install the Flutter SDK using `FVM`:

```bash
fvm install
```

This will create a `.fvm` directory in the root of your project, which contains the correct Flutter SDK.

3. Get the dependencies:

```bash
fvm flutter pub get
```

4. Generate source code files using `build_runner`:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

5. Run the application:

```bash
fvm flutter run
```
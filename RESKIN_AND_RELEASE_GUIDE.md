# Skillora LMS Complete Package — Reskin & Release Guide

Welcome to the comprehensive, project-specific Reskin and Release Guide for **Skillora LMS Complete Package** (featuring both the **Student Learning App** and the **Skillora Instructor Studio App**).

---

## 1. Replacing App Icons (Both Apps)

Both apps use `flutter_launcher_icons` to generate all native Android mipmaps and iOS app icon assets automatically.

### Student App Icon:
1. Prepare a square PNG logo (recommended: **1024 x 1024 px**).
2. Replace: `Student_App/assets/images/app_logo.png`.
3. Open terminal in `Student_App` and run:
   ```bash
   flutter pub get
   dart run flutter_launcher_icons
   ```

### Instructor Studio App Icon:
1. Prepare a square PNG logo (recommended: **1024 x 1024 px**).
2. Replace: `Instructor_App/assets/images/app_logo.png`.
3. Open terminal in `Instructor_App` and run:
   ```bash
   flutter pub get
   dart run flutter_launcher_icons
   ```

---

## 2. Replacing Splash Screens & Visual Assets

Skillora features a 2-stage splash sequence: native OS launch drawables followed by an animated Flutter splash screen.

### In-App Animated Flutter Splash:
Replace the following assets in `Student_App/assets/images/` and `Instructor_App/assets/images/`:
* `splash_one.png` (1080 x 2400 px) — Primary wallpaper.
* `splash_two.png` (1080 x 2400 px) — Secondary transition wallpaper.
* `logo_green.png` (600 x 300 px) — Dark-contrast brand logo with horizontal typography.
* `logo_white.png` (600 x 300 px) — White monochrome logo for dark mode.

### Native Android Launch Splash:
* Open `android/app/src/main/res/drawable/launch_background.xml` in either app.
* Set your background color in `<item android:drawable="@android:color/white" />` or uncomment the centered bitmap.

### Native iOS Launch Screen:
* Open `ios/Runner.xcworkspace` in Xcode.
* Navigate to `Runner > Base.lproj > LaunchScreen.storyboard` to adjust colors or replace `LaunchImage.imageset` in `Assets.xcassets`.

### Onboarding & Illustration Assets:
Replace images in `assets/images/`:
* `intro_one.png`, `intro_two.png`, `intro_three.png` (600 x 600 px) — Onboarding slides.
* `course_one.png`, `course_two.png`, `course_three.png` (800 x 500 px) — Default course thumbnails.
* `mentor_one.png` (400 x 400 px) — Instructor avatar mockup.

---

## 3. Brand Colors & Theme Customization

To change colors, edit `lib/utilities/app_colors.dart` in both apps:
```dart
class AppColors {
  static const Color primaryColor = Color(0xffEA580C); // Replace with your brand hex
  static const Color black = Color(0xff1C1917);
  static const Color bgColorWhite = Color(0xffFAF8F5);
  static const Color gold = Color(0xffD4AF37); // Accent badge & certificate color
}
```

---

## 4. White-Labeling (App Name & Package IDs)

### Change Android Application ID:
* **Student_App:** In `Student_App/android/app/build.gradle`:
  ```groovy
  defaultConfig {
      applicationId "com.yourcompany.skillorastudent"
  }
  ```
* **Instructor_App:** In `Instructor_App/android/app/build.gradle.kts`:
  ```kotlin
  defaultConfig {
      applicationId = "com.yourcompany.skillorainstructor"
  }
  ```

### Change iOS Bundle Identifier:
* Open `ios/Runner.xcworkspace` in Xcode.
* Select **Runner > Targets > Runner > Signing & Capabilities** and update **Bundle Identifier**:
  * Student: `com.yourcompany.skillorastudent`
  * Instructor: `com.yourcompany.skillorainstructor`

### Change App Display Name:
* **Android:** Edit `android/app/src/main/AndroidManifest.xml` &rarr; `android:label="Your App Name"`.
* **iOS:** Edit `ios/Runner/Info.plist` &rarr; `<key>CFBundleDisplayName</key><string>Your App Name</string>`.

---

## 5. Stripe Payments & Currency Configuration

In `Student_App/lib/utilities/app_constants.dart`:
```dart
class AppConstants {
  static String currencySymbol = '\$';
  static String currencyCode = "USD";
  static String merchantCountryCode = 'US';
  static String merchantDisplayName = 'Your Academy';
  static String stripePublishableKey = 'pk_live_your_stripe_key';
}
```

---

## 6. Android Release Signing Configuration

### Step 1: Generate Upload Keystore
In terminal:
```bash
# macOS / Linux
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Windows PowerShell
keytool -genkey -v -keystore "$env:USERPROFILE\upload-keystore.jks" -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### Step 2: Create `key.properties`
Create `key.properties` inside `Student_App/android/` and `Instructor_App/android/`:
```properties
storePassword=YourKeystorePasswordHere
keyPassword=YourKeyPasswordHere
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

### Step 3: Configure Student_App/android/app/build.gradle (Groovy DSL)
```groovy
import java.io.FileInputStream
import java.util.Properties

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled false
            shrinkResources false
        }
    }
}
```

### Step 4: Configure Instructor_App/android/app/build.gradle.kts (Kotlin DSL)
```kotlin
import java.io.FileInputStream
import java.util.Properties

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
```

### Step 5: Build Release Binaries
```bash
# Build Google Play AppBundle
flutter build appbundle --release

# Build Release APK
flutter build apk --release
```

---

## 7. iOS Team & Provisioning Setup

1. Open `ios/Runner.xcworkspace` in Xcode.
2. In Project Navigator, click the top **Runner** project.
3. Select the **Runner** target &rarr; click **Signing & Capabilities** tab.
4. Check **"Automatically manage signing"**.
5. Select your registered **Apple Developer Team** from the Team dropdown.
6. Verify your **Bundle Identifier**. Xcode will automatically manage provisioning profiles and signing certificates.
7. To build:
   ```bash
   flutter build ipa --release
   ```
8. In Xcode, open **Window &rarr; Organizer** &rarr; click **Distribute App** to upload directly to App Store Connect / TestFlight.

---

## 8. Interactive HTML Documentation

For the complete interactive experience with live search, code copying, and visual guides, open:
`Documentation/index.html` in any web browser.

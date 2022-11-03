# instagram_clone_flutter_firebase

add your firebase web keys in `lib\utils\firebaseOptionsWeb.dart`

```dart
// lib/utils/firebaseOptionsWeb.dart
import 'package:firebase_core/firebase_core.dart';
FirebaseOptions firebaseOptionsWeb = const FirebaseOptions(
    apiKey: "",
    appId: "",
    messagingSenderId: "",
    projectId: "",
    storageBucket: "",
    authDomain: "",
    measurementId: "");
```

add GoogleService-Info.plist in `ios\Runner\GoogleService-Info.plist`
add google-services.json in `android\app\google-services.json`

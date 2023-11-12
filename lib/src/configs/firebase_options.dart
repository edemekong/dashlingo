import 'package:dashlingo/src/configs/app_config.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions currentPlatform(AppFlavor flavor) {
    return flavor == AppFlavor.dev ? _webDev : _webProd;
  }

  static const FirebaseOptions _webProd = FirebaseOptions(
    apiKey: "AIzaSyBT3BSvbOuzJBO-jmAols2hf_YKKGuvtwA",
    authDomain: "dashlingoo.firebaseapp.com",
    projectId: "dashlingoo",
    storageBucket: "dashlingoo.appspot.com",
    messagingSenderId: "1006500015865",
    appId: "1:1006500015865:web:866bdb886d339424907c28",
    measurementId: "G-0D8R9BG6C0",
  );

  static const FirebaseOptions _webDev = FirebaseOptions(
    apiKey: "AIzaSyDJnknDDfZL87yaG37T2_DeeIpJ8BVhDh4",
    authDomain: "dashlingo-test.firebaseapp.com",
    projectId: "dashlingo-test",
    storageBucket: "dashlingo-test.appspot.com",
    messagingSenderId: "70893004989",
    appId: "1:70893004989:web:8ceaf062cc9967ba4cafd4",
    measurementId: "G-W1BLVMVYF8",
  );
}

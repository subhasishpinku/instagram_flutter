import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

// npm install firebase
// Then, initialise Firebase and begin using the SDKs for the products that you'd like to use.

// // Import the functions you need from the SDKs you need
// import { initializeApp } from "firebase/app";
// // TODO: Add SDKs for Firebase products that you want to use
// // https://firebase.google.com/docs/web/setup#available-libraries

// // Your web app's Firebase configuration
// const firebaseConfig = {
//   apiKey: "AIzaSyCwwEjRJv0WnwQHPxvqwQtcZcKusq-Rr6k",
//   authDomain: "instagram-tut-68e1f.firebaseapp.com",
//   databaseURL: "https://instagram-tut-68e1f-default-rtdb.firebaseio.com",
//   projectId: "instagram-tut-68e1f",
//   storageBucket: "instagram-tut-68e1f.firebasestorage.app",
//   messagingSenderId: "981153187729",
//   appId: "1:981153187729:web:619dc7757c961209f03c30"
// };

// // Initialize Firebase
// const app = initializeApp(firebaseConfig);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCwwEjRJv0WnwQHPxvqwQtcZcKusq-Rr6k',
            appId: '1:981153187729:web:619dc7757c961209f03c30',
            messagingSenderId: '981153187729',
            projectId: 'instagram-tut-68e1f',
            storageBucket: 'instagram-tut-68e1f.firebasestorage.app'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instagram Clone',
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          // home: const Scaffold(
          //   body: ResponsiveRayout(
          //       webScreenLayout: WebScreenLayout(),
          //       mobileScreenLayout: MobileScreenLayout()),
          // ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const ResponsiveRayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                return const LoginScreen();
              })),
    );
  }
}

//flutter run -d chrome --web-renderer html

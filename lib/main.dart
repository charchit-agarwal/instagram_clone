import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/responsive_screen_layout.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // ignore: await_only_futures
    await const FirebaseOptions(
      apiKey: "AIzaSyDKUq0kPLxNvW0yLRR1QiCpvM5G5PYZ-y8",
      appId: "1:766740284578:web:ed92660b96e160fa4043fb",
      projectId: "instagram-clone-bb0d2",
      storageBucket: "instagram-clone-bb0d2.appspot.com",
      messagingSenderId: "766740284578",
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: const ResponsiveScreen());
  }
}

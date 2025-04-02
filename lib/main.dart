import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sezin_scp/providers/user_provider.dart';
// import 'package:sezin_scp/screens/android/android_first_password.dart';
// import 'package:sezin_scp/screens/android/android_homepage.dart';
import 'package:sezin_scp/screens/android/android_login.dart';
// import 'package:sezin_scp/screens/homepage.dart';
// import 'package:sezin_scp/screens/ios/ios_homepage.dart';
import 'package:sezin_scp/screens/ios/ios_login.dart';
import 'dart:io' show Platform;

import 'package:sezin_scp/screens/test.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //BB2121
  //F07e19 const Color(0xFFBB2121),

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sezin Tıp SCP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.primary),
            titleTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black)),
      ),
      // home: Platform.isIOS ? IosLoginPage() : AndroidLoginPage(),
      home: FunnyImageScreen(), // home: AndroidFirstPassword(),
    );
  }
}

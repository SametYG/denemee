import 'package:flutter/material.dart';
import 'package:sezin_scp/resources/user_login.dart';
import 'package:sezin_scp/utils/page_paddings.dart';

class MainHomepage extends StatelessWidget {
  const MainHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sezin Online",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: PagePaddings().homePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                fetchUserData("sametyigit.gunay@sezintip.com", "Sametyg.123");
              }, child: const Text("TEST"))
            ],
          ),
        ),
      ),
    );
  }
}

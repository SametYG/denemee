// import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sezin_scp/providers/user_provider.dart';

class PersonView extends StatelessWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kişisel",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const LittleSize(),
        const BigGradientDivider(),
        const LittleSize(),
        Text(
          "Kullanıcı Adı Soyadı",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black, // Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500, // uı tasarla personal screen
              ),
        ),
        Text(
          "${_userProvider.user!.userName} ${_userProvider.user!.userSurname}",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
        ),
        const LittleSize(),
        const LittleGradientDivider(),
        const LittleSize(),
        Text(
          "Kullanıcı Mail Adresi",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black, 
                fontWeight: FontWeight.w500, 
              ),
        ),
        Text(
          _userProvider.user!.userEmail,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey,
                fontWeight: FontWeight.w400,
              ),
        ),
                const LittleSize(),
        const LittleGradientDivider(),
        const LittleSize(),
        Text(
          "Kullanıcı Aktiflik",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500, 
              ),
        ),
        Text(
          _userProvider.user!.userIsActive ? "Kullanıcı Aktif" : "Kullanıcı Aktif Değil",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: _userProvider.user!.userIsActive ? Colors.green : Colors.red,
                fontWeight: FontWeight.w400,
              ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {},
              label: const Text("Çıkış"),
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class LittleGradientDivider extends StatelessWidget {
  const LittleGradientDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.orange, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ).createShader(bounds),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: const Divider(
          color: Colors.white,
          thickness: 3,
        ),
      ),
    );
  }
}

class BigGradientDivider extends StatelessWidget {
  const BigGradientDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.orange, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ).createShader(bounds),
      child: const Divider(
        color: Colors.white,
        thickness: 3,
      ),
    );
  }
}

class LittleSize extends StatelessWidget {
  const LittleSize({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 5,
    );
  }
}

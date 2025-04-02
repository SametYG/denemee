// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sezin_scp/providers/user_provider.dart';
import 'package:sezin_scp/resources/secure_preferences.dart';
import 'package:sezin_scp/screens/ios/ios_first_password.dart';
import 'package:sezin_scp/screens/ios/ios_homepage.dart';
import 'package:sezin_scp/utils/page_paddings.dart';
import 'package:sezin_scp/widgets/ios_textfield_input.dart';

class IosLoginPage extends StatefulWidget {
  const IosLoginPage({super.key});

  @override
  State<IosLoginPage> createState() => _IosLoginPageState();
}

class _IosLoginPageState extends State<IosLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SecurePreferences _securePreferences = SecurePreferences();

  bool _isRemember = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    String? savedData = await SecurePreferences.getEncryptedData("remember_me");
    if (savedData != null) {
      setState(() {
        _isRemember = savedData.toLowerCase() == "true";
      });
    }
  }

  Future<void> _saveRememberMe(bool value) async {
    await SecurePreferences.saveEncryptedData("remember_me", value.toString());
  }

  void _rememberButton() {
    setState(() {
      _isRemember = !_isRemember;
      _saveRememberMe(_isRemember);
    });
  }

  void _loginButton(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.fetchUser(
        _emailController.text, _passwordController.text);

    if (userProvider.errormessage == null && userProvider.user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => userProvider.user!.userIsFirstLogin == true
              ? const IosFirstPassword()
              : const IosHomepage()));
    } else if (userProvider.errormessage != null) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Bir Sorun Oluştu"),
            content: Text(userProvider.errormessage!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Tamam"),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   // title: Text("Sezin", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
      //   backgroundColor: Colors.transparent,
      // ),
      body: SafeArea(
        child: Padding(
          padding: PagePaddings().homePadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Spacer(
                //   flex: 1,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Image.asset(
                  "assets/sezin_logo.png",
                  height: 64,
                ),
                const SizedBox(
                  height: 30,
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ).createShader(bounds),
                  child: Text(
                    "Sezin Tıbbi Görüntüleme",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    "Mobil İşlem Platformu",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                IosTextfieldInput(
                  textEditingController: _emailController,
                  isPass: false,
                  hinText: "Lütfen mail adresinizi giriniz",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                IosTextfieldInput(
                  textEditingController: _passwordController,
                  isPass: true,
                  hinText: "Lütfen şifrenizi giriniz",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Beni Hatırla",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Checkbox(
                      value: _isRemember,
                      onChanged: (_) {
                        _rememberButton();
                      },
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      _rememberButton();
                    },
                    child: const Text(
                      "Şifrenizi mi unuttunuz",
                    )),
                const SizedBox(
                  height: 30,
                ),
                CupertinoButton.filled(
                  child: userProvider.isLoading
                      ? const CupertinoActivityIndicator()
                      : const Text("Giriş"),
                  onPressed: () {
                    _loginButton(context);
                    // _loginButton();
                  },
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // userProvider.user != null
                //     ? Column(
                //         children: [
                //           Text("Hoşgeldiniz: ${userProvider.user!.userName}"),
                //           Text(
                //               "Token Bilgileri: ${userProvider.user!.accessToken}"),
                //         ],
                //       )
                //     : const Text("Henüz Giriş Yapılmadı"),
                // const Spacer(
                //   flex: 2,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

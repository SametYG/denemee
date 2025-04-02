import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sezin_scp/providers/user_provider.dart';
// import 'package:sezin_scp/resources/user_login.dart';
import 'package:sezin_scp/screens/android/android_first_password.dart';
import 'package:sezin_scp/screens/android/android_homepage.dart';
import 'package:sezin_scp/utils/page_paddings.dart';
import 'package:sezin_scp/widgets/android_textfield_input.dart';

class AndroidLoginPage extends StatefulWidget {
  const AndroidLoginPage({super.key});

  @override
  State<AndroidLoginPage> createState() => _AndroidLoginPageState();
}

class _AndroidLoginPageState extends State<AndroidLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isRemember = false;

  void _rememberButton() {
    setState(() {
      print("değer değiştiriliyor");
      _isRemember = !_isRemember;
      print("değer değiştirildi");
      print("değişen değer:  $_isRemember");
    });
  }

  void _loginButton(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.fetchUser(
        _emailController.text, _passwordController.text);

    if (userProvider.errormessage == null && userProvider.user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => userProvider.user!.userIsFirstLogin == true
              ? const AndroidFirstPassword()
              : const AndroidHomepage()));
    } else if (userProvider.errormessage != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Bir Sorun Oluştu"),
            content: Text(userProvider.errormessage!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // title: const Text("Sezin Tıp SCP"),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: PagePaddings().homePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
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
                  end: Alignment.topRight,
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
              AndroidTextfieldInput(
                  textEditingController: _emailController,
                  hinText: "Lütfen mail adresinizi giriniz",
                  isPass: false,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 15,
              ),
              AndroidTextfieldInput(
                textEditingController: _passwordController,
                hinText: "Lütfen şifrenizi giriniz",
                isPass: true,
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
                  onPressed: () {},
                  child: const Text("Şifrenizi mi unuttunuz?")),
              const SizedBox(
                height: 30,
              ),
              FilledButton(
                  child: userProvider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Giriş"),
                  onPressed: () {
                    // fetchUserData(_test.text, _test2.text);
                    _loginButton(context);
                  }),
              // const SizedBox(
              //   height: 20,
              // ),
              // _userProvider.user != null
              //     ? Column(
              //         children: [
              //           Text("Hoşgeldiniz: ${_userProvider.user!.userName}"),
              //           Text(
              //               "Token Bilgileri: ${_userProvider.user!.accessToken}"),
              //         ],
              //       )
              //     : const Text("Henüz Giriş Yapılmadı"),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

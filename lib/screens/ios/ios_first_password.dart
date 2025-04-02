import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sezin_scp/providers/user_provider.dart';
import 'package:sezin_scp/screens/ios/ios_homepage.dart';
import 'package:sezin_scp/screens/ios/ios_login.dart';
import 'package:sezin_scp/utils/page_paddings.dart';
import 'package:sezin_scp/widgets/ios_textfield_input.dart';

class IosFirstPassword extends StatefulWidget {
  const IosFirstPassword({super.key});

  @override
  State<IosFirstPassword> createState() => _IosFirstPasswordState();
}

class _IosFirstPasswordState extends State<IosFirstPassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordCheckController =
      TextEditingController();

  void _changePassword(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.changeFirstPassword(
        _oldPasswordController.text,
        _newPasswordController.text,
        _newPasswordCheckController.text,
        userProvider.user!.accessToken);

    if (userProvider.passwordErrorMessage == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IosHomepage()));
    } else if (userProvider.passwordErrorMessage != null) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Bir Sorun Oluştu"),
            content: Text(userProvider.passwordErrorMessage!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
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
    final _userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => IosLoginPage()));
          },
          icon: const Icon(CupertinoIcons.back),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: PagePaddings().homePadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Image.asset(
                  "assets/sezin_logo.png",
                  height: 64,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Sezin Online'a Hoşgeldiniz",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Lütfen tek kullanımlık şifrenizi değiştirerek şifre oluşturun.",
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "* Lütfen 8-16 karakter arası bir şifre belirleyiniz.\n * En az bir özel karakter içermelidir.\n * En az bir büyük harf içermelidir.",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 30,
                ),
                IosTextfieldInput(
                  textEditingController: _oldPasswordController,
                  isPass: false,
                  hinText: "Lütfen mevcut şifrenizi giriniz",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                IosTextfieldInput(
                  textEditingController: _newPasswordController,
                  isPass: false,
                  hinText: "Lütfen şifrenizi oluşturunuz",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                IosTextfieldInput(
                  textEditingController: _newPasswordCheckController,
                  isPass: false,
                  hinText: "Lütfen şifrenizi doğrulayınız",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 30,
                ),
                CupertinoButton.filled(
                  child: _userProvider.isPasswordLoading
                      ? const CupertinoActivityIndicator()
                      : const Text("Giriş"),
                  onPressed: () {
                    _changePassword(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

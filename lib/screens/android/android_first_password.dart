import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sezin_scp/providers/user_provider.dart';
import 'package:sezin_scp/screens/android/android_homepage.dart';
import 'package:sezin_scp/screens/android/android_login.dart';
import 'package:sezin_scp/utils/page_paddings.dart';
import 'package:sezin_scp/widgets/android_textfield_input.dart';

class AndroidFirstPassword extends StatefulWidget {
  const AndroidFirstPassword({super.key});

  @override
  State<AndroidFirstPassword> createState() => _AndroidFirstPasswordState();
}

class _AndroidFirstPasswordState extends State<AndroidFirstPassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordCheckController =
      TextEditingController();

  //backend kodlarını bitir ios kodlarını da bitir modelsiz yapılıyorsa sorun yok
  //succes durumuna model yazmaya gerek yok tek cümle için ilerleyen zamanlarda eklenir en kötü model süreç uzamasın aynıişlevi yapıyor
  //android bu tarafı bitir backend de bitir yönlendirmeleri de bitir android anasayfaya hazır hale gelsin
  //ios da firstchangepasswordbitir anasayfaya hazır hale gelsin
  //mümkünse anasayfaya ufaktan giriş yap
  //çok vakit almayacaksa reset password şifremi unuttum için ayrı providerler oluşturulabilir

  void _changePassword(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.changeFirstPassword(
        _oldPasswordController.text,
        _newPasswordController.text,
        _newPasswordCheckController.text,
        userProvider.user!.accessToken);

    // if (userProvider.isPasswordSucces != false &&
    if (userProvider.passwordErrorMessage == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AndroidHomepage()));
    } else if (userProvider.passwordErrorMessage != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Bir Sorun Oluştu"),
            content: Text(userProvider.passwordErrorMessage!),
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
    final _userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AndroidLoginPage()));
            },
            icon: const Icon(Icons.arrow_back)),
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
            AndroidTextfieldInput(
              textEditingController: _oldPasswordController,
              isPass: false,
              hinText: "Lütfen mevcut şifrenizi giriniz",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ),
            AndroidTextfieldInput(
              textEditingController: _newPasswordController,
              isPass: false,
              hinText: "Lütfen şifrenizi oluşturunuz",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ),
            AndroidTextfieldInput(
              textEditingController: _newPasswordCheckController,
              isPass: false,
              hinText: "Lütfen şifrenizi doğrulayınız",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 30,
            ),
            FilledButton.icon(
              onPressed: () {
                _changePassword(context);
              },
              label: _userProvider.isPasswordLoading
                  ? const CircularProgressIndicator()
                  : const Text("Kaydet ve İlerle"),
              icon: const Icon(Icons.save),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // _userProvider.passwordErrorMessage != null
            //     ? Text(_userProvider.passwordErrorMessage!)
            //     : const Text("Henüz mesaj gelmedi"),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      )),
    );
  }
}

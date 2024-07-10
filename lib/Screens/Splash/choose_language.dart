import 'package:beauty_wider/Core/app_imports.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});
  @override
  Widget build(BuildContext context) {
    void changeLanguage(String language) async {
      await Provider.of<LocalLanguageProvider>(context, listen: false)
          .setLocale(Locale(language));
      PageNavigator(ctx: context).nextPage(page: const SignInScreen());
    }

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: WSizes.paddingWithHorizontal.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 182.v),
            Image.asset("assets/images/beauty_wider_logo.png",
                height: 192.v, width: 192.h),
            SizedBox(height: WSizes.xs.v),
            Text("Choose your language",
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(
              height: 2.v,
            ),
            Text("اختر لغتك",
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 40.v),
            ElevatedButton(
              onPressed: () async {
                changeLanguage('en');
              },
              child: const Text('English'),
            ),
            SizedBox(height: 18.v),
            ElevatedButton(
              onPressed: () async {
                changeLanguage('ar');
              },
              child: const Text('العربية'),
            ),
          ],
        ),
      ),
    );
  }
}

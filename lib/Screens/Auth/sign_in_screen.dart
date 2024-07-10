// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  String _userCountryCode = '961';
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumber.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signIn),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 32.v),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomImageView(
                  imagePath: "assets/images/beauty_wider_logo.png",
                  height: 159.v,
                  width: 254.h,
                ),
                SizedBox(height: 37.v),
                SizedBox(
                  height: 70.v,
                  width: 300.h,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          '${AppLocalizations.of(context)!.welcome}!',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          AppLocalizations.of(context)!.signInToContinue,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.v),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLocalizations.of(context)!.phoneNumber,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                SizedBox(height: 6.v),
                Container(
                  height: WSizes.containerFieldHeight.v,
                  width: double.maxFinite,
                  decoration: WBoxDecoration.containerFieldDecoration,
                  child: Row(
                    children: [
                      CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          _userCountryCode = countryCode.dialCode
                          !.replaceFirst('+', '');
                        },
                        initialSelection: 'LB',
                        favorite: const ['+961'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                      ),
                      SizedBox(
                        height: 50.v,
                        width: 200.h,
                        child: TextFormField(
                          controller: _phoneNumber,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '03 123 456',
                            contentPadding: EdgeInsets.symmetric(vertical: 5.v),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.pleaseEnterYourPhoneNumber;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.v),
                PasswordInputWidget(
                    title: AppLocalizations.of(context)!.password,
                    message: AppLocalizations.of(context)!.pleaseEnterAPassword,
                    password: _password
                ),
                SizedBox(height: 32.v),
                Consumer<AuthenticationProvider>(
                    builder: (context, auth, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showSnackMessage(
                              message: auth.resMessage, context: context);
                          auth.clear();
                        }
                      });
                      return auth.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            auth.loginUser(
                                userCountryCode: _userCountryCode,
                                userPhoneNumber: _phoneNumber.text.trim(),
                                userPassword: _password.text.trim(),
                                context: context);
                          }
                        },
                        child: Text(
                            AppLocalizations.of(context)!.signIn
                        ),
                      );
                    }),
                SizedBox(height: 16.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.dontHaveAnAccount,
                        style: Theme.of(context).textTheme.bodyMedium),
                    InkWell(
                      onTap: () {
                        PageNavigator(ctx: context).nextPage(page: const SignUpScreen());
                      },
                      child: Center(
                        child: Text(
                            ' ${AppLocalizations.of(context)!.signUp}',
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
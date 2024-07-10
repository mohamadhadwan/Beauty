import 'package:beauty_wider/Core/app_imports.dart';
import 'package:beauty_wider/core/app_imports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String _countryCode = '961';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstName.clear();
    _lastName.clear();
    _phoneNumber.clear();
    _password.clear();
    _confirmPassword.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signUp),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 2.v),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                          AppLocalizations.of(context)!.signUpToContinue,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 52.v),
                InputWidget(
                    name: _firstName,
                    title: AppLocalizations.of(context)!.firstName,
                    message:
                        AppLocalizations.of(context)!.pleaseEnterYourFirstName),
                SizedBox(height: 10.v),
                InputWidget(
                    name: _lastName,
                    title: AppLocalizations.of(context)!.lastName,
                    message:
                        AppLocalizations.of(context)!.pleaseEnterYourLastName),
                SizedBox(height: 10.v),
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
                          _countryCode =
                              countryCode.dialCode!.replaceFirst('+', '');
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
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourPhoneNumber;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.v),
                PasswordInputWidget(
                  title: AppLocalizations.of(context)!.password,
                  message: AppLocalizations.of(context)!.pleaseEnterAPassword,
                  password: _password,
                ),
                SizedBox(height: 10.v),
                PasswordInputWidget(
                  title: AppLocalizations.of(context)!.confirmPassword,
                  message: AppLocalizations.of(context)!.passwordsDoNotMatch,
                  password: _confirmPassword,
                  passwordToCompare: _password,
                ),
                SizedBox(height: 24.v),
                Consumer<AuthenticationProvider>(
                    builder: (context, auth, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (auth.resMessage != '') {
                      showSnackMessage(message: auth.resMessage, context: context);
                      auth.clear();
                    }
                  });
                  return auth.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              auth.registerUser(
                                  userFirstName: _firstName.text.trim(),
                                  userLastName: _lastName.text.trim(),
                                  userCountryCode: _countryCode,
                                  userPhoneNumber: _phoneNumber.text.trim(),
                                  userPassword: _password.text.trim(),
                                  context: context);
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.signUp),
                        );
                }),
                SizedBox(height: 14.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.alreadyHaveAnAccount,
                        style: Theme.of(context).textTheme.bodyMedium),
                    InkWell(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const SignInScreen());
                      },
                      child: Text(' ${AppLocalizations.of(context)!.signIn}',
                          style: Theme.of(context).textTheme.titleLarge),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

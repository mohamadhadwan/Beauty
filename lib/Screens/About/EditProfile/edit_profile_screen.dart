import 'package:beauty_wider/Core/app_imports.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _birthdate = TextEditingController();
  final TextEditingController _gender = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    _firstName.clear();
    _lastName.clear();
    _email.clear();
    _birthdate.clear();
    _gender.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editProfile),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (profile.resMessage != '') {
              showSnackMessage(message: profile.resMessage, context: context);
              profile.clear();
            }
          });
          return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 32.v),
                children: [
                  Image.asset(
                    "assets/images/user_icon.png",
                    height: 129.v,
                    width: 129.h,
                    color: WColors.primary,
                  ),
                  SizedBox(height: 40.v),
                  InputWidget(
                      name: _firstName,
                      title: AppLocalizations.of(context)!.firstName,
                      message: AppLocalizations.of(context)!
                          .pleaseEnterYourFirstName),
                  SizedBox(height: 10.v),
                  InputWidget(
                      name: _lastName,
                      title: AppLocalizations.of(context)!.lastName,
                      message: AppLocalizations.of(context)!
                          .pleaseEnterYourLastName),
                  SizedBox(height: 10.v),
                  InputWidget(
                      name: _email,
                      title: AppLocalizations.of(context)!.email,
                      message:
                          AppLocalizations.of(context)!.pleaseEnterYourEmail),
                  SizedBox(height: 10.v),
                  BirthdateInputWidget(context: context, birthdate: _birthdate),
                  SizedBox(height: 10.v),
                  GenderInputWidget(context: context, gender: _gender),
                  SizedBox(height: 50.v),
                  profile.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              profile.updateUserProfile(
                                  firstName: _firstName.text.trim(),
                                  lastName: _lastName.text.trim(),
                                  email: _email.text.trim(),
                                  birthdate: _birthdate.text.trim(),
                                  gender: _gender.text.trim(),
                                  context: context);
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.save)),
                  SizedBox(height: 10.v),
                ],
              ));
        },
      ),
    );
  }
}
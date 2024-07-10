import 'package:beauty_wider/Core/app_imports.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.about),
      ),
      body: Consumer<AuthenticationProvider>(
        builder: (context, auth, child) {
          if(auth.isLoading) return const Center(child: CircularProgressIndicator());
          return Column(
            children: [
              ContainerTapWidget(
                  context: context,
                  text: AppLocalizations.of(context)!.myProfile,
                  icon: Icons.person,
                  onTapAction: () => PageNavigator(ctx: context)
                      .nextPage(page: const MyProfileScreen())),
              ContainerTapWidget(
                  context: context,
                  text: AppLocalizations.of(context)!.about,
                  icon: Icons.info_rounded,
                  onTapAction: () {}),
              ContainerTapWidget(
                  context: context,
                  text: AppLocalizations.of(context)!.changeLanguage,
                  icon: Icons.language_outlined,
                  onTapAction: () => auth.changeAppLanguage(context: context)),
              ContainerTapWidget(
                  context: context,
                  text: AppLocalizations.of(context)!.logout,
                  icon: Icons.logout_outlined,
                  onTapAction: () => auth.logoutUser(context: context)),
            ],
          );
        },
      ),
    );
  }
}
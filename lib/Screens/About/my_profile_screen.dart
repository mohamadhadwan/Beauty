import 'package:beauty_wider/Core/app_imports.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  MyProfileScreenState createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ProfileProvider>(context, listen: false).getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myProfile),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 23.h,
              vertical: 32.v,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/user_icon.png',
                  height: 129.v,
                  width: 129.h,
                  color: WColors.primary,
                ),
                SizedBox(height: 10.v),
                Text(
                  '${profile.firstName} ${profile.lastName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 38.v),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 82.v,
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 15.h,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    List<IconData> icon = [
                      Icons.phone,
                      Icons.email,
                      Icons.location_on_rounded,
                      Icons.upload,
                    ];

                    List<String> textByIndex = [
                      '${profile.countryCode} ${profile.number}',
                      profile.email,
                      profile.address,
                      '${profile.birthdate} ${AppLocalizations.of(context)!.yearsOld}',
                    ];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.h,
                        vertical: 8.v,
                      ),
                      decoration: WBoxDecoration.containerDataDarkDecoration,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              icon[index],
                              color: WColors.accent,
                              size: 31.adaptSize
                          ),
                          SizedBox(height: 8.v),
                          Text(
                            textByIndex[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 23.v),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.editProfile,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

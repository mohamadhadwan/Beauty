import 'package:beauty_wider/Core/app_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int notificationCount = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<HomeProvider>(context, listen: false).initializeData(context);
      _loadNotificationCount();
    });
    // setupFirebaseMessagingListeners();
  }


  void setupFirebaseMessagingListeners() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PageNavigator(ctx: context).nextPage(page: const NotificationsScreen());
    });

    FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.notification?.body}");
      incrementNotificationCount();
      Provider.of<HomeProvider>(context, listen: false).initializeData(context);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.notification?.body}");
    });
  }

  void _loadNotificationCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationCount = prefs.getInt('notificationCount') ?? 0;
    });
  }

  void _saveNotificationCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('notificationCount', count);
  }

  void incrementNotificationCount() {
    notificationCount++;
    _saveNotificationCount(notificationCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, home, child) {
         return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22.v),
              AppbarWidget(notificationCount: notificationCount, provider: home),
              SizedBox(height: 27.v),
              OffersSliderWidget(provider: home),
              SizedBox(height: 18.v),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 23.h),
                child: Text(
                  AppLocalizations.of(context)!.ourServices,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 16.v),
              const ServicesRowWidget(),
              SizedBox(height: 10.v),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 23.h),
                child: Text(
                  AppLocalizations.of(context)!.reminders,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 16.v),
              RemindersContainerWidget(provider: home)
            ],
          );
        },
      ),
    );
  }
}
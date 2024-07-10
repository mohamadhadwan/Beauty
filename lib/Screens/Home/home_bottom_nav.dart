import 'package:beauty_wider/Core/app_imports.dart';

class HomeBottomNavBarScreen extends StatefulWidget {
  final int index;
  final String? appointmentId;

  const HomeBottomNavBarScreen({
    super.key,
    required this.index,
    this.appointmentId
  });

  @override
  State<HomeBottomNavBarScreen> createState() => _HomeBottomNavBarScreenState();
}

class _HomeBottomNavBarScreenState extends State<HomeBottomNavBarScreen> {
  late int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    currentIndex = widget.index;
    pages = [
      const HomeScreen(),
      const UpdatesScreen(),
      const AppointmentsScreen(),
      const AboutScreen()
    ];
  }

  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          Scaffold(
            body: pages.elementAt(currentIndex),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(23.adaptSize),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
                child: BottomNavigationBar(
                  onTap: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  currentIndex: currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      backgroundColor: Colors.white,
                      icon: const Icon(IconlyBold.home),
                      label: AppLocalizations.of(context)!.home,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.medical_services),
                      label: AppLocalizations.of(context)!.updates,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(IconlyBold.document),
                      label: AppLocalizations.of(context)!.appointments,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.info),
                      label: AppLocalizations.of(context)!.about,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

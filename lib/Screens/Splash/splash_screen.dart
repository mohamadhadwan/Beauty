import 'package:beauty_wider/Core/app_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();

    navigate();

  }

  void navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      DatabaseProvider().getToken().then((value) {
        if (value == '') {
          PageNavigator(ctx: context)
              .nextPageOnly(page: const ChooseLanguage());
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Provider.of<HomeProvider>(context, listen: false).initializeData(context);
          });
          PageNavigator(ctx: context)
              .nextPageOnly(page: const HomeBottomNavBarScreen(index: 0));
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100.v),
          FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                  padding: EdgeInsets.all(80.adaptSize),
                  child: Hero(
                    tag: 'splash_image',
                    child: Image.asset(
                      'assets/images/beauty_wider_logo.png',
                      fit: BoxFit.fill,
                    ),
                  ))),
          SizedBox(height: 100.v),
          const Text(
            "Version",
            style:
                TextStyle(fontWeight: FontWeight.w700, color: WColors.primary),
          ).onTap(() => {}),
          const Text(
            "1.0.0",
            style:
                TextStyle(fontWeight: FontWeight.w900, color: WColors.primary),
          ),
        ],
      ),
    );
  }
}

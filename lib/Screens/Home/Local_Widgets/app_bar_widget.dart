import 'package:beauty_wider/Core/app_imports.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required this.notificationCount,
    required this.provider,
  });

  final int notificationCount;
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: AppBar(
        centerTitle: false,
        leading: Image.asset("assets/images/user_icon.png",
            width: 76.h, height: 76.v, color: WColors.primary),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${AppLocalizations.of(context)!.welcome}!\n",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey.shade500, letterSpacing: 2),
              ),
              TextSpan(
                text: provider.userName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.notifications,
                    size: 30.adaptSize, color: WColors.primary),
                if (notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 8,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.v),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red, // Background colors
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6.fSize,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

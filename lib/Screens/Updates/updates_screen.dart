// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/treatment_1.png",
      "assets/images/treatment_2.png",
      "assets/images/treatment_3.png",
    ];

    final List<Color> colors = [
      WColors.primary,
      WColors.secondary,
      WColors.secondary2
    ];

    final List<StatefulWidget> pages = [
      const OurServicesScreen(),
      const MyHistoryScreen(),
      const TipsScreen(),
    ];

    final List<String> titles = [
      AppLocalizations.of(context)!.ourServices,
      AppLocalizations.of(context)!.myHistory,
      AppLocalizations.of(context)!.tips,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.updates),
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 62.v),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 172.v,
          crossAxisCount: 2,
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 15.h,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                PageNavigator(ctx: context).nextPage(page: pages[index]),
            child: Container(
              height: 172.v,
              width: 156.h,
              decoration: WBoxDecoration.containerDataLightDecoration
                  .copyWith(color: colors[index]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titles[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 20.v),
                  Image.asset(images[index], height: 75.v, width: 55.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

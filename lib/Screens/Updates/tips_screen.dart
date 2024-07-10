import 'package:beauty_wider/Core/app_imports.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TipProvider>(context, listen: false).initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tips),
      ),
      body: Consumer<TipProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) return const SkeletonLoadingView();

          if (provider.tips.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context)!.noTipsFound));
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 25.v),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 13.v),
            itemCount: provider.tips.length,
            itemBuilder: (context, index) {
              final List<Color> colors = [
                WColors.primary,
                WColors.secondary,
                WColors.secondary2,
                WColors.accent
              ];
              TipsModel tip = provider.tips[index];
              return Container(
                height: 76.v,
                width: 329.h,
                decoration: WBoxDecoration.containerDataLightDecoration
                    .copyWith(color: colors[index % colors.length]),
                child: Row(
                  children: [
                    SizedBox(width: 23.h),
                    Container(
                      height: 40.v,
                      width: 40.h,
                      margin: EdgeInsets.symmetric(vertical: 12.v),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.adaptSize)),
                      child: Icon(Icons.tips_and_updates_sharp,
                          size: 25.adaptSize, color: WColors.primary),
                    ),
                    SizedBox(width: 10.h),
                    SizedBox(
                      width: 190.h,
                      child: Text(tip.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white)),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.all(12.adaptSize),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                              tip.isPublic
                                  ? 'assets/images/emoji_face.png'
                                  : 'assets/images/emoji_face_love.png',
                              height: 20.v,
                              width: 20.h)),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

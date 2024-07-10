import 'package:beauty_wider/Core/app_imports.dart';

class OurServicesScreen extends StatefulWidget {
  const OurServicesScreen({super.key});

  @override
  State<OurServicesScreen> createState() => _OurServicesScreenState();
}

class _OurServicesScreenState extends State<OurServicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<OurServiceProvider>(context, listen: false)
          .initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.ourServices),
      ),
      body: Consumer<OurServiceProvider>(
        builder: (context, provider, child) {
          if(provider.services.isEmpty){
            return const Center(child: Text('No services found'));
          }

          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 60.v),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18.h,
              mainAxisSpacing: 18.v,
            ),
            itemCount: provider.services.length,
            itemBuilder: (context, index) {
              List<Color> colors = [
                WColors.primary,
                WColors.secondary,
                WColors.secondary2
              ];

              return GestureDetector(
                onTap: () {
                  provider.setSelectedService(index);
                  PageNavigator(ctx: context)
                      .nextPage(page: const OurServicesDetailsScreen());
                },
                child: Container(
                  height: 155.v,
                  width: 155.h,
                  decoration: BoxDecoration(
                      color: colors[index % colors.length],
                      shape: BoxShape.circle),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (provider.services[index].fileUrl.isNotEmpty)
                        Image.network(
                          provider.services[index].fileUrl,
                          height: 53.v,
                          width: 53.h,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Icon(Icons.error,
                                size: 23.v, color: Colors.white);
                          },
                        ),
                      SizedBox(height: 10.v),
                      SizedBox(
                        width: 120.h,
                        child: Text(provider.services[index].name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                      const Icon(IconlyLight.arrowRight, color: Colors.white)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

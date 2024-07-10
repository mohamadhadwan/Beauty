import 'package:beauty_wider/Core/app_imports.dart';

class OurServicesDetailsScreen extends StatefulWidget {
  const OurServicesDetailsScreen({super.key});

  @override
  State<OurServicesDetailsScreen> createState() =>
      _OurServicesDetailsScreenState();
}

class _OurServicesDetailsScreenState extends State<OurServicesDetailsScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
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
          List<SliderModel> slidersOfTypeService = HomeProvider()
              .getSlidersOfTypeService()
              .where((slider) =>
                  slider.serviceId ==
                  provider.services[provider.selectedServiceIndex].id
                      .toString())
              .toList();

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 23.h),
            children: [
              SizedBox(height: 20.v),
              SizedBox(
                height: 262.v,
                width: 329.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slidersOfTypeService.length,
                  scrollBehavior: const MaterialScrollBehavior(),
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    SliderModel slider = slidersOfTypeService[index];
                    return Container(
                      height: 262.v,
                      width: 329.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(slider.fileUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 14.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildPageIndicators(slidersOfTypeService.length),
              ),
              SizedBox(height: 40.v),
              Text(provider.services[provider.selectedServiceIndex].name,
                  style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 30.v),
              Text(provider.services[provider.selectedServiceIndex].description,
                  maxLines: 8, style: const TextStyle(color: black)),
              SizedBox(height: 70.v),
              Center(
                child: SizedBox(
                    height: 31.v,
                    width: 194.h,
                    child: ElevatedButton(
                        onPressed: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: const BookAppointmentsScreen());
                        },
                        child: const Text('Book Appointment'))),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      height: isActive ? 8.h : 8.v,
      width: isActive ? 52.h : 8.v,
      decoration: BoxDecoration(
        color: WColors.secondary2,
        borderRadius: BorderRadius.all(Radius.circular(12.adaptSize)),
      ),
    );
  }

  List<Widget> _buildPageIndicators(int length) {
    List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }
}

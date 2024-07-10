import 'package:beauty_wider/Core/app_imports.dart';

class OffersSliderWidget extends StatelessWidget {
  const OffersSliderWidget({
    super.key,
    required this.provider,
  });

  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.isLoading) {
      return SizedBox(
          height: 177.v,
          child: const Center(child: CircularProgressIndicator()));
    }
    if (provider.sliders.isEmpty) {
      return Container(
          height: 177.v,
          alignment: Alignment.center,
          child: const Text('No sliders found'));
    }
    return CarouselSlider(
      options: CarouselOptions(
        height: 177.v,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        aspectRatio: 2.0,
      ),
      items: provider.sliders.map((item) {
        return GestureDetector(
          onTap: () async {
            if (item.type == 'link') {
              final Uri uri = Uri.parse(item.link);

              if (!await launchUrl(uri)) {
                print('hi');
              }
            } else if (item.type == 'appointment') {
              OurServiceProvider serviceProvider =
                  Provider.of<OurServiceProvider>(context, listen: false);
              serviceProvider.setSelectedService(int.parse(item.serviceId));

              PageNavigator(ctx: context)
                  .nextPage(page: const BookAppointmentsScreen());
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: CachedNetworkImageProvider(item.fileUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:beauty_wider/core/app_imports.dart';

class ServicesRowWidget extends StatelessWidget {
  const ServicesRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OurServiceProvider provider =
        Provider.of<OurServiceProvider>(context);
    if (provider.isLoading) {
      return SizedBox(
          height: 138.v,
          child: const Center(child: CircularProgressIndicator()));
    }
    if (provider.services.isEmpty) {
      return Container(
          height: 177.v,
          alignment: Alignment.center,
          child: const Text('No services found'));
    }
    return SizedBox(
      height: 138.v,
      child: ListView(
        padding: EdgeInsets.fromLTRB(9.h,0,23.h, 10.v),
        scrollDirection: Axis.horizontal,
        children: List.generate(
          provider.services.length,
          (index) {
            final List<Color> colors = [
              WColors.primary,
              WColors.secondary,
              WColors.secondary2
            ];

            return GestureDetector(
              onTap: () {
                provider.setSelectedService(index);
                PageNavigator(ctx: context)
                    .nextPage(page: const BookAppointmentsScreen());
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 14.h),
                height: 138.v,
                width: 115.h,
                decoration: WBoxDecoration.containerDataLightDecoration
                    .copyWith(color: colors[index % colors.length]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 10.v),
                    SizedBox(
                      width: 110.h,
                      child: Text(provider.services[index].name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

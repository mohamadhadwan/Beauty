import 'package:beauty_wider/Core/app_imports.dart';

class ServiceSelectedWidget extends StatelessWidget {
  const ServiceSelectedWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    OurServiceProvider provider =
        Provider.of<OurServiceProvider>(context, listen: false);
    return Center(
      child: Container(
        width: 329.v,
        height: 38.h,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.h, color: WColors.primary),
            borderRadius: BorderRadius.circular(16.adaptSize),
          ),
        ),
        child: Text(provider.services[provider.selectedServiceIndex].name,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.fSize)),
      ),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';

class ContainerTapWidget extends StatelessWidget {
  const ContainerTapWidget({
    super.key,
    required this.context,
    required this.text,
    required this.icon,
    required this.onTapAction,
  });

  final BuildContext context;
  final String text;
  final IconData icon;
  final VoidCallback? onTapAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 31.h,
        right: 31.h,
        top: 18.v,
      ),
      child: InkWell(
        onTap: () {
          if (onTapAction != null) {
            onTapAction!();
          }
        },
        child: Container(
          width: double.maxFinite,
          height: 54.v,
          decoration: WBoxDecoration.containerDataLightDecoration,
          child: Row(
            children: [
              Container(
                height: 36.v,
                width: 36.h,
                margin: EdgeInsetsDirectional.only(start: 30.h, end: 24.h),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: WColors.accent),
                child: Icon(
                  icon,
                  color: WColors.primary,
                  size: 24.adaptSize,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 18.h),
                child: Icon(Icons.arrow_forward,
                    size: 18.adaptSize, color: WColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
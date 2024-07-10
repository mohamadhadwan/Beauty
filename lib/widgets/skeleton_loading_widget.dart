import 'package:beauty_wider/Core/app_imports.dart';

class SkeletonLoadingView extends StatelessWidget {
  const SkeletonLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650.v,
      child: Padding(
        padding: EdgeInsets.only(left: 30.h, top: 55.v, right: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(height: 92.v, width: 314.h),
            SizedBox(height: 33.v),
            Skeleton(height: 92.v, width: 274.h),
            SizedBox(height: 33.v),
            Skeleton(height: 92.v, width: 204.h),
            SizedBox(height: 33.v),
            Skeleton(height: 92.v, width: 314.h),
            SizedBox(height: 33.v),
            Skeleton(height: 92.v, width: 214.h),
          ],
        ),
      ),
    );
  }
}

import 'package:beauty_wider/Core/app_imports.dart';

class WBoxDecoration {

  static BoxDecoration get containerFieldDecoration => BoxDecoration(
  color: Colors.grey.shade100,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
        color: Colors.black.withOpacity(0.20),
        blurRadius: 6.h,
        offset: const Offset(3, 4))
  ]
 );

  static BoxDecoration get containerDataLightDecoration => BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.20),
        blurRadius: 6.h,
        offset: const Offset(
          3,
          4
        )
      )
    ]
  );

  static BoxDecoration get containerDataDarkDecoration => BoxDecoration(
      color: WColors.primary,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 6.h,
            offset: const Offset(
                3,
                4
            )
        )
      ]
  );

  static BoxDecoration get imageAppointmentDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(50.adaptSize),
        border: Border.all(color: WColors.secondary2, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 6.h,
            offset: const Offset(
              3,
              4
            )
          )
        ]
      );

  static BoxDecoration get containerLabelLightDecoration => BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
  );

  static BoxDecoration get containerLabelDarkDecoration => BoxDecoration(
    color: WColors.secondary2,
    borderRadius: BorderRadius.circular(16),
  );
}

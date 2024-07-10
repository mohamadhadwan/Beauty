// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import '../consultation_card_screen.dart';

class AppointmentContainer extends StatelessWidget {
  final AppointmentProvider provider;
  final String id;
  final String clinicBranchName;
  final String status;
  final String date;
  final String time;
  final String clinicBranchPhoneNumber;
  final String clinicBranchLocation;

  const AppointmentContainer({super.key,
    required this.provider,
    required this.id,
    required this.clinicBranchName,
    required this.status,
    required this.date,
    required this.time,
    required this.clinicBranchPhoneNumber,
    required this.clinicBranchLocation,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == 'pending') {
          provider.setAppointmentId(id);
          PageNavigator(ctx: context).nextPage(page: const ConsultationScreen());
        } else {
          showAppointmentDetailsDialog(
              context: context,
              clinicBranchName: clinicBranchName,
              clinicBranchLocation: clinicBranchLocation,
              clinicBranchPhoneNumber: clinicBranchPhoneNumber,
              date: date,
              time: time
          );
        }
      },
      child: Container(
        width: 330.h,
        padding: EdgeInsets.symmetric(
          horizontal: 14.h,
          vertical: 6.v,
        ),
        decoration: WBoxDecoration.containerDataLightDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45.v,
              width: 45.h,
              decoration:
              WBoxDecoration.imageAppointmentDecoration,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/clinic.png',
                  height: 45.v,
                  width: 45.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 13.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240.h,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 185.h,
                        child: Text(
                            clinicBranchName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall),
                      ),
                      Container(
                        width: 55.h,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.h,
                                color: status ==
                                    'pending'
                                    ? Colors.yellow
                                    : status ==
                                    'cancelled'
                                    ? const Color(
                                    0xFF0DAB00)
                                    : WColors.primary),
                            borderRadius:
                            BorderRadius.circular(
                                7.adaptSize),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.h),
                          child: Text(status.capitalizeFirstLetter(),
                              style: TextStyle(
                                  fontSize: 9.fSize,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w700,
                                  color: status ==
                                      'pending'
                                      ? Colors.yellow
                                      : status ==
                                      'cancelled'
                                      ? const Color(
                                      0xFF0DAB00)
                                      : WColors.primary)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 6.v),
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: WColors.primary,
                      size: 15.adaptSize,
                    ),
                    SizedBox(width: 4.h),
                    SizedBox(
                      width: 100.h,
                      child: Text(
                        date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ),
                    Icon(
                      Icons.access_time_sharp,
                      color: WColors.primary,
                      size: 15.adaptSize,
                    ),
                    SizedBox(width: 4.h),
                    SizedBox(
                      width: 90.h,
                      child: Text(
                        time,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ),
                    Icon(
                      IconlyLight.arrowRight,
                      color: WColors.primary,
                      size: 15.adaptSize,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

  void showAppointmentDetailsDialog({
    required BuildContext context,
    required String clinicBranchName,
    required String clinicBranchPhoneNumber,
    required String clinicBranchLocation,
    required String date,
    required String time,
  }) async {
    Future<void> launchWhatsApp(String phoneNumber, String message) async {
      final Uri whatsappUrl =
          Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}");

      if (!await launchUrl(whatsappUrl)) {
        throw 'Could not launch $whatsappUrl';
      }
    }

    Future<void> launchPhoneCall(String phoneNumber) async {
      final Uri phoneUri = Uri.parse('tel:$phoneNumber');
      if (!await launchUrl(phoneUri)) {
        throw 'Could not launch $phoneUri';
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            height: 430.v,
            width: 329.h,
            margin: EdgeInsets.only(
              left: 23.h,
              right: 23.h,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 380.v,
                    padding: EdgeInsets.symmetric(
                      horizontal: 43.h,
                      vertical: 24.v,
                    ),
                    decoration: WBoxDecoration.containerDataDarkDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.v),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 250.h,
                            child: Text(
                              clinicBranchName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 28.v),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 18.adaptSize,
                            ),
                            Container(
                              width: 203.h,
                              margin: EdgeInsetsDirectional.only(start: 13.h),
                              child: Text(clinicBranchPhoneNumber,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.v),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 18.adaptSize,
                            ),
                            Container(
                              width: 203.h,
                              margin: EdgeInsetsDirectional.only(start: 13.h),
                              child: Text(clinicBranchLocation,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.v),
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 18.adaptSize,
                            ),
                            Container(
                              width: 203.h,
                              margin: EdgeInsetsDirectional.only(start: 13.h),
                              child: Text(clinicBranchName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.v),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                              size: 18.adaptSize,
                            ),
                            Container(
                              width: 203.h,
                              margin: EdgeInsetsDirectional.only(start: 13.h),
                              child: Text(date,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.v),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_sharp,
                              color: Colors.white,
                              size: 18.adaptSize,
                            ),
                            Container(
                              width: 203.h,
                              margin: EdgeInsetsDirectional.only(start: 13.h),
                              child: Text(time,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.v),
                        Row(
                          children: [
                            Container(
                              height: 32.v,
                              width: 32.h,
                              decoration: BoxDecoration(
                                  color: WColors.secondary2,
                                  borderRadius:
                                      BorderRadius.circular(32.adaptSize)),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 18.adaptSize,
                              ),
                            ).onTap(
                                () => launchPhoneCall(clinicBranchPhoneNumber)),
                            Container(
                              height: 32.v,
                              width: 32.h,
                              margin: EdgeInsetsDirectional.only(start: 11.h),
                              padding: EdgeInsets.all(8.adaptSize),
                              decoration: BoxDecoration(
                                  color: WColors.secondary2,
                                  borderRadius:
                                      BorderRadius.circular(32.adaptSize)),
                              child: Image.asset(
                                'assets/images/whatsapp_icon.png',
                                color: Colors.white,
                              ),
                            ).onTap(() => launchWhatsApp(
                                clinicBranchPhoneNumber, 'Hello Doctor')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100.v,
                  width: 100.h,
                  decoration: WBoxDecoration.imageAppointmentDecoration,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/clinic.png",
                      height: 100.v,
                      width: 100.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

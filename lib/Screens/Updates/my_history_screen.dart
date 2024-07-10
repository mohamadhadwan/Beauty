// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class MyHistoryScreen extends StatefulWidget {
  const MyHistoryScreen({super.key});

  @override
  State<MyHistoryScreen> createState() => _MyHistoryScreenState();
}

class _MyHistoryScreenState extends State<MyHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MyHistoryProvider>(context, listen: false).initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Consumer<MyHistoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) return const SkeletonLoadingView();

          if (provider.history.isEmpty) {
            return const Center(
              child: Text('No History Found'),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 25.v),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 15.v),
            itemCount: provider.history.length,
            itemBuilder: (context, index) {
              MyHistoryModel hist = provider.history[index];
              String appointmentDate = hist.start;

              String date = '';
              String time = '';

              String language = Provider.of<LocalLanguageProvider>(context).localLanguage.languageCode;
              String currentTimeZone = Provider.of<TimezoneProvider>(context).currentTimeZone;

              try {
                DateTime dateAndTimeUTC = DateTime.parse(appointmentDate);
                tz.TZDateTime dateAndTimeLocal = tz.TZDateTime.from(
                    dateAndTimeUTC, tz.getLocation(currentTimeZone));

                date =
                    DateFormat('dd/MM/yyyy', language).format(dateAndTimeLocal);
                time = DateFormat('hh:mm a', language).format(dateAndTimeLocal);
              } catch (e) {
                date = '';
                time = '';
              }

              return GestureDetector(
                onTap: () {
                  showHistoryDetailsDialog(
                      context: context,
                      service: hist.service,
                      energy: hist.energy,
                      technician: hist.technician,
                      frequency: hist.frequency,
                      measurement: hist.measurement,
                      pulseDuration: hist.pulseDuration,
                      treatmentParameters: hist.treatmentParameters,
                      date: date,
                      time: time);
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
                        decoration: WBoxDecoration.imageAppointmentDecoration,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/clinic.png',
                            height: 45.v,
                            width: 45.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 225.h,
                            child: Text(hist.service,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                          SizedBox(height: 6.v),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style: Theme.of(context).textTheme.bodySmall,
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
                                  style: Theme.of(context).textTheme.bodySmall,
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
            },
          );
        },
      ),
    );
  }
}

void showHistoryDetailsDialog({
  required BuildContext context,
  required String service,
  required String technician,
  required String treatmentParameters,
  required String measurement,
  required String energy,
  required String frequency,
  required String pulseDuration,
  required String date,
  required String time,
}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          height: 520.v,
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
                  height: 460.v,
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
                            service,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ), //service
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
                            child: Text(technician,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ],
                      ), //tech
                      SizedBox(height: 12.v),
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
                            child: Text(treatmentParameters,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ],
                      ), //treat
                      SizedBox(height: 12.v),
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
                            child: Text(measurement,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ],
                      ), //measurement
                      SizedBox(height: 12.v),
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
                            child: Text(frequency,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ],
                      ), //freq
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
                            child: Text(energy,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ],
                      ), //energy
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
                            child: Text(pulseDuration,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ],
                      ), //pulseDuration
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

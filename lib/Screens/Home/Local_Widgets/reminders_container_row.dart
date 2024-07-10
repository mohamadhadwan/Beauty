// ignore_for_file: depend_on_referenced_packages
import 'dart:math';
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class RemindersContainerWidget extends StatelessWidget {
  const RemindersContainerWidget({
    super.key,
    required this.provider,
  });

  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    final String language =
        Provider.of<LocalLanguageProvider>(context).localLanguage.languageCode;
    final String currentTimeZone =
        Provider.of<TimezoneProvider>(context).currentTimeZone;

    String nextAppointment = provider.nextAppointment;

    tz.TZDateTime? dateLocal;

    if (nextAppointment.isNotEmpty) {
      try {
        DateTime date = DateTime.parse(nextAppointment);
        dateLocal = tz.TZDateTime.from(date, tz.getLocation(currentTimeZone));

        tz.TZDateTime nowLocal =
            tz.TZDateTime.now(tz.getLocation(currentTimeZone));
        DateTime tomorrow =
            DateTime(nowLocal.year, nowLocal.month, nowLocal.day + 1);

        if (dateLocal.year == tomorrow.year &&
            dateLocal.month == tomorrow.month &&
            dateLocal.day == tomorrow.day) {
          nextAppointment = AppLocalizations.of(context)!.appointmentTomorrow;
        } else {
          nextAppointment =
              '${AppLocalizations.of(context)!.nextAppointmentDate}${DateFormat('dd MMMM yyyy', language).format(dateLocal)} at ${DateFormat('hh:mm a', language).format(dateLocal)}.';
        }
      } catch (e) {
        nextAppointment = nextAppointment =
            AppLocalizations.of(context)!.noUpcomingAppointments;
      }
    } else {
      nextAppointment = AppLocalizations.of(context)!.noUpcomingAppointments;
    }

    TipProvider tipProvider = Provider.of<TipProvider>(context, listen: false);

    int randomIndex = 0;

    if (tipProvider.tips.isNotEmpty) {
      randomIndex = Random().nextInt(tipProvider.tips.length);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 62.v,
            padding: EdgeInsetsDirectional.only(start: 15.h, end: 4.h),
            decoration: WBoxDecoration.containerDataLightDecoration,
            child: Row(
              children: [
                Icon(Icons.calendar_month,
                    size: 28.adaptSize, color: WColors.primary),
                SizedBox(width: 15.h),
                Expanded(
                  child: Text(nextAppointment,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.v),
          Container(
            height: 62.v,
            padding: EdgeInsetsDirectional.only(start: 15.h, end: 4.h),
            decoration: WBoxDecoration.containerDataLightDecoration,
            child: Row(
              children: [
                Icon(Icons.no_food, size: 28.adaptSize, color: WColors.primary),
                SizedBox(width: 15.h),
                Expanded(
                  child: Text(
                      tipProvider.tips.isNotEmpty
                          ? tipProvider.tips[randomIndex].description
                          : 'No tips found',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

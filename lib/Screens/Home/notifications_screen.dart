// app_imports.dart
// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Model/notification_model.dart';
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchNotifications();
    });
  }

  void fetchNotifications() async {
    try {
      await Provider.of<NotificationProvider>(context, listen: false)
          .fetchNotifications();
    } catch (e) {
      if (e is Exception) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        showErrorMessage(errorMessage);
      }
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications =
        Provider.of<NotificationProvider>(context).groupedNotifications;

    return Consumer<NotificationProvider>(builder: (_, provider, __) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.notifications),
            // provider.setAllAsRead();
        ),
        body: provider.isLoading
            ? buildLoadingView()
            : groupedNotifications.isEmpty
                ? buildEmptyView(context)
                : buildNotificationsList(provider),
      );
    });
  }

  Widget buildNotificationsList(NotificationProvider provider) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(height: 15.v);
      },
      itemCount: provider.groupedNotifications.keys.length,
      itemBuilder: (context, index) {
        DateTime date = provider.groupedNotifications.keys.elementAt(index);
        List<NotificationModel> notifications = provider.groupedNotifications[date]!;
        return NotificationGroup(date: date, notifications: notifications);
      },
    );
  }



  Widget buildLoadingView() {
    return SizedBox(
      height: 650.v,
      child: Padding(
        padding: EdgeInsets.only(
          left: 30.h,
          top: 55.v,
          right: 30.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skeleton(height: 92.v, width: 314.h),
            // SizedBox(height: 33.v),
            // Skeleton(height: 92.v, width: 274.h),
            // SizedBox(height: 33.v),
            // Skeleton(height: 92.v, width: 204.h),
            // SizedBox(height: 33.v),
            // Skeleton(height: 92.v, width: 314.h),
            // SizedBox(height: 33.v),
            // Skeleton(height: 92.v, width: 214.h),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyView(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.noNotificationsFound)
    );
  }
}

class NotificationGroup extends StatelessWidget {
  final DateTime date;
  final List<NotificationModel> notifications;

  const NotificationGroup({super.key, required this.date, required this.notifications});

  @override
  Widget build(BuildContext context) {
    final localLanguageProvider = Provider.of<LocalLanguageProvider>(context);
    String language = localLanguageProvider.localLanguage.languageCode;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              top: 14.v,
            ),
            child: Text(DateFormat('dd MMMM yyyy', language).format(date),
              // style: CustomTextStyles.bodyLargePrimaryRegular,
            ),
          ),
          SizedBox(height: 15.v),
          Column(
            children: notifications.map((notification) => NotificationItem(notification: notification)).toList(),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  String formatRelativeTime(BuildContext context, tz.TZDateTime timeToCompare) {
    final localLanguageProvider = Provider.of<LocalLanguageProvider>(context);
    bool isEnglish = localLanguageProvider.localLanguage.languageCode == 'en';

    final timezoneProvider = Provider.of<TimezoneProvider>(context);
    final currentTimeZone = timezoneProvider.currentTimeZone;

    tz.TZDateTime nowLocal = tz.TZDateTime.now(tz.getLocation(currentTimeZone));
    tz.TZDateTime timeToCompareLocal =
    tz.TZDateTime.from(timeToCompare, tz.getLocation(currentTimeZone));

    Duration difference = nowLocal.difference(timeToCompareLocal);

    if (difference.inSeconds < 60) {
      return isEnglish ? 'just now' : 'للتو';
    } else if (difference.inMinutes == 1) {
      return isEnglish ? '1 minute ago' : 'منذ دقيقة';
    } else if (difference.inMinutes < 60) {
      return isEnglish
          ? '${difference.inMinutes} minutes ago'
          : 'منذ ${difference.inMinutes} دقائق';
    } else if (difference.inHours == 1) {
      return isEnglish ? '1 hour ago' : 'منذ ساعة';
    } else if (difference.inHours == 2) {
      return isEnglish ? '2 hours ago' : 'منذ ساعتين';
    } else if (difference.inHours <= 10) {
      return isEnglish
          ? '${difference.inHours} hours ago'
          : 'منذ ${difference.inHours} ساعات';
    } else if (difference.inHours <= 24) {
      return isEnglish
          ? '${difference.inHours} hours ago'
          : 'منذ ${difference.inHours} ساعة';
    } else {
      return DateFormat("hh:mm a", isEnglish ? 'en' : 'ar')
          .format(timeToCompare);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);

    final timezoneProvider = Provider.of<TimezoneProvider>(context);
    final currentTimeZone = timezoneProvider.currentTimeZone;


    tz.TZDateTime notificationCreatedAt = tz.TZDateTime.from(notification.createdAt, tz.getLocation(currentTimeZone));
    String formattedNotificationTime = formatRelativeTime(context, notificationCreatedAt);

    return GestureDetector(
      onTap: () async {
        if (notification.type == 'mealplan') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const MyHistoryScreen(),
            ),
          );
        } else if (notification.type ==
            'appointment') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomeBottomNavBarScreen(
                      index: 2,
                      appointmentId: notification
                          .payload['appointment']
                      ['id']
                          .toString()),
            ),
          );
        }
        provider.setAllAsRead();
      },
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //       horizontal: 8.h),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(
          //         vertical: 5.v),
          //     decoration: notification.read
          //         ? AppDecoration.outlineBlack9010
          //         .copyWith(
          //       borderRadius:
          //       BorderRadiusStyle1
          //           .roundedBorder16,
          //     )
          //         : AppDecoration.outlineBlack9011
          //         .copyWith(
          //       borderRadius:
          //       BorderRadiusStyle1
          //           .roundedBorder16,
          //     ),
          //     child: Row(
          //       mainAxisAlignment:
          //       MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Container(
          //           height: 40.adaptSize,
          //           width: 40.adaptSize,
          //           margin: EdgeInsets.symmetric(
          //               vertical: 12.v),
          //           decoration: BoxDecoration(
          //               color: notification.read ? appTheme.deepReddishPurple : Colors.white,
          //               borderRadius: BorderRadius.circular(40.0)
          //           ),
          //           child: Icon(
          //               Icons.notifications,
          //               size: 30.adaptSize,
          //               color: notification.read ? Colors.white : appTheme.deepReddishPurple
          //           ),
          //         ),
          //         Container(
          //           height: 57.v,
          //           width: 223.h,
          //           margin:
          //           EdgeInsets.only(top: 11.v),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 notification.notificationMessage,
          //                 maxLines: 2,
          //                 overflow: TextOverflow
          //                     .ellipsis,
          //                 style: notification.read
          //                     ? CustomTextStyles
          //                     .titleSmallOnPrimaryDark_1
          //                     .copyWith(
          //                   height: 1.27,
          //                 )
          //                     : CustomTextStyles
          //                     .titleSmallOnPrimary_1
          //                     .copyWith(
          //                   height: 1.27,
          //                 ),
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   Text(
          //                     formattedNotificationTime,
          //                     textAlign:
          //                     TextAlign.right,
          //                     style: notification.read
          //                         ? CustomTextStyles
          //                         .bodySmallOnPrimaryDark_1
          //                         : CustomTextStyles
          //                         .bodySmallOnPrimaryLight_1,
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 15.v)
        ],
      ),
    );
  }
}
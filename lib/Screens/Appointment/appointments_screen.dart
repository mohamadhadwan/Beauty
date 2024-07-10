// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'LocalWidget/appointment_container.dart';

class AppointmentsScreen extends StatefulWidget {

  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String selectedTab = 'upcoming';
  String _currentLanguage = '';
  String _currentTimeZone = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async  {
      final AppointmentProvider provider = Provider.of<AppointmentProvider>(context, listen: false);
      _currentLanguage = Provider.of<LocalLanguageProvider>(context, listen: false).localLanguage.languageCode;
      _currentTimeZone = Provider.of<TimezoneProvider>(context, listen: false).currentTimeZone;
      await provider.fetchAppointmentsByType('upcoming');
      await provider.fetchAppointmentsByType('past');
    });
  }

  void toggleTab(String tab) {
    setState(() => selectedTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appointments),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              PageNavigator(ctx: context).nextPage(page: const OurServicesScreen());
            },
          ),
        ],
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) return const SkeletonLoadingView();

          if (provider.upcomingAppointments.isEmpty &&
              provider.pastAppointments.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context)!.noAppointmentsFound));
          }

          return Padding(
            padding: EdgeInsets.only(bottom: 80.v),
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 23.h),
                children: [
                  SizedBox(height: 35.v),
                  Container(
                    height: 42.v,
                    width: 314.h,
                    decoration: WBoxDecoration.containerDataLightDecoration,
                    child: Row(
                      children: [
                        TabWidget(
                            tab: 'upcoming',
                            label: AppLocalizations.of(context)!
                                .upcoming
                                .capitalizeFirstLetter(),
                            isSelected: selectedTab == 'upcoming',
                            onTap: toggleTab),
                        TabWidget(
                            tab: 'past',
                            label: AppLocalizations.of(context)!
                                .past
                                .capitalizeFirstLetter(),
                            isSelected: selectedTab == 'past',
                            onTap: toggleTab),
                      ],
                    ),
                  ),
                  SizedBox(height: 33.v),
                  (selectedTab == 'past' && provider.pastAppointments.isEmpty)
                      || (selectedTab == 'upcoming' && provider.upcomingAppointments.isEmpty) ?
                    SizedBox(
                        height: 600.v,
                        child: Center(
                          child:
                          Text(AppLocalizations.of(context)!.noAppointmentsFound),
                        )) :
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: 15.v),
                    itemCount: selectedTab == 'upcoming'
                        ? provider.upcomingAppointments.length
                        : provider.pastAppointments.length,
                    itemBuilder: (context, index) {
                      AppointmentsModel appointment = selectedTab == 'upcoming'
                          ? provider.upcomingAppointments[index]
                          : provider.pastAppointments[index];

                      String id = appointment.id.toString();
                      String status = appointment.status;
                      String date = '';
                      String time = '';
                      String clinicBranchName = '';
                      String clinicBranchPhoneNumber = '';
                      String clinicBranchLocation = '';

                      try {
                        DateTime dateAndTimeUTC = appointment.start;
                        tz.TZDateTime dateAndTimeLocal = tz.TZDateTime.from(
                            dateAndTimeUTC, tz.getLocation(_currentTimeZone));

                        date = DateFormat('dd/MM/yyyy', _currentLanguage)
                            .format(dateAndTimeLocal);
                        time = DateFormat('hh:mm a', _currentLanguage)
                            .format(dateAndTimeLocal);

                        if (appointment.clinicBranch != null &&
                            appointment.clinicBranch!.isNotEmpty) {
                          ClinicBranch clinicBranch =
                              appointment.clinicBranch![0];
                          clinicBranchLocation = clinicBranch.location;
                        }

                        if (appointment.clinicBranch![0].user != null &&
                            appointment.clinicBranch![0].user!.isNotEmpty) {
                          User user = appointment.clinicBranch![0].user![0];
                          clinicBranchPhoneNumber =
                              '+${user.countryCode}${user.number}';
                          clinicBranchName = user.firstName;
                        }
                      } catch (e) {
                        date = '';
                        time = '';
                      }

                      return AppointmentContainer(
                        provider: provider,
                        id: id,
                        clinicBranchName: clinicBranchName,
                        status: status,
                        date: date,
                        time: time,
                        clinicBranchPhoneNumber: clinicBranchPhoneNumber,
                        clinicBranchLocation: clinicBranchLocation,
                      );
                    },
                  ),
                  SizedBox(height: 10.v),
                ]),
          );
        },
      ),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:beauty_wider/Screens/Appointment/BookAppointment/LocalWidget/options_row_widget.dart';
import 'package:timezone/timezone.dart' as tz;

class BookAppointmentsScreen extends StatefulWidget {
  const BookAppointmentsScreen({super.key});
  @override
  State<BookAppointmentsScreen> createState() => _BookAppointmentsScreenState();
}

class _BookAppointmentsScreenState extends State<BookAppointmentsScreen> {
  String currentTimeZone = 'UTC';
  CalendarFormat calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OurServiceProvider serviceProvider =
          Provider.of<OurServiceProvider>(context, listen: false);
      BookAppointmentProvider provider =
          Provider.of<BookAppointmentProvider>(context, listen: false);
      provider.getBranches(
          serviceProvider.services[serviceProvider.selectedServiceIndex].id,
          context);
      provider.resetSelections();
      currentTimeZone = Provider.of<TimezoneProvider>(context, listen: false).currentTimeZone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bookAppointment),
      ),
      body: Consumer<BookAppointmentProvider>(
        builder: (context, bookAppointment, child) {
          if (bookAppointment.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (bookAppointment.clinicBranches.isEmpty) {
            return const Center(child: Text('Book appointment not available'));
          }

          OurServiceProvider service =
              Provider.of<OurServiceProvider>(context, listen: false);

          return ListView(
            children: [
              SizedBox(height: 20.v),
              Center(
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
                  child: Text(
                      service.services[service.selectedServiceIndex].name,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18.fSize)),
                ),
              ),
              SizedBox(height: 30.v),
              DataRowWidget(
                provider: bookAppointment,
                items: bookAppointment.clinicBranches,
                selectedIndex: bookAppointment.selectedBranchIndex,
                onSelect: (index) {
                  bookAppointment.selectBranch(index);
                },
                title: 'Select branch',
              ),
              SizedBox(height: 20.v),
              DataRowWidget(
                provider: bookAppointment,
                items: bookAppointment
                    .clinicBranches[bookAppointment.selectedBranchIndex]
                    .technicians,
                selectedIndex: bookAppointment.selectedTechnicianIndex,
                onSelect: (index) {
                  bookAppointment.selectTechnician(index);
                },
                title: 'Select technician',
              ),
              SizedBox(height: 20.v),
              OptionsRowWidget(
                provider: bookAppointment,
                items: bookAppointment
                    .clinicBranches[bookAppointment.selectedBranchIndex]
                    .technicians[bookAppointment.selectedTechnicianIndex]
                    .options,
                selectedIndices: bookAppointment.selectedOptionsIndex,
                onSelect: (index) {
                  if (bookAppointment.selectedOptionsIndex != null &&
                      bookAppointment.selectedOptionsIndex!.contains(index)) {
                    bookAppointment.selectOptions(index);
                  } else {
                    bookAppointment.selectOptions(index);
                  }
                },
                title: 'Select options',
              ),
              buildTableCalendar(bookAppointment),
              SizedBox(height: 20.v),
              AvailableTimesRowWidget(
                  context: context, provider: bookAppointment),
              SizedBox(height: 60.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.h),
                child: ElevatedButton(
                  onPressed: !bookAppointment.selectedTime.isEmptyOrNull &&
                          (bookAppointment
                                  .clinicBranches[
                                      bookAppointment.selectedBranchIndex]
                                  .technicians[
                                      bookAppointment.selectedTechnicianIndex]
                                  .options
                                  .isEmpty
                              ? true
                              : bookAppointment
                                      .selectedOptionsIndex?.isNotEmpty ??
                                  false)
                      ? () {
                          PageNavigator(ctx: context)
                              .nextPage(page: const BookAppointments2Screen());
                        }
                      : null,
                  child: const Text('Next'),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildTableCalendar(BookAppointmentProvider provider) {
    if (!provider.hasAvailableStaff) {
      return const Center(
          child: Text(
              "No available doctors or technicians for scheduling appointments."));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.h),
          child: Text('Select Date',
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: TableCalendar(
            firstDay: tz.TZDateTime.from(
                DateTime.now(), tz.getLocation(currentTimeZone)),
            lastDay: DateTime.utc(2030, 3, 14),
            daysOfWeekHeight: 18.v,
            currentDay: provider.selectedDate,
            focusedDay: provider.selectedDate,
            selectedDayPredicate: (day) =>
                isSameDay(provider.selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              provider.setSelectedDate(selectedDay);
              setState(() {
                focusedDay = selectedDay;
              });
            },
            enabledDayPredicate: (day) {
              return Provider.of<BookAppointmentProvider>(context,
                      listen: false)
                  .isDayAvailable(day, context);
            },
            onFormatChanged: (format) {
              setState(() {
                calendarFormat = format;
              });
            },
            calendarFormat: calendarFormat,
            availableGestures: AvailableGestures.horizontalSwipe,
            calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                    color: WColors.secondary2, shape: BoxShape.circle),
                defaultTextStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: WColors.primary)),
          ),
        ),
      ],
    );
  }
}

import 'package:beauty_wider/Core/app_imports.dart';

class AvailableTimesRowWidget extends StatelessWidget {
  const AvailableTimesRowWidget({
    super.key,
    required this.context,
    required this.provider,
  });

  final BuildContext context;
  final BookAppointmentProvider provider;

  @override
  Widget build(BuildContext context) {
    AppointmentProvider appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    List<String> timeSlots =
        provider.getTimeSlotsForDay(provider.selectedDate, context);
    if (!provider.hasAvailableStaff) {
      return const Center(
          child: Text("No available times due to lack of staff."));
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Available Time',
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize)),
          SizedBox(height: 10.v),
          SizedBox(
            height: 30.v,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 10.h),
              scrollDirection: Axis.horizontal,
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    provider.selectTime(index);
                    provider.setSelectedTime(timeSlots[index]);
                  },
                  child: Container(
                      height: 30.v,
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      alignment: Alignment.center,
                      decoration: provider.selectedTimeIndex == index
                          ? WBoxDecoration.containerLabelDarkDecoration
                          : WBoxDecoration.containerLabelLightDecoration,
                      child: Text(timeSlots[index],
                          style: TextStyle(
                              color: provider.selectedTimeIndex == index
                                  ? white
                                  : black))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

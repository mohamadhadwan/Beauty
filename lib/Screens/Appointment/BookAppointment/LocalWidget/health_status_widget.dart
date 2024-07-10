import 'package:beauty_wider/Core/app_imports.dart';

class HealthOnlyStatusWidget extends StatelessWidget {
  final int questionNumber;
  final String questionText;
  final BookAppointmentProvider provider;
  final bool questionStatus;
  final Function(bool) onStatusChanged;

  const HealthOnlyStatusWidget({
    super.key,
    required this.questionNumber,
    required this.questionText,
    required this.provider,
    required this.questionStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$questionNumber. $questionText',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: questionStatus,
                onChanged: (bool? value) {
                  onStatusChanged(value ?? false);
                },
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return WColors.primary;
                    }
                    return const Color(0xFFE6EFF8);
                  },
                ),
              ),
              Text('Yes', style: Theme.of(context).textTheme.labelLarge),
              SizedBox(width: 10.h),
              Checkbox(
                value: !questionStatus,
                onChanged: (bool? value) {
                  onStatusChanged(!(value ?? false));
                },
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return WColors.primary;
                    }
                    return const Color(0xFFE6EFF8);
                  },
                ),
              ),
              Text('No', style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:beauty_wider/Core/app_imports.dart';

class HealthQuestionWidget extends StatelessWidget {
  final int questionNumber;
  final String questionText;
  final BookAppointmentProvider provider;
  final bool questionStatus;
  final String? questionField;
  final Function(bool) onStatusChanged;
  final Function(String) onFieldChanged;

  const HealthQuestionWidget({
    super.key,
    required this.questionNumber,
    required this.questionText,
    required this.provider,
    required this.questionStatus,
    required this.questionField,
    required this.onStatusChanged,
    required this.onFieldChanged,
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
          if (questionStatus)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'If so, please list:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 6.v),
                  Container(
                    height: WSizes.containerFieldHeight.v,
                    width: double.maxFinite,
                    decoration: WBoxDecoration.containerFieldDecoration,
                    child: TextFormField(
                      initialValue: questionField,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: '',
                      ),
                      onChanged: onFieldChanged,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

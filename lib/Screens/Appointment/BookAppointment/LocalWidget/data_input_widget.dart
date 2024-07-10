import 'package:beauty_wider/Core/app_imports.dart';

class DataInputWidget extends StatelessWidget {
  const DataInputWidget({
    super.key,
    required this.data,
    required this.title,
    required this.text,
    required this.provider,
  });

  final String? data;
  final String text;
  final String title;
  final BookAppointmentProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize),
          ),
          SizedBox(height: 6.v),
          Container(
            height: WSizes.containerFieldHeight.v,
            width: double.maxFinite,
            decoration: WBoxDecoration.containerFieldDecoration,
            child: TextFormField(
              initialValue: data,
              textCapitalization: TextCapitalization.values.first,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: text,
              ),
              onChanged: (value) {
                if (title == 'Weight') {
                  provider.setChosenWeight(value);
                } else if (title == 'Height') {
                  provider.setChosenHeight(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

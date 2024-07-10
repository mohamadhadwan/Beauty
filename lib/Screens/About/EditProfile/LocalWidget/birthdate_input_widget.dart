// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:intl/intl.dart';

class BirthdateInputWidget extends StatelessWidget {
  const BirthdateInputWidget({
    super.key,
    required this.context,
    required TextEditingController birthdate,
  }) : _birthdate = birthdate;

  final BuildContext context;
  final TextEditingController _birthdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.birthdate,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 6.v),
        Container(
          height: WSizes.containerFieldHeight.v,
          width: double.maxFinite,
          decoration: WBoxDecoration.containerFieldDecoration,
          child: TextFormField(
            controller: _birthdate,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                String formattedDate =
                DateFormat('dd MMMM yyyy').format(pickedDate);
                _birthdate.text = formattedDate;
              }
            },
            readOnly: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.birthdate,
              suffixIcon: const Icon(Icons.date_range),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocalizations.of(context)!.birthdate;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
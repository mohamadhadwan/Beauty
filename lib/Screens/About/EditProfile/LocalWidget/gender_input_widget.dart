import 'package:beauty_wider/Core/app_imports.dart';

class GenderInputWidget extends StatelessWidget {
  const GenderInputWidget({
    super.key,
    required this.context,
    required TextEditingController gender,
  }) : _gender = gender;

  final BuildContext context;
  final TextEditingController _gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.gender,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 6.v),
        Container(
          height: WSizes.containerFieldHeight.v,
          width: double.maxFinite,
          decoration: WBoxDecoration.containerFieldDecoration,
          child: TextFormField(
            controller: _gender,
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.selectGender,
                        style: Theme.of(context).textTheme.bodyLarge),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          GestureDetector(
                            child: Text(AppLocalizations.of(context)!.female,
                                style: Theme.of(context).textTheme.bodyMedium),
                            onTap: () {
                              Navigator.of(context).pop();
                              _gender.text = 'Female';
                            },
                          ),
                          const Padding(padding: EdgeInsets.all(8.0)),
                          GestureDetector(
                            child: Text(AppLocalizations.of(context)!.male,
                                style: Theme.of(context).textTheme.bodyMedium),
                            onTap: () {
                              Navigator.of(context).pop();
                              _gender.text = 'Male';
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            readOnly: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.gender,
              suffixIcon: const Icon(Icons.arrow_downward_rounded),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocalizations.of(context)!.gender;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
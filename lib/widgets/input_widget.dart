import 'package:beauty_wider/Core/app_imports.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required TextEditingController name,
    required String title,
    required String message,
  })  : _name = name,
        _title = title,
        _message = message;

  final TextEditingController _name;
  final String _title;
  final String _message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 6.v),
        Container(
          height: WSizes.containerFieldHeight.v,
          width: double.maxFinite,
          decoration: WBoxDecoration.containerFieldDecoration,
          child: TextFormField(
            controller: _name,
            textCapitalization: TextCapitalization.values.first,
            decoration: InputDecoration(
              hintText: _title,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (_title == 'Email') {
                if (value == null || value.isEmpty) {
                  return _message;
                }
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  return _message;
                }
                return null;
              } else if (value!.isEmpty) {
                return _message;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
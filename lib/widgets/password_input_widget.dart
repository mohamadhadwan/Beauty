import 'package:beauty_wider/Core/app_imports.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({
    super.key,
    required TextEditingController password,
    required String title,
    required String message,
    TextEditingController? passwordToCompare,
  })  : _message = message,
        _title = title,
        _password = password,
        _passwordToCompare = passwordToCompare;

  final String _title;
  final String _message;
  final TextEditingController _password;
  final TextEditingController? _passwordToCompare;

  @override
  PasswordInputWidgetState createState() => PasswordInputWidgetState();
}

class PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget._title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 6.v),
        Container(
          height: WSizes.containerFieldHeight.v,
          width: double.maxFinite,
          decoration: WBoxDecoration.containerFieldDecoration,
          child: TextFormField(
            controller: widget._password,
            textCapitalization: TextCapitalization.values.first,
            obscureText: _obscureText,
            decoration: InputDecoration(
              hintText: '************',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  _togglePasswordVisibility();
                },
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (widget._title == "Confirm Password") {
                if (widget._passwordToCompare?.text.trim() != widget._password.text.trim()) {
                  return AppLocalizations.of(context)!.passwordsDoNotMatch;
                } else if (value!.isEmpty) {
                  return widget._message;
                }
              } else if (value!.isEmpty) {
                return widget._message;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

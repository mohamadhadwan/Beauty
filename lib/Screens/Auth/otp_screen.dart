import 'package:beauty_wider/Core/app_imports.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String _otp = '';

  @override
  void initState() {
    super.initState();
    AuthenticationProvider().showOtp(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.otpVerification),
      ),
      body: Consumer<AuthenticationProvider>(
          builder: (context, auth, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (auth.resMessage != '') {
                showSnackMessage(
                    message: auth.resMessage, context: context);
                auth.clear();
              }
            });
            return Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 31.h,
                vertical: 45.v,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/beauty_wider_logo.png',
                    height: 159.v,
                    width: 254.h,
                  ),
                  SizedBox(height: 37.v),
                  SizedBox(
                    height: 70.v,
                    width: 320.h,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                              AppLocalizations.of(context)!.otpVerification,
                              style: Theme.of(context).textTheme.headlineMedium
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            AppLocalizations.of(context)!
                                .enterTheCodeSentToYourPhoneNumber,
                            style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.v),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    appContext: context,
                    length: 6,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 53.v,
                      fieldWidth: 46.h,
                      selectedFillColor: WColors.primary,
                      activeFillColor: WColors.primary,
                      inactiveFillColor: WColors.primary,
                      activeColor: WColors.primary,
                      inactiveColor: WColors.primary,
                      selectedColor: WColors.primary,
                    ),
                    backgroundColor: Colors.white,
                    cursorColor: WColors.primary,
                    onChanged: (value) {
                      _otp = value;
                    },
                    onCompleted: (value) {
                      _otp = value;
                      auth.verifyOtp(otp: _otp,
                          context: context);
                    },
                  ),
                  SizedBox(height: 61.v),
                  ElevatedButton(
                    onPressed: () => auth.verifyOtp(otp: _otp, context: context),
                    child: Text(
                        AppLocalizations.of(context)!.verify
                    ),
                  ),
                  SizedBox(height: 14.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.didntReceiveTheCode,
                          style: Theme.of(context).textTheme.bodyMedium),
                      InkWell(
                        onTap: () {
                          print('hi');
                          auth.resendOtp(context: context);
                          auth.showOtp1(context: context);
                        },
                        child: Text(' ${AppLocalizations.of(context)!.resendCode}',
                            style: Theme.of(context).textTheme.titleLarge),
                      )
                    ],
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            );
          }),
    );
  }
}

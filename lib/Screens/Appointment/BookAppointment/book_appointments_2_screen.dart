// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';

class BookAppointments2Screen extends StatefulWidget {
  const BookAppointments2Screen({super.key});
  @override
  State<BookAppointments2Screen> createState() =>
      _BookAppointments2ScreenState();
}

class _BookAppointments2ScreenState extends State<BookAppointments2Screen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  bool canPressNext(BookAppointmentProvider provider) {
    bool heightWeightChosen = !provider.heightField.isEmptyOrNull && !provider.weightField.isEmptyOrNull;
    bool questionsValid = true;

    List<bool> conditions = [
      !provider.question1Status || (provider.question1Status && !provider.question1Field.isEmptyOrNull),
      !provider.question2Status || (provider.question2Status && !provider.question2Field.isEmptyOrNull),
      !provider.question3Status || (provider.question3Status && !provider.question3Field.isEmptyOrNull),
      !provider.question4Status || (provider.question4Status && !provider.question4Field.isEmptyOrNull),

      !provider.question6Status || (provider.question6Status && !provider.question6Field.isEmptyOrNull),
      !provider.question7Status || (provider.question7Status && !provider.question7Field.isEmptyOrNull),
      !provider.question8Status || (provider.question8Status && !provider.question8Field.isEmptyOrNull),
    ];

    for (bool condition in conditions) {
      if (!condition) {
        questionsValid = false;
        break;
      }
    }

    return heightWeightChosen && questionsValid;
  }

  List<String> skinTypes = ['Dry', 'Normal', 'Oily', 'Combination'];
  List<String> skinSensitivities = ['Normal', 'Sensitive', 'Very sensitive'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card consultation'),
      ),
      body: Consumer<BookAppointmentProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DataInputWidget(provider: provider, title: "Height", text: "Height in cm", data: provider.heightField),
              SizedBox(height: 20.v),
              DataInputWidget(provider: provider, title: "Weight", text: "Weight in kg", data: provider.weightField),
              SizedBox(height: 20.v),
              DataRowWidget(
                provider: provider,
                items: skinTypes,
                selectedIndex: provider.selectedSkinType == 'Dry' ? 0
                    : provider.selectedSkinType == 'Normal' ? 1
                    : provider.selectedSkinType == 'Oily' ? 2
                    : 3,
                onSelect: (index) {
                  provider.setSelectedSkinType(skinTypes[index]);
                },
                title: 'Skin Type',
                static: true,
              ),
              SizedBox(height: 20.v),
              DataRowWidget(
                provider: provider,
                items: skinSensitivities,
                selectedIndex: provider.selectedSkinSensitivity == 'Normal' ? 0
                    : provider.selectedSkinSensitivity == 'Sensitive' ? 1
                    : 2,
                onSelect: (index) {
                  provider.setSelectedSkinSensitivity(skinSensitivities[index]);
                },
                title: 'Skin Sensitivity',
                static: true,
              ),
              SizedBox(height: 20.v),
              HealthQuestionWidget(
                questionNumber: 1,
                questionText: 'Do you have any chronic medical conditions?',
                provider: provider,
                questionStatus: provider.question1Status,
                questionField: provider.question1Field,
                onStatusChanged: (bool value) {
                  setState(() {
                    provider.setQuestion1Status(value);
                  });
                },
                onFieldChanged: (String value) {
                  provider.setQuestion1Field(value);
                },
              ),
              SizedBox(height: 20.v),
              HealthQuestionWidget(
                questionNumber: 2,
                questionText: 'Do you have pacemaker?',
                provider: provider,
                questionStatus: provider.question2Status,
                questionField: provider.question2Field,
                onStatusChanged: (bool value) {
                  setState(() {
                    provider.setQuestion2Status(value);
                  });
                },
                onFieldChanged: (String value) {
                  provider.setQuestion2Field(value);
                },
              ),
              SizedBox(height: 20.v),
              HealthQuestionWidget(
                questionNumber: 3,
                questionText: 'Do you have any hormones imbalances?',
                provider: provider,
                questionStatus: provider.question3Status,
                questionField: provider.question3Field,
                onStatusChanged: (bool value) {
                  setState(() {
                    provider.setQuestion3Status(value);
                  });
                },
                onFieldChanged: (String value) {
                  provider.setQuestion3Field(value);
                },
              ),
              SizedBox(height: 20.v),
              HealthQuestionWidget(
                questionNumber: 4,
                questionText: 'Do you have any metal or medical devices implanted?',
                provider: provider,
                questionStatus: provider.question4Status,
                questionField: provider.question4Field,
                onStatusChanged: (bool value) {
                  setState(() {
                    provider.setQuestion4Status(value);
                  });
                },
                onFieldChanged: (String value) {
                  provider.setQuestion4Field(value);
                },
              ),
              SizedBox(height: 20.v),
              HealthOnlyStatusWidget(
                questionNumber: 5,
                questionText: 'Do you have any problem with thyroid gland?',
                provider: provider,
                questionStatus: provider.question5Status,
                onStatusChanged: (bool value) {
                  setState(() {
                    provider.setQuestion5Status(value);
                  });
                },
              ),
              SizedBox(height: 20.v),
              HealthQuestionWidget(
                questionNumber: 6,
                questionText: 'Do you have any allergies? ',
                provider: provider,
                questionStatus: provider.question6Status,
                questionField: provider.question6Field,
                onStatusChanged: (bool value) {
                  setState(() {
                    provider.setQuestion6Status(value);
                  });
                },
                onFieldChanged: (String value) {
                  provider.setQuestion6Field(value);
                },
              ),
              SizedBox(height: 20.v),
              HealthQuestionWidget(
                questionNumber: 7,
                questionText: 'Do you have any skin problems?',
                provider: provider,
                questionStatus: provider.question7Status,
                questionField: provider.question7Field,
                onStatusChanged: (bool value) {
                  setState(() {
                    provider.setQuestion7Status(value);
                  });
                },
                onFieldChanged: (String value) {
                  provider.setQuestion7Field(value);
                },
              ),
              SizedBox(height: 20.v),
              HealthQuestionWidget(
                questionNumber: 8,
                questionText: 'Do you take any medications or supplements? ',
                provider: provider,
                questionStatus: provider.question8Status,
                questionField: provider.question8Field,
                onStatusChanged: (bool value) {
                  setState(() {
                    provider.setQuestion8Status(value);
                  });
                },
                onFieldChanged: (String value) {
                  provider.setQuestion8Field(value);
                },
              ),
              SizedBox(height: 20.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.h),
                child: ElevatedButton(
                    onPressed: canPressNext(provider) ? () {
                        PageNavigator(ctx: context).nextPage(page: const BookAppointments3Screen());
                    } : null,
                    child: const Text('Next')),
              ),
              SizedBox(height: 20.v),
            ],
          );
        },
      ),
    );
  }
}
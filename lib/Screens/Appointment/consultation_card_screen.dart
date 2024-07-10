// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});
  @override
  State<ConsultationScreen> createState() =>
      _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BookAppointmentProvider provider = Provider.of<BookAppointmentProvider>(context, listen: false);
      provider.resetSelections();
    });
  }

  @override
  void dispose() {
    height.clear();
    weight.clear();
    super.dispose();
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
              buildHeightField(provider),
              SizedBox(height: 20.v),
              buildWeightField(provider),
              SizedBox(height: 20.v),
              buildSkinTypesList(provider),
              SizedBox(height: 20.v),
              buildSkinSensitivityList(provider),
              SizedBox(height: 20.v),
              HealthQuestionWidget(
                questionNumber: 1,
                questionText: 'Do you have any chronic medical conditions?',
                provider: provider,
                questionStatus: provider.question1Status,
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
              buildSaveButton(provider),
              SizedBox(height: 20.v),
            ],
          );
        },
      ),
    );
  }

  Widget buildHeightField(BookAppointmentProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Height',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize),
          ),
          SizedBox(height: 6.v),
          Container(
            height: WSizes.containerFieldHeight.v,
            width: double.maxFinite,
            decoration: WBoxDecoration.containerFieldDecoration,
            child: TextField(
              controller: height,
              textCapitalization: TextCapitalization.values.first,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Height in cm',
              ),
              onChanged: (value) {
                provider.setChosenHeight(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWeightField(BookAppointmentProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weight',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize),
          ),
          SizedBox(height: 6.v),
          Container(
            height: WSizes.containerFieldHeight.v,
            width: double.maxFinite,
            decoration: WBoxDecoration.containerFieldDecoration,
            child: TextField(
              controller: weight,
              textCapitalization: TextCapitalization.values.first,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Weight in kg',
              ),
              onChanged: (value) {
                provider.setChosenWeight(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSkinTypesList(BookAppointmentProvider provider) {
    List<String> skinTypes = ['Dry', 'Normal', 'Oily', 'Combination'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Skin Type',
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize)),
          SizedBox(height: 10.v),
          SizedBox(
            height: 30.v,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 10.h),
              scrollDirection: Axis.horizontal,
              itemCount: skinTypes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    provider.setSelectedSkinType(skinTypes[index]);
                  },
                  child: Container(
                      height: 30.v,
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      alignment: Alignment.center,
                      decoration: provider.selectedSkinType == skinTypes[index]
                          ? WBoxDecoration.containerLabelDarkDecoration
                          : WBoxDecoration.containerLabelLightDecoration,
                      child: Text(skinTypes[index],
                          style: TextStyle(
                              color:
                                  provider.selectedSkinType == skinTypes[index]
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

  Widget buildSkinSensitivityList(BookAppointmentProvider provider) {
    List<String> skinSensitivities = ['Normal', 'Sensitive', 'Very sensitive'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Skin Sensitivity',
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize)),
          SizedBox(height: 10.v),
          SizedBox(
            height: 30.v,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 10.h),
              scrollDirection: Axis.horizontal,
              itemCount: skinSensitivities.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    provider
                        .setSelectedSkinSensitivity(skinSensitivities[index]);
                  },
                  child: Container(
                      height: 30.v,
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      alignment: Alignment.center,
                      decoration: provider.selectedSkinSensitivity ==
                              skinSensitivities[index]
                          ? WBoxDecoration.containerLabelDarkDecoration
                          : WBoxDecoration.containerLabelLightDecoration,
                      child: Text(skinSensitivities[index],
                          style: TextStyle(
                              color: provider.selectedSkinSensitivity ==
                                      skinSensitivities[index]
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

  Widget buildSaveButton(BookAppointmentProvider provider) {
    String appointmentId = Provider.of<AppointmentProvider>(context, listen: false).appointmentId;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
          onPressed: () {
            if (canPressNext(provider)) {
              provider.addConsultationCard(context: context, appointmentId: appointmentId);
            }
          },
          child: const Text('Save')),
    );
  }
}

class HealthQuestionWidget extends StatelessWidget {
  final int questionNumber;
  final String questionText;
  final BookAppointmentProvider provider;
  final bool questionStatus;
  final String ifSoText;
  final Function(bool) onStatusChanged;
  final Function(String) onFieldChanged;

  const HealthQuestionWidget({
    super.key,
    required this.questionNumber,
    required this.questionText,
    required this.provider,
    required this.questionStatus,
    this.ifSoText = 'If so, please list:',
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
                    ifSoText,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 6.v),
                  Container(
                    height: WSizes.containerFieldHeight.v,
                    width: double.maxFinite,
                    decoration: WBoxDecoration.containerFieldDecoration,
                    child: TextFormField(
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

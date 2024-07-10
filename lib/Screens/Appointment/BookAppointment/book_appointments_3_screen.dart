// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:intl/intl.dart';

class BookAppointments3Screen extends StatefulWidget {
  const BookAppointments3Screen({super.key});
  @override
  State<BookAppointments3Screen> createState() => _BookAppointments3ScreenState();
}

class _BookAppointments3ScreenState extends State<BookAppointments3Screen> {
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    remarkController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bookAppointment),
      ),
      body: Consumer<BookAppointmentProvider>(
        builder: (context, bookAppointment, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (bookAppointment.resMessage != '') {
              showSnackMessage(message: bookAppointment.resMessage, context: context);
              bookAppointment.clear();
            }
          });

          String date = '';

          try{
            date = DateFormat('dd MMMM yyyy').format(bookAppointment.selectedDate);
          } catch (e){
            date = '';
          }

          OurServiceProvider serviceProvider = Provider.of<OurServiceProvider>(context, listen: false);

          return Center(
            child: Column(
              children: [
                SizedBox(height: 20.v),
                Container(
                  width: 329.v,
                  height: 38.h,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.h, color: WColors.primary),
                      borderRadius: BorderRadius.circular(16.adaptSize),
                    ),
                  ),
                  child: Text(serviceProvider.services[serviceProvider.selectedServiceIndex].name,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.fSize)),
                ),
                SizedBox(height: 60.v),
                Container(
                  height: 385.v,
                  width: 329.h,
                  decoration: WBoxDecoration.containerDataLightDecoration,
                  child: Padding(
                    padding: EdgeInsets.all(23.adaptSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w800, color: WColors.primary, height: 2.v),
                            children: [
                              const TextSpan(text: 'Branch: '),
                              TextSpan(
                                  text: '${bookAppointment.clinicBranches[bookAppointment.selectedBranchIndex].name}\n',
                                  style: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w400, color: Colors.black, height: 2.v)),
                              const TextSpan(text: 'Technician: '),
                              TextSpan(
                                  text: '${bookAppointment.clinicBranches[bookAppointment.selectedBranchIndex].technicians[bookAppointment.selectedTechnicianIndex].name}\n',
                                  style: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w400, color: Colors.black, height: 2.v)),
                              const TextSpan(text: 'Date: '),
                              TextSpan(
                                  text: '$date\n',
                                  style: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w400, color: Colors.black, height: 2.v)),
                              const TextSpan(text: 'Time: '),
                              TextSpan(
                                  text: '${bookAppointment.selectedTime}',
                                  style: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w400, color: Colors.black)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.v),
                        Text('Add your remark',
                            style: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w800, color: WColors.primary)),
                        Container(
                          height: 52.v,
                          width: 284.h,
                          padding: EdgeInsetsDirectional.only(start: 8.h),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.v),
                          decoration: WBoxDecoration.containerDataDarkDecoration.copyWith(color: Colors.white),
                          child: TextField(
                            controller: remarkController,
                            maxLines:
                            null,
                            keyboardType: TextInputType
                                .multiline,
                            decoration: InputDecoration(
                              hintText:
                              "Add your remark here...",
                              border:
                              InputBorder.none,
                              hintStyle: const TextStyle(color: WColors.secondary2),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.h,
                                  vertical: 5.v),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.v),
                        Center(child: SizedBox(
                          height: 31.v,
                          width: 194.h,
                          child: bookAppointment.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                              onPressed: () {
                                hideKeyboard(context);
                                bookAppointment.createAppointment(remark: remarkController.text,
                                    serviceId: serviceProvider.services[serviceProvider.selectedServiceIndex].id, context: context);
                              },
                              child: const Text('Book Appointment')),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
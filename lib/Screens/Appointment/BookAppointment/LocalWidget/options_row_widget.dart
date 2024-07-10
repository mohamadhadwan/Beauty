import 'package:beauty_wider/Core/app_imports.dart';

class OptionsRowWidget extends StatelessWidget {
  const OptionsRowWidget({
    super.key,
    required this.provider,
    required this.items,
    required this.selectedIndices,
    required this.onSelect,
    required this.title,
  });

  final BookAppointmentProvider provider;
  final List<dynamic> items;
  final List<int>? selectedIndices;
  final Function(int) onSelect;
  final String title;

  @override
  Widget build(BuildContext context) {
    if(items.isEmpty){
      return Container();

    }
    return Padding(
      padding: EdgeInsets.fromLTRB(23.h, 0, 23.h, 20.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.fSize)),
          SizedBox(height: 10.v),
          SizedBox(
            height: 30.v,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 10.h),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onSelect(index);
                  },
                  child: Container(
                      height: 30.v,
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      alignment: Alignment.center,
                      decoration: selectedIndices != null && selectedIndices!.contains(index)
                          ? WBoxDecoration.containerLabelDarkDecoration
                          : WBoxDecoration.containerLabelLightDecoration,
                      child: Text(items[index].tag,
                          style: TextStyle(
                              color: selectedIndices != null && selectedIndices!.contains(index)
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
}
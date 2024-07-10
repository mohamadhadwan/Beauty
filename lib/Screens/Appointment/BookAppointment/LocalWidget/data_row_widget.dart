import 'package:beauty_wider/Core/app_imports.dart';

class DataRowWidget extends StatelessWidget {
  const DataRowWidget({
    super.key,
    required this.provider,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
    required this.title,
    this.static = false,
  });

  final BookAppointmentProvider provider;
  final dynamic items;
  final int selectedIndex;
  final Function(int) onSelect;
  final String title;
  final bool static;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
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
                      decoration: selectedIndex == index
                          ? WBoxDecoration.containerLabelDarkDecoration
                          : WBoxDecoration.containerLabelLightDecoration,
                      child: Text(static ? items[index] : items[index].name,
                          style: TextStyle(
                              color: selectedIndex == index ? white : black))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

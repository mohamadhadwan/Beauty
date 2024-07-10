import '../../../Core/app_imports.dart';

class TabWidget extends StatelessWidget {
  final String tab;
  final String label;
  final bool isSelected;
  final Function(String) onTap;

  const TabWidget({super.key,
    required this.tab,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(tab),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: isSelected ? WColors.primary : Colors.grey.shade100,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : WColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

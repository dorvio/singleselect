import 'package:flutter/material.dart';

class DropDownItem extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final bool isSelected;
  final Color color;
  final Color textColor;
  final VoidCallback? onSelected;

  const DropDownItem({
    super.key,
    required this.text,
    this.iconData,
    required this.isSelected,
    this.color = Colors.grey,
    this.textColor = Colors.black,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSelected,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? lightenColor(color)
              : color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            if (iconData != null)
              Icon(iconData, color: Colors.black),
          ],
        ),
      ),
    );
  }
}


Color lightenColor(Color color, [double amount = 0.2]) {
  assert(amount >= 0.0 && amount <= 1.0);

  int r = (color.red * (1 + amount)).toInt();
  int g = (color.green * (1 + amount)).toInt();
  int b = (color.blue * (1 + amount)).toInt();

  return Color.fromRGBO(r, g, b, color.opacity);
}
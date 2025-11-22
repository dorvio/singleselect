import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drop_down_item.dart';

class SingleDropDown extends StatefulWidget {
  final double itemHeight;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final List<String> itemsText;
  final List<IconData>? itemIcons;
  final String? initialValue;
  final Function(String)? onSelectionChange;

  const SingleDropDown({
    Key? key,
    this.itemHeight = 20.0,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.black,
    this.borderRadius = 0.0,
    required this.itemsText,
    this.itemIcons,
    this.initialValue,
    this.onSelectionChange,
  }) : super(key: key);

  @override
  State<SingleDropDown> createState() => _SingleDropDownState();
}

class _SingleDropDownState extends State<SingleDropDown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 30,
      color: widget.backgroundColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(widget.itemsText.length, (index) {
              final text = widget.itemsText[index];
              final icon = widget.itemIcons != null
                  ? widget.itemIcons![index]
                  : null;

              return DropDownItem(
                text: text,
                iconData: icon,
                isSelected: selectedValue == text,
                color: widget.backgroundColor,
                textColor: widget.textColor,
                onSelected: () {
                  setState(() {
                    selectedValue = text;
                  });
                  widget.onSelectionChange?.call(selectedValue);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

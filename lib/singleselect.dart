library singleselect;

import 'package:flutter/material.dart';
import 'package:singleselect/single_drop_down.dart';


class SingleSelectFormField extends FormField<String> {
  final List<String> items;
  final String? labelText;
  final TextStyle labelStyle;
  final Color backgroundColor;
  final Color optionListBackgroundColor;
  final Color optionListTextColor;
  final double optionListBorderRadius;
  final InputDecoration? inputDecoration;

  SingleSelectFormField({
    Key? key,
    required this.items,
    this.labelText,
    this.labelStyle = const TextStyle(color: Colors.black),
    this.backgroundColor = Colors.white,
    this.optionListBackgroundColor = Colors.grey,
    this.optionListTextColor = Colors.black,
    this.optionListBorderRadius = 8.0,
    this.inputDecoration,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
    key: key,
    initialValue: initialValue,
    onSaved: onSaved,
    validator: validator,
    autovalidateMode: autovalidateMode,
    builder: (FormFieldState<String> state) {
      return _SingleSelectFieldWidget(
        state: state,
        items: items,
        labelText: labelText,
        labelStyle: labelStyle,
        backgroundColor: backgroundColor,
        optionListBackgroundColor: optionListBackgroundColor,
        optionListTextColor: optionListTextColor,
        optionListBorderRadius: optionListBorderRadius,
        inputDecoration: inputDecoration,
      );
    },
  );
}

class _SingleSelectFieldWidget extends StatefulWidget {
  final FormFieldState<String> state;
  final List<String> items;
  final String? labelText;
  final TextStyle labelStyle;
  final Color backgroundColor;
  final Color optionListBackgroundColor;
  final Color optionListTextColor;
  final double optionListBorderRadius;
  final InputDecoration? inputDecoration;

  const _SingleSelectFieldWidget({
    Key? key,
    required this.state,
    required this.items,
    this.labelText,
    required this.labelStyle,
    required this.backgroundColor,
    required this.optionListBackgroundColor,
    required this.optionListTextColor,
    required this.optionListBorderRadius,
    this.inputDecoration,
  }) : super(key: key);

  @override
  __SingleSelectFieldWidgetState createState() => __SingleSelectFieldWidgetState();
}

class __SingleSelectFieldWidgetState extends State<_SingleSelectFieldWidget> {
  bool isDropdownOpened = false;
  late OverlayEntry overlayEntry;
  final GlobalKey actionKey = GlobalKey();

  void toggleDropdown() {
    if (isDropdownOpened) {
      overlayEntry.remove();
      isDropdownOpened = false;
    } else {
      final renderBox = actionKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final offset = renderBox.localToGlobal(Offset.zero);
        overlayEntry = _createOverlay(offset.dx, offset.dy + renderBox.size.height, renderBox.size.width);
        Overlay.of(context)!.insert(overlayEntry);
        isDropdownOpened = true;
      }
    }
  }

  OverlayEntry _createOverlay(double x, double y, double width) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: x,
        top: y,
        width: width,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(widget.optionListBorderRadius),
          child: Container(
            decoration: BoxDecoration(
              color: widget.optionListBackgroundColor,
              borderRadius: BorderRadius.circular(widget.optionListBorderRadius),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.items.map((item) {
                return ListTile(
                  title: Text(
                    item,
                    style: TextStyle(color: widget.optionListTextColor),
                  ),
                  onTap: () {
                    widget.state.didChange(item);
                    toggleDropdown();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: toggleDropdown,
      child: InputDecorator(
        decoration: widget.inputDecoration ?? InputDecoration(
          labelText: widget.labelText,
          labelStyle: widget.labelStyle,
          filled: true,
          fillColor: widget.backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorText: widget.state.errorText,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.state.value ?? widget.labelText,
              style: widget.state.value == null
                  ? widget.labelStyle
                  : widget.labelStyle.copyWith(color: Colors.black),
            ),
            Icon(
              isDropdownOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
library singleselect;

import 'package:flutter/material.dart';
import 'package:singleselect/single_drop_down.dart';


class SingleSelectFormField extends FormField<String> {
  final List<String> items;
  final String? labelText;
  final TextStyle labelStyle;
  final TextStyle selectedTextStyle;
  final Color backgroundColor;
  final Color optionListBackgroundColor;
  final Color optionListTextColor;
  final double optionListBorderRadius;
  final InputDecoration? inputDecoration;
  final TextEditingController? controller;

  SingleSelectFormField({
    Key? key,
    required this.items,
    this.labelText,
    this.labelStyle = const TextStyle(color: Colors.black),
    this.selectedTextStyle = const TextStyle(color: Colors.black),
    this.backgroundColor = Colors.white,
    this.optionListBackgroundColor = Colors.grey,
    this.optionListTextColor = Colors.black,
    this.optionListBorderRadius = 8.0,
    this.inputDecoration,
    this.controller,
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
        controller: controller,
        labelText: labelText,
        labelStyle: labelStyle,
        backgroundColor: backgroundColor,
        optionListBackgroundColor: optionListBackgroundColor,
        optionListTextColor: optionListTextColor,
        optionListBorderRadius: optionListBorderRadius,
        inputDecoration: inputDecoration,
        selectedTextStyle: selectedTextStyle,
      );
    },
  );
}

class _SingleSelectFieldWidget extends StatefulWidget {
  final FormFieldState<String> state;
  final List<String> items;
  final String? labelText;
  final TextStyle labelStyle;
  final TextStyle selectedTextStyle;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
  final Color backgroundColor;
  final Color optionListBackgroundColor;
  final Color optionListTextColor;
  final double optionListBorderRadius;
  final InputDecoration? inputDecoration;
  final TextEditingController? controller;

  const _SingleSelectFieldWidget({
    Key? key,
    required this.state,
    required this.items,
    this.labelText,
    required this.selectedTextStyle,
    required this.labelStyle,
    required this.backgroundColor,
    required this.optionListBackgroundColor,
    required this.optionListTextColor,
    required this.optionListBorderRadius,
    this.inputDecoration,
    this.controller,
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
      setState(() {
        isDropdownOpened = false;
      });
    } else {
      final renderBox =
      actionKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final offset = renderBox.localToGlobal(Offset.zero);
        overlayEntry = _createOverlay(
          offset.dx,
          offset.dy + renderBox.size.height,
          renderBox.size.width,
        );
        Overlay.of(context)!.insert(overlayEntry);
        setState(() {
          isDropdownOpened = true;
        });
      }
    }
  }

  InputDecoration _effectiveDecoration() {
    final base = widget.inputDecoration ?? const InputDecoration();

    final enabled =
        base.enabledBorder ?? base.border ?? const UnderlineInputBorder();

    final focused =
        base.focusedBorder ?? base.border ?? const UnderlineInputBorder();

    final currentBorder = isDropdownOpened ? focused : enabled;

    return base.copyWith(
      border: currentBorder,
      enabledBorder: currentBorder,
      focusedBorder: currentBorder,
    );
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
                    if(widget.controller != null) {
                      widget.controller!.text = item;
                    }
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

    final bool isEmpty = widget.state.value == null || widget.state.value!.isEmpty;

    return GestureDetector(
      key: actionKey,
      onTap: toggleDropdown,
      child: InputDecorator(
        isFocused: isDropdownOpened,
        isEmpty: isEmpty,
        decoration: _effectiveDecoration().copyWith(
          errorText: widget.state.errorText,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isEmpty ? "" : widget.state.value!,
              style: widget.selectedTextStyle,
            ),
            Icon(
              isDropdownOpened
                  ? Icons.arrow_drop_up
                  : Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
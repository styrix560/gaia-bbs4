import "package:flutter/material.dart";

class CustomMenuButton<T extends Enum> extends StatelessWidget {
  const CustomMenuButton(
    this.initialValue,
    this.menuItems,
    this.getName,
    this.onChanged, {
    this.disabled,
    super.key,
  });

  final T initialValue;
  final List<T> menuItems;
  final String Function(T) getName;
  final void Function(T?) onChanged;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: initialValue,
      focusColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      items: <DropdownMenuItem<T>>[
        for (final T priceType in menuItems)
          DropdownMenuItem(
            value: priceType,
            child: Text(getName(priceType)),
          ),
      ],
      onChanged: disabled ?? false ? null : onChanged,
    );
  }
}

// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';

class CustomDropdownList extends StatefulWidget {
  final String label;
  final List<String> items;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final Color color;

  const CustomDropdownList({
    super.key,
    required this.label,
    required this.items,
    required this.hint,
    required this.icon,
    this.controller,
    this.color = const Color.fromARGB(255, 255, 255, 255),
    required Null Function(dynamic value) onChanged,
  });

  @override
  _CustomDropdownListState createState() => _CustomDropdownListState();
}

class _CustomDropdownListState extends State<CustomDropdownList> {
  @override
  Widget build(BuildContext context) {
    // Determine selected item from controller
    String? currentValue =
        (widget.controller?.text.isNotEmpty ?? false) &&
                widget.items.contains(widget.controller!.text)
            ? widget.controller!.text
            : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        DropdownButtonFormField<String>(
          value: currentValue,
          hint: Text(widget.hint),
          icon: Icon(widget.icon, color: Colors.black45),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.15),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
          items:
              widget.items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (widget.controller != null) {
                widget.controller!.text = newValue ?? '';
              }
            });
          },
        ),
      ],
    );
  }
}

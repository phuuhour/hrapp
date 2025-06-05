// ignore_for_file: file_names, deprecated_member_use, library_private_types_in_public_api

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final Widget icon;
  final bool isPassword;
  final bool isDate;
  final bool lendingIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Color color;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.isDate = false,
    this.lendingIcon = true,
    this.controller,
    required this.hint,
    required this.keyboardType,
    this.color = const Color.fromARGB(255, 255, 255, 255),
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  // Function to select a date
  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && widget.controller != null) {
      // This will show the date in the input field
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        widget.controller!.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          readOnly: widget.isDate,
          onTap:
              widget.isDate ? () => _selectDate(context, DateTime.now()) : null,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blue.withOpacity(0.15),
            hintText: widget.hint,
            hintStyle: const TextStyle(fontSize: 15, color: Colors.black54),
            prefixIcon: widget.lendingIcon ? widget.icon : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Boxicons.bxs_show : Boxicons.bxs_hide,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : widget.isDate
                    ? IconButton(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      onPressed: () => _selectDate(context, DateTime.now()),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final List<String> items;
  final IconData icon;
  final String? selectedValue;
  final Function(String?) onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.icon,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 192, 230, 255),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedValue,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
              iconSize: 30,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              dropdownColor: Colors.white,
              items:
                  widget.items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
                widget.onChanged(newValue);
              },
            ),
          ),
        ),
      ],
    );
  }
}

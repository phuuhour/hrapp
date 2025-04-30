// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Customsearch extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const Customsearch({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  State<Customsearch> createState() => _CustomsearchState();
}

class _CustomsearchState extends State<Customsearch> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onSearch,
      decoration: InputDecoration(
        hintText: "ស្វែងរក...",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
        prefixIcon: const Icon(Icons.search, color: Colors.blue, size: 30),
        suffixIcon:
            widget.controller.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.blue, size: 25),
                  onPressed: () {
                    widget.controller.clear();
                    widget.onSearch(""); // Clear search results
                  },
                )
                : null,
        filled: true,
        fillColor: const Color.fromARGB(255, 192, 230, 255),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

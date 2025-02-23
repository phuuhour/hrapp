import 'package:flutter/material.dart';

Future<void> showCustomOptionDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
              ),
              child: Text(
                'ត្រឡប់',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pop('បញ្ឈប់');
                },
                text: 'បញ្ឈប់ពីការងារ',
                color: Colors.red,
              ),
              const SizedBox(height: 10),
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pop('កែប្រែព័ត៌មាន');
                },
                text: 'កែប្រែព័ត៌មាន',
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pop('រាយការណ៍');
                },
                text: 'រាយការណ៍',
                color: Colors.green,
              ),
            ],
          ),
        ),
      );
    },
  );
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

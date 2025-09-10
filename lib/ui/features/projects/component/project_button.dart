import 'package:flutter/material.dart';

class ProjectButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  final countValue = 250;

  const ProjectButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(
                  countValue.toString(),
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
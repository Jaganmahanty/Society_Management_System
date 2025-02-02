import 'package:flutter/material.dart';
import 'package:society_management_system/common/global_section/colors.dart';

class QuickAccessItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const QuickAccessItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 231, 230, 230),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: primaryColor,size: 27),
          ),
        ),
        const SizedBox(height: 5),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}

// Main reusable QuickAccess widget
class QuickAccessMenu extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const QuickAccessMenu(
      {super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          const SizedBox(height: 7),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              return QuickAccessItem(
                icon: item['icon'],
                title: item['title'],
                onPressed: item['onPressed'],
              );
            }).toList(),
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}

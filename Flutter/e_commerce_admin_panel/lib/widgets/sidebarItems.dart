import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.selected,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: selected ? Colors.grey.shade300 : Colors.transparent,
      leading: Icon(
        icon,
        color: Colors.black,
        size: 18,
        weight: selected ? 1200 : 400,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 12
        ),
      ),
      onTap: onTap,
      selected: selected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

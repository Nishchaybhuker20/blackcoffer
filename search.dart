import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final TextEditingController controller;
  final IconData suffixIcon;

  const SearchBar({
    Key? key,
    required this.context,
    required this.onChanged,
    required this.onClear,
    required this.controller,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.all(8),
              hintText: "Search",
              fillColor: Colors.grey.withOpacity(0.5),
              filled: true,
              suffixIcon: IconButton(
                onPressed: onClear,
                icon: Icon(
                  suffixIcon,
                  color:
                      (suffixIcon == Icons.search) ? Colors.grey : Colors.blue,
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

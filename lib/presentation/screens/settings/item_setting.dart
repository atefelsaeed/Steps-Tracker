import 'package:flutter/material.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting({
    super.key,
    required this.child,
    required this.iconData,
    required this.callback,
  });

  final Widget child;
  final IconData iconData;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(
              width: 10,
            ),
            child
          ],
        ),
      ),
    );
  }
}

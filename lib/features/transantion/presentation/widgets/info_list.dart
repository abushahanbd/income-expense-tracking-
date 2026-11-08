import 'package:flutter/material.dart';

class InfoTileList extends StatelessWidget {
  final List<InfoTileItem> items;

  const InfoTileList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: const Color(0xFF1E293B),
                    size: 20.0,
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    item.value,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
            if (index < items.length - 1)
              const Divider(
                color: Color(0xFFF1F5F9),
                height: 1.0,
                thickness: 1.0,
              ),
          ],
        );
      }),
    );
  }
}

class InfoTileItem {
  final IconData icon;
  final String label;
  final String value;

  const InfoTileItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}

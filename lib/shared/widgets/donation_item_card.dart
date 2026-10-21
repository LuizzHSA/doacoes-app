import 'package:flutter/material.dart';

import '../models/donation_item.dart';

class DonationItemCard extends StatelessWidget {
  const DonationItemCard({super.key, required this.item, this.onTap});

  final DonationItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      onTap: onTap,
      leading: const CircleAvatar(
        child: Icon(Icons.volunteer_activism_outlined),
      ),
      title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          item.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}
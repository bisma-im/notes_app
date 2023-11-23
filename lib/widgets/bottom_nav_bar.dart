import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final int complete;
  final int pending;
  final int archive;
  final int all;

  const BottomNavBar({super.key, required this.selectedIndex, required this.complete, required this.pending, required this.archive, required this.all, required this.onItemTapped});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: badges.Badge(
            badgeContent: Text(
              widget.all.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: const Icon(Icons.home),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: badges.Badge(
            badgeContent: Text(
              widget.complete.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: const Icon(Icons.done_all),
          ),
          label: 'Complete',
        ),
        BottomNavigationBarItem(
          icon: badges.Badge(
            badgeContent: Text(
              widget.pending.toString(),
              style: const TextStyle(color: Colors.white),
            ),
              child: const Icon(Icons.pending),
          ),
          label: 'Pending',
        ),
        BottomNavigationBarItem(
          icon: badges.Badge(
            badgeContent: Text(
              widget.archive.toString(),
              style: const TextStyle(color: Colors.white),
            ),
              child: const Icon(Icons.archive)),
          label: 'Archive',
        ),
      ],
      currentIndex: widget.selectedIndex,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      iconSize: 30.0,
      selectedFontSize: 20.0,
      onTap: widget.onItemTapped,
    );
  }
}

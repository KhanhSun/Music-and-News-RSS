import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class MainNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MainNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surface,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note_rounded),
          label: 'Music',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_rounded),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music_rounded),
          label: 'Library',
        ),
      ],
    );
  }
}

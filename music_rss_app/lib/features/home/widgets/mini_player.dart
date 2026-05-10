import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://picsum.photos/200',
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blinding Lights',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('The Weeknd', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.skip_previous_rounded),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.play_circle_fill_rounded),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.skip_next_rounded),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        const Text(
          'Discover',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

        Row(
          children: [
            IconButton(
              onPressed: () {
                context.push('/upload');
              },

              icon: const Icon(Icons.upload_rounded),
            ),

            const CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
          ],
        ),
      ],
    );
  }
}

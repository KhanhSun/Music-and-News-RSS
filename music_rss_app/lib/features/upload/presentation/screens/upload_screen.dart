import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/upload/presentation/providers/upload_provider.dart';

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen({super.key});

  @override
  ConsumerState<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  final titleController = TextEditingController();

  final artistController = TextEditingController();

  final lyricsController = TextEditingController();

  File? musicFile;
  File? coverFile;

  Future<void> pickMusic() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      musicFile = File(result.files.single.path!);

      setState(() {});
    }
  }

  Future<void> pickCover() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      coverFile = File(result.files.single.path!);

      setState(() {});
    }
  }

  Future<void> uploadSong() async {
    if (musicFile == null || coverFile == null) {
      return;
    }

    ref.read(uploadLoadingProvider.notifier).state = true;

    try {
      final uploadService = ref.read(uploadServiceProvider);

      final musicUrl = await uploadService.uploadMusic(musicFile!);

      final coverUrl = await uploadService.uploadCover(coverFile!);

      await uploadService.saveSong(
        title: titleController.text,
        artist: artistController.text,
        coverUrl: coverUrl,
        audioUrl: musicUrl,
        lyrics: lyricsController.text,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Upload success')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    ref.read(uploadLoadingProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(uploadLoadingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Upload Song')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(
          children: [
            GestureDetector(
              onTap: pickCover,

              child: Container(
                height: 220,

                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: coverFile == null
                    ? const Icon(Icons.image, size: 80)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(30),

                        child: Image.file(coverFile!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: pickMusic,
              child: Text(musicFile == null ? 'Pick MP3' : 'Music Selected'),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: titleController,

              decoration: const InputDecoration(hintText: 'Song title'),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: artistController,

              decoration: const InputDecoration(hintText: 'Artist'),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: lyricsController,
              maxLines: 10,

              decoration: const InputDecoration(hintText: 'Lyrics'),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: loading ? null : uploadSong,

              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Upload Song'),
            ),
          ],
        ),
      ),
    );
  }
}

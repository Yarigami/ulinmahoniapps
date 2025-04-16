import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSearchBanner extends StatefulWidget {
  const VideoSearchBanner({super.key});

  @override
  State<VideoSearchBanner> createState() => _VideoSearchBannerState();
}

class _VideoSearchBannerState extends State<VideoSearchBanner> {
  late VideoPlayerController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/myvideo.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      }).catchError((error) {
        print("Error loading video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
      children: [
        ClipRRect(
          child: SizedBox(
            height: 350, // Menentukan tinggi jelas untuk video
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio, // Menjaga rasio aspek
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        Positioned(
          left: 24,
          right: 24,
          bottom: 16,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      cursorColor: Colors.grey,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Cari hunianmu',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black45,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, size: 28, color: Colors.black),
                    onPressed: () {
                      print("Mencari: ${_searchController.text}");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    )
        : const SizedBox(
      height: 250,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

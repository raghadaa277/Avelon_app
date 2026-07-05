import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';

class PostMediaSlider extends StatefulWidget {
  final List<PostMediaModel> media;
  const PostMediaSlider({super.key, required this.media});

  @override
  State<PostMediaSlider> createState() => _PostMediaSliderState();
}

class _PostMediaSliderState extends State<PostMediaSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.media.isEmpty) return const SizedBox.shrink();

    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: widget.media.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.media[index].mediaFullUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.media.length > 1)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "${_currentIndex + 1}/${widget.media.length}",
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        if (widget.media.length > 1)
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.media.length, (i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentIndex == i ? 16 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentIndex == i
                        ? const Color(0xffB8FF1A)
                        : Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

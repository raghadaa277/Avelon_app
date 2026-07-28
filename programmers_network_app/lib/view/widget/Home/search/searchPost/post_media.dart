import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';

class PostMediaSliderSearch extends StatefulWidget {
  final List<PostMedia> media;
  final int postId;

  const PostMediaSliderSearch({
    super.key,
    required this.media,
    required this.postId,
  });

  @override
  State<PostMediaSliderSearch> createState() => _PostMediaSliderState();
}

class _PostMediaSliderState extends State<PostMediaSliderSearch> {
  int _currentIndex = 0;

  double? _aspectRatio;

  @override
  void initState() {
    super.initState();

    if (widget.media.isNotEmpty) {
      _loadImageSize(widget.media[0].mediaFullUrl);
    }
  }

  Future<void> _loadImageSize(String url) async {
    final ImageProvider provider = NetworkImage(url);

    final ImageStream stream = provider.resolve(const ImageConfiguration());

    stream.addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        final width = info.image.width.toDouble();

        final height = info.image.height.toDouble();

        if (mounted) {
          setState(() {
            _aspectRatio = width / height;
          });
        }
      }),
    );
  }

  @override
  void didUpdateWidget(covariant PostMediaSliderSearch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.media.isEmpty) {
      _currentIndex = 0;

      return;
    }

    if (_currentIndex >= widget.media.length) {
      _currentIndex = widget.media.length - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.media.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),

          child: AspectRatio(
            aspectRatio: _aspectRatio ?? 1,

            child: PageView.builder(
              itemCount: widget.media.length,

              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });

                _loadImageSize(widget.media[index].mediaFullUrl);
              },

              itemBuilder: (context, index) {
                final image = widget.media[index];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),

                  child: Image.network(
                    image.mediaFullUrl,

                    width: double.infinity,

                    height: double.infinity,

                    fit: BoxFit.contain,

                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: Colors.grey.shade200,

                        child: const Icon(Icons.broken_image, size: 40),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),

        Positioned(
          top: 10,

          left: 10,

          child: GestureDetector(
            onTap: () {
              if (widget.media.isEmpty) {
                return;
              }
            },

            child: Container(
              padding: const EdgeInsets.all(6),

              decoration: const BoxDecoration(
                color: Colors.black54,

                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        if (widget.media.length > 1)
          Positioned(
            top: 10,

            right: 10,

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

              decoration: BoxDecoration(
                color: Colors.black54,

                borderRadius: BorderRadius.circular(10),
              ),

              child: Text(
                "${_currentIndex + 1}/${widget.media.length}",

                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),

        if (widget.media.length > 1)
          Positioned(
            bottom: 10,

            left: 0,

            right: 0,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(widget.media.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),

                  margin: const EdgeInsets.symmetric(horizontal: 3),

                  width: _currentIndex == index ? 16 : 6,

                  height: 6,

                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? const Color(0xffB8FF1A)
                        : Colors.white70,

                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

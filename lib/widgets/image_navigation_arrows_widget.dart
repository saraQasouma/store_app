import 'package:flutter/material.dart';

class ImageNavigationArrowsWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  const ImageNavigationArrowsWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Stack(
      children: [
        if (currentPage > 0)
          Positioned(
            left: 4,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    size: 20, color: Colors.white),
                onPressed: onPrevious,
              ),
            ),
          ),
        if (currentPage < totalPages - 1)
          Positioned(
            right: 4,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios,
                    size: 20, color: Colors.white),
                onPressed: onNext,
              ),
            ),
          ),
      ],
    );
  }
}

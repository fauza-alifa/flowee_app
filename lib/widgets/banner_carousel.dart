import 'dart:async';

import 'package:flowee_app/models/promo_banner.dart';
import 'package:flowee_app/widgets/banner_slide.dart';
import 'package:flowee_app/widgets/carousel_dots.dart';
import 'package:flutter/material.dart';

// Carousel banner will move automatically every some seconds, for handling timer like this we need stateful widget to do widget changes in screen
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners});

  final List<PromoBanner> banners;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  /**
   * PageController = to control which slide is shown on the PageView
   */

  late final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      if (!mounted || widget.banners.isEmpty) return;
      final next = (_page + 1) % widget.banners.length;
      _controller.animateToPage(
        next,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  /**
   * Timer MUST be cancelled when widget is destroyed or not shown in screen
   * if we forgot to cancel then the timer keeps trying to run in background even though the carousel is not shown in screen anymore
   * This is one of the general reason of memory leak in flutter
   */
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        SizedBox(
          height: 168,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            /**
             * called when user swipe manually, not just when swiped automatically of timer
             * so point indicator below always sync
             * initState = swipe automatically
             * setState = swipe manually
             */
            onPageChanged: (index) => setState(() => _page = index),
            itemBuilder: (context, index) =>
                BannerSlide(banner: widget.banners[index]),
          ),
        ),
        SizedBox(height: 10),
        CarouselDots(
          count: widget.banners.length,
          activeIndex: _page,
          activeColor: widget.banners[_page].gradientColors.first,
        ),
      ],
    );
  }
}

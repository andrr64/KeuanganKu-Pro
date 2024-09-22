import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/app/main/introduction/userdata_form.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key, required this.callback});
  final void Function() callback;

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              const Scaffold(body: Center(child: Text('page 1'),),),
              const Scaffold(body: Center(child: Text('page 2'),),),
              UserdataForm(callback: widget.callback,)
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20), // Tambahkan padding jika ingin jarak dari bawah
              child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const WormEffect(
                    dotWidth: 12,
                    activeDotColor: baseColor_dark_blue,
                    dotHeight: 12,
                    radius: 12
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/components/plan_route.dart';
import 'package:geo_app/Page/LandingPage/map/components/record_route.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';

class MapPage extends HookWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallSize = Size(size.width * .5 - 14, 60);
    final mediumSize = Size(size.width, 200);
    final opened = useState(0);

    return Stack(
      fit: StackFit.expand,
      children: [
        MapWidget(),
        AnimatedOpacity(
          opacity: opened.value != 2 ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: RecordRoute(
              enlargedSize: mediumSize,
              size: smallSize,
              onTap: (open) {
                opened.value = open ? 1 : 0;
              },
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: opened.value != 1 ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Align(
            alignment: Alignment.bottomRight,
            child: PlanRoute(
              enlargedSize: mediumSize,
              size: smallSize,
              onTap: (open) {
                opened.value = open ? 2 : 0;
              },
            ),
          ),
        ),
      ],
    );
  }
}

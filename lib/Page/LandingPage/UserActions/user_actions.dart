import 'package:flutter/material.dart';
import 'package:geo_app/Page/LandingPage/Discover/discover_page.dart';
import 'package:geo_app/Page/LandingPage/Events/event_page.dart';
import 'package:geo_app/Page/LandingPage/UserActions/user_action_card.dart';
import 'package:geo_app/Page/LandingPage/map/Plan/plan_route_page.dart';
import 'package:geo_app/Page/LandingPage/map/Record/record_route_page.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/components/header.dart';
import 'package:provider/provider.dart';

class UserAction {
  final Color color;
  final IconData iconData;
  final String headerText;
  final Widget Function(Color) child;

  UserAction({
    required this.color,
    required this.iconData,
    required this.headerText,
    required this.child,
  });
}

class UserActions extends StatelessWidget {
  const UserActions({super.key});

  @override
  Widget build(BuildContext context) {
    final list = [
      UserAction(
        color: Colors.red.shade400,
        iconData: Icons.circle,
        headerText: "Record",
        child: (color) => RecordPage(color: color),
      ),
      UserAction(
        color: Constants.generateMaterialColor(
          Constants.lilaColor,
        ).shade400,
        iconData: Icons.route,
        headerText: "Plan",
        child: (color) => PlanPage(color: color),
      ),
      UserAction(
        color: Constants.generateMaterialColor(
          Colors.blue,
        ).shade400,
        iconData: Icons.event,
        headerText: "Events",
        child: (color) => EventPage(color: color),
      ),
      UserAction(
        color: Constants.generateMaterialColor(
          Constants.tealColor,
        ).shade400,
        iconData: Icons.map_rounded,
        headerText: "Discover",
        child: (color) => DiscoverPage(color: color),
      ),
    ];
    final mapsProvider = Provider.of<MapsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Header(title: "Actions", color: Colors.white),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                UserAction item = list[i];
                return UserActionCard(
                  color: item.color,
                  onTap: (color) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider.value(
                          value: mapsProvider,
                          child: item.child(color),
                        ),
                      ),
                    );
                  },
                  icon: (color) => CircledIcon(
                    color: item.color,
                    iconData: item.iconData,
                    size: 28,
                    padding: const EdgeInsets.all(12),
                  ),
                  headerText: item.headerText,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

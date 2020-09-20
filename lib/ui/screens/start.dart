import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_actions/quick_actions.dart';

import '../../providers/index.dart';
import '../../repositories/index.dart';
import '../tabs/index.dart';

/// This view holds all tabs & its models: home, vehicles, upcoming & latest launches, & company tabs.
class StartScreen extends StatefulWidget {
  static const route = '/';

  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Reading app shortcuts input
    final QuickActions quickActions = QuickActions();
    quickActions.initialize((type) {
      switch (type) {
        case 'vehicles':
          setState(() => _currentIndex = 1);
          break;
        case 'upcoming':
          setState(() => _currentIndex = 2);
          break;
        case 'latest':
          setState(() => _currentIndex = 3);
          break;
        default:
          setState(() => _currentIndex = 0);
      }
    });

    Future.delayed(Duration.zero, () async {
      // Setting app shortcuts
      await quickActions.setShortcutItems(<ShortcutItem>[
        ShortcutItem(
          type: 'vehicles',
          localizedTitle: FlutterI18n.translate(
            context,
            'spacex.vehicle.icon',
          ),
          icon: 'action_vehicle',
        ),
        ShortcutItem(
          type: 'upcoming',
          localizedTitle: FlutterI18n.translate(
            context,
            'spacex.upcoming.icon',
          ),
          icon: 'action_upcoming',
        ),
        ShortcutItem(
          type: 'latest',
          localizedTitle: FlutterI18n.translate(
            context,
            'spacex.latest.icon',
          ),
          icon: 'action_latest',
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    NotificationsProvider.updateNotifications(context);
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: [
        HomeTab(),
        VehiclesTab(),
        LaunchesTab(LaunchType.upcoming),
        LaunchesTab(LaunchType.past),
        CompanyTab(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: GoogleFonts.rubik(),
        unselectedLabelStyle: GoogleFonts.rubik(),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _currentIndex != index
            ? setState(() => _currentIndex = index)
            : null,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: FlutterI18n.translate(
              context,
              'spacex.home.icon',
            ),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: FlutterI18n.translate(
              context,
              'spacex.vehicle.icon',
            ),
            icon: SvgPicture.asset(
              'assets/icons/capsule.svg',
              colorBlendMode: BlendMode.srcATop,
              width: 24,
              height: 24,
              color: _currentIndex != 1
                  ? Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).textTheme.caption.color
                      : Colors.black26
                  : Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
            ),
          ),
          BottomNavigationBarItem(
            label: FlutterI18n.translate(
              context,
              'spacex.upcoming.icon',
            ),
            icon: Icon(Icons.access_time),
          ),
          BottomNavigationBarItem(
            label: FlutterI18n.translate(
              context,
              'spacex.latest.icon',
            ),
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            label: FlutterI18n.translate(
              context,
              'spacex.company.icon',
            ),
            icon: Icon(Icons.location_city),
          ),
        ],
      ),
    );
  }
}

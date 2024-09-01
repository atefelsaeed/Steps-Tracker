import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:steps_counter/generated/l10n.dart';
import 'package:steps_counter/presentation/screens/home_screen/step_counter.dart';
import 'package:steps_counter/presentation/screens/settings/settings.dart';
import 'package:steps_counter/presentation/screens/steps_history_screen/steps_history_screen.dart';
import 'package:steps_counter/presentation/screens/weight_history_screen/weight_history_screen.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  List<PersistentTabConfig> _tabs(BuildContext context) => [
        PersistentTabConfig(
          screen: const StepCounterScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: (S.current.home),
            activeForegroundColor: Theme.of(context).primaryColorLight,
            inactiveForegroundColor: CupertinoColors.systemGrey,
          ),
        ),
        PersistentTabConfig(
          screen: const WeightEntriesScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.line_weight),
            title: (S.current.weight_list),
            activeForegroundColor: Theme.of(context).primaryColorLight,
            inactiveForegroundColor: CupertinoColors.systemGrey,
          ),
        ),
        PersistentTabConfig(
          screen: const StepsHistoryScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.directions_walk_rounded),
            title: (S.current.steps_list),
            activeForegroundColor: Theme.of(context).primaryColorLight,
            inactiveForegroundColor: CupertinoColors.systemGrey,
          ),
        ),
        PersistentTabConfig(
          screen: const AppSettings(),
          item: ItemConfig(
            icon: const Icon(Icons.settings),
            title: (S.current.settings),
            activeForegroundColor: Theme.of(context).primaryColorLight,
            inactiveForegroundColor: CupertinoColors.systemGrey,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, size.height * 0.06),
        child: Container(),
      ),
      body: SafeArea(
        child: PersistentTabView(
          tabs: _tabs(context),
          backgroundColor: Theme.of(context).primaryColor,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          screenTransitionAnimation: const ScreenTransitionAnimation(
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarConfig: navBarConfig,
          ),
        ),
      ),
    );
  }
}

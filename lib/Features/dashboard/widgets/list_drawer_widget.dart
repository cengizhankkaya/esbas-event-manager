import 'package:esbasapp/Features/dashboard/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

import '../../Events/Screens/Events_add.dart';
import '../../Events/Screens/Events_screen.dart';
import '../../../core/comman/colors.dart';
import '../../../core/comman/paths.dart';

class Lisviewdrawerwidget extends StatelessWidget {
  const Lisviewdrawerwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: backroundcolor,
          ),
          child: Image.asset(esbaslogomin),
        ),
        const DrawerWidget(
          push: AddEventScreen(),
          title: 'Create Event',
          icon: Icons.create_outlined,
        ),
        const DrawerWidget(
          push: EventsScreen(),
          title: 'Event List',
          icon: Icons.list_alt_outlined,
        ),
      ],
    );
  }
}

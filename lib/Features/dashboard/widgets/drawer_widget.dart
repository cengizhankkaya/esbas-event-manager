import 'package:flutter/material.dart';

import '../../../core/comman/colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.push,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Widget push;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: whitecolor,
      ),
      title: Text(
        title,
        style: TextStyle(color: whitecolor),
      ),
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => push),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}

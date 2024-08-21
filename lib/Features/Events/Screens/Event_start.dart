import 'package:esbasapp/Features/dashboard/widgets/list_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/comman/colors.dart';
import '../../../core/comman/paths.dart';
import '../../../core/comman/sizes.dart';

class EventStart extends StatefulWidget {
  const EventStart({super.key});

  @override
  State<EventStart> createState() => _EventStartState();
}

class _EventStartState extends State<EventStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backroundcolor,
        iconTheme: IconThemeData(color: whitecolor),
      ),
      drawer: const Drawer(
        width: drawerwidth,
        backgroundColor: backrounddrwcolor,
        child: Lisviewdrawerwidget(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Image.asset(esbaslogo),
          ),
          Expanded(
            flex: 1,
            child: Image.asset(readericon),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'WELCOME TO THE EVENT.\n PLEASE SCAN YOUR CARD!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                width: 350.0,
                child: TextFormField(
                  style: const TextStyle(color: black),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    fillColor: whitecolor,
                    filled: true,
                    hintText: "Card Number",
                    hintStyle: const TextStyle(color: grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

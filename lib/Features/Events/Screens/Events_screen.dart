import 'package:esbasapp/Features/EventsUsers/screens/EventUsersScreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:esbasapp/Features/Events/widgets/event_details_card.dart';
import 'package:esbasapp/Features/Events/widgets/event_status_list.dart';
import 'package:esbasapp/Features/dashboard/widgets/list_drawer_widget.dart';

import '../../../services/EventsUsers_services/models.dart';
import '../../../services/Events_services/models.dart';
import '../../../services/Events_services/service.dart';

import 'package:esbasapp/core/comman/colors.dart';
import 'package:esbasapp/core/comman/sizes.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final ApiService apiService = ApiService();
  late Future<List<EventsModel>> futureEvents;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureEvents = apiService.fetchEvents();
  }

  void _refreshEvents() {
    setState(() {
      futureEvents = apiService.fetchEvents();
    });
  }

  List<EventsModel> _filterEvents(List<EventsModel> events) {
    if (searchQuery.isEmpty) {
      return events.where((event) => event.status == true).toList();
    } else {
      return events
          .where((event) =>
              event.name != null &&
              event.name!.toLowerCase().contains(searchQuery.toLowerCase()) &&
              event.status == true)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _refreshEvents,
                  icon: const Icon(Icons.refresh),
                  color: Colors.white,
                ),
              ],
            ),
            backgroundColor: backroundcolor,
            elevation: 0,
          ),
          drawer: const Drawer(
            width: drawerwidth,
            backgroundColor: backrounddrwcolor,
            child: Lisviewdrawerwidget(),
          ),
          body: Column(
            children: [
              const Expanded(
                flex: 4,
                child: StartList(
                  eventStatus: true,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Text(
                        "Geçmiş Etkinlikler",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<EventsModel>>(
                        future: futureEvents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(child: Text('No events found'));
                          } else {
                            final filteredEvents =
                                _filterEvents(snapshot.data!);
                            if (filteredEvents.isEmpty) {
                              return const Center(
                                  child:
                                      const Text('No matching events found'));
                            }
                            return CarouselSlider.builder(
                              itemCount: filteredEvents.length,
                              options: CarouselOptions(
                                height: screenHeight * 0.5,
                                autoPlay: true,
                                viewportFraction: 0.7,
                                enlargeCenterPage: true,
                                pageSnapping: true,
                                autoPlayAnimationDuration:
                                    const Duration(seconds: 3),
                              ),
                              itemBuilder: (context, itemIndex, pageViewIndex) {
                                final event = filteredEvents[itemIndex];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 4,
                                    margin: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.02,
                                      horizontal: screenWidth * 0.04,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.04),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EventUsersScreen(
                                                eventID: EventUsers.fromJson(
                                                  {'eventID': event.eventID},
                                                ).eventID!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: EventDetailsCard(
                                          event: event,
                                          deleteEvent: (int eventID) async {
                                            await apiService
                                                .deleteEvent(eventID);
                                            _refreshEvents();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

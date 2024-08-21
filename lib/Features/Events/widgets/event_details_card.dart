import 'package:esbasapp/services/Events_services/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({
    super.key,
    required this.event,
    required this.deleteEvent,
    Color? color,
  });

  final EventsModel event;
  final Future<void> Function(int eventID) deleteEvent;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              event.name ?? 'No Name',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.event, color: Colors.pink, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  event.type ?? 'No Type',
                  style: const TextStyle(
                    color: Colors.pink,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.brown, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  event.location ?? 'No Location',
                  style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.blueGrey, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  event.eventDateTime != null
                      ? DateFormat('dd MMMM yyyy – HH:mm')
                          .format(event.eventDateTime!.toLocal())
                      : 'Tarih Yok',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              await deleteEvent(event.eventID!);
            },
            icon: const Icon(Icons.delete, color: Colors.red, size: 28),
          ),
        ],
      ),
    );
  }
}

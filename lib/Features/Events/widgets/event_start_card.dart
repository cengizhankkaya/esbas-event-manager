import 'package:esbasapp/services/Events_services/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/EventsUsers_services/models.dart';
import '../../dashboard/screens/dashboard.dart';

class StartCard extends StatelessWidget {
  const StartCard({
    super.key,
    required this.event,
  });

  final EventsModel event;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth *
            0.95; // Kart genişliği ekran genişliğinin %95'i kadar
        final textStyle = TextStyle(
          fontSize: constraints.maxWidth *
              0.05, // Yazı boyutunu ekran genişliğine göre ayarla
        );

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(8.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: cardWidth,
            child: ListTile(
              contentPadding: EdgeInsets.all(constraints.maxWidth * 0.04),
              title: Text(
                event.name ?? 'Etkinlik Adı Yok',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.event, color: Colors.pink, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.type ?? 'No Type',
                          style: textStyle.copyWith(
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.brown, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.location ?? 'No Location',
                          style: textStyle.copyWith(
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: Colors.green, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.eventDateTime != null
                              ? DateFormat('dd MMMM yyyy – HH:mm')
                                  .format(event.eventDateTime!.toLocal())
                              : 'Tarih Yok',
                          style: textStyle.copyWith(
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height:
                          20.0), // Buton ile metin arasına biraz boşluk ekledik
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(
                              eventID: EventUsers.fromJson(
                                  {'eventID': event.eventID}).eventID!,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: constraints.maxWidth *
                              0.03, // Butonun dikey padding'ini ekran genişliğine göre ayarlıyoruz
                        ),
                      ),
                      child: Text(
                        'Start Event',
                        style: textStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

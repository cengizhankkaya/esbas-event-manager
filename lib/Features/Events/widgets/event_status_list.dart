import 'package:esbasapp/Features/Events/widgets/event_start_card.dart';
import 'package:esbasapp/services/Events_services/service.dart';
import 'package:flutter/material.dart';
import 'package:esbasapp/services/Events_services/models.dart';

class StartList extends StatelessWidget {
  final bool eventStatus;

  const StartList({
    Key? key,
    required this.eventStatus,
  }) : super(key: key);

  Future<List<EventsModel>> _fetchEventsByStatus() async {
    try {
      return await ApiService().fetchEventsByStatus(eventStatus);
    } catch (e) {
      throw Exception('Etkinlikleri getirme başarısız oldu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventsModel>>(
      future: _fetchEventsByStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child:
                  Text('Etkinlik bulunamadı', style: TextStyle(fontSize: 16)));
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.02, // Kenar boşlukları
                    vertical:
                        constraints.maxHeight * 0.01), // Üst ve alt boşluklar
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight *
                            0.01), // Kartlar arası boşluk
                    child: SizedBox(
                      width: constraints.maxWidth * 0.95, // Kart genişliği
                      child: StartCard(event: event),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}

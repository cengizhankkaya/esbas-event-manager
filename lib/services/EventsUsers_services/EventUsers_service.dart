import 'package:dio/dio.dart';
import 'package:esbasapp/services/EventsUsers_services/models.dart';

import '../services_url.dart';

class ApiEventUserService {
  final Dio _dio = Dio();

  // EventUsers için API endpoint URL'sini belirleyin
  Future<List<EventUsers>> fetchEventUsersByEventID(int eventID) async {
    try {
      // URL'yi kendi API endpoint'inizle değiştirin ve eventID'yi parametre olarak ekleyin
      final response = await _dio.get(
        '$urleu/eventID/$eventID',
        queryParameters: {'eventID': eventID},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => EventUsers.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load event users for eventID $eventID');
      }
    } catch (e) {
      // Hataları yönetmek için bir strateji belirleyin
      print('Error: $e');
      throw Exception('Failed to load event users for eventID $eventID');
    }
  }

//Post Metodu eventID ve cardID parametreleri alır.
  Future<void> postEventUser(int eventID, int cardID) async {
    try {
      final response = await _dio.post(
        urleu,
        data: {
          'eventID': eventID,
          'cardID': cardID,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Event user successfully added.');
      } else if (response.statusCode == 409) {
        // 409 Conflict durum kodunu işleyin
        print('User already exists for this event.');
        throw Exception('User already exists for this event.');
      } else {
        // Diğer hata durumlarını işleyin
        throw Exception(
            'Failed to add event user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Hataları yönetmek için bir strateji belirleyin
      print('Error: $e');
      rethrow; // Hata oluştuğunda, exception'ı yeniden fırlat
    }
  }

//Get Metodu
  Future<List<EventUsers>> getEventUsers() async {
    try {
      Response response = await _dio.get(urleu);

      if (response.statusCode == 200) {
        List<EventUsers> eventUsersList = (response.data as List)
            .map((json) => EventUsers.fromJson(json))
            .toList();

        return eventUsersList;
      } else {
        throw Exception('Failed to load event users');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}

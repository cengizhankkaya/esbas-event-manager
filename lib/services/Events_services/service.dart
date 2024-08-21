import 'package:dio/dio.dart';
import 'package:esbasapp/services/Events_services/models.dart';

import '../services_url.dart';

class ApiService {
  final Dio _dio = Dio();
  //get
  Future<List<EventsModel>> fetchEvents() async {
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((event) => EventsModel.fromJson(event)).toList();
      } else {
        throw Exception(
            'Veriler alınırken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('API isteği başarısız oldu');
    }
  }

  Future<List<EventsModel>> fetchEventsByStatus(bool eventStatus) async {
    try {
      final response = await _dio.get('$url/status/$eventStatus');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((event) => EventsModel.fromJson(event)).toList();
      } else {
        throw Exception(
            'Veriler alınırken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('API isteği başarısız oldu');
    }
  }

  //Post
  Future<void> postEvent(EventsModel event) async {
    try {
      final response = await _dio.post(
        url,
        data: event.toJson(), // Sending data as JSON
      );

      if (response.statusCode == 201) {
        // Successful creation
        print('Event created successfully');
      } else {
        // Handle other status codes
        print('Failed to create event: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        // DioError contains more detailed information about the error
        print('DioError: ${e.message}');
        if (e.response != null) {
          print('Error Response data: ${e.response!.data}');
        }
      } else {
        print('Unexpected Error: $e');
      }
    }
  }

  //Put
  Future<void> updateEvent(
      int eventId, Map<String, dynamic> updatedData) async {
    try {
      final response = await _dio.put(
        '$url/$eventId',
        data: updatedData,
      );
      if (response.statusCode == 200) {
        // Başarıyla güncellendi, herhangi bir işlem yapmaya gerek olmayabilir.
        print('Etkinlik başarıyla güncellendi.');
      } else {
        throw Exception(
            'Etkinlik güncellenirken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('API isteği başarısız oldu');
    }
  }

  //Delete

  Future<void> deleteEvent(int eventID) async {
    try {
      final response = await _dio.delete('$url/SoftDelete$eventID');
      if (response.statusCode == 200) {
        print('Event deleted successfully.');
      } else {
        print('Failed to delete event: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  Future<void> softDeleteEventByStatus(int id) async {
    try {
      final response = await _dio.patch(
        '$url/SoftDeleteByStatus/$id',
      );

      if (response.statusCode == 204) {
        print('Event successfully marked as deleted.');
      } else {
        print('Failed to mark event as deleted.');
      }
    } catch (e) {
      print('Error occurred while marking event as deleted: $e');
    }
  }
}

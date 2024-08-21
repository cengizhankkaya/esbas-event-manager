import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:esbasapp/services/EventsUsers_services/EventUsers_service.dart';

class SubmitForm {
  final ApiEventUserService _apiEventUserService = ApiEventUserService();

  void submitForm({
    required GlobalKey<FormState> formKey,
    required TextEditingController cardIDController,
    required BuildContext context,
    required int eventID,
    required FocusNode focusNode, // FocusNode ekleyin
  }) {
    if (formKey.currentState!.validate()) {
      int cardID = int.parse(cardIDController.text);

      _apiEventUserService.postEventUser(eventID, cardID).then((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Etkinliğe hoş geldiniz.'),
            backgroundColor: Colors.green,
          ),
        );
        cardIDController.clear();
        FocusScope.of(context).requestFocus(
            focusNode); // Klavyeyi odakta tutmak için focusu geri yükle
      }).catchError((error) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        cardIDController.clear();

        String message = 'Kart kaydedilemedi.';
        Color bgColor = Colors.red;

        if (error is DioException) {
          final statusCode = error.response?.statusCode;
          if (statusCode == 409) {
            message = 'Kullanıcı bu etkinliğe zaten kayıtlı.';
            bgColor = Colors.orange;
          } else if (statusCode == 400) {
            message = 'Geçersiz kart numarası.';
            bgColor = Colors.red;
          } else {
            message =
                'Error: ${error.response?.data['message'] ?? 'Unknown error'}';
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: bgColor),
        );
        FocusScope.of(context).requestFocus(focusNode); // Focusu geri yükle
      });
    }
  }
}




// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import 'package:esbasapp/services/EventsUsers_services/EventUsers_service.dart';

// class SubmitForm {
//   final ApiEventUserService _apiEventUserService = ApiEventUserService();

//   void submitForm({
//     required GlobalKey<FormState> formKey,
//     required TextEditingController cardIDController,
//     required BuildContext context,
//     required int eventID,
//     required FocusNode focusNode,
//   }) {
//     if (formKey.currentState!.validate()) {
//       int cardID = int.parse(cardIDController.text);

//       // Klavyeyi kapatmak için odak kaybını tetikleyin
//       FocusScope.of(context).unfocus();

//       _apiEventUserService.postEventUser(eventID, cardID).then((_) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text('Etkinliğe hoş geldiniz.'),
//             backgroundColor: Colors.green, // Başarılı işlem için yeşil renk
//           ),
//         );
//         cardIDController.clear();
//         // Odak geri döner
//         FocusScope.of(context).requestFocus(focusNode);
//       }).catchError((error) {
//         cardIDController.clear();
//         // Odak geri döner
//         FocusScope.of(context).requestFocus(focusNode);

//         String message = 'Kart kaydedilemedi.';
//         Color bgColor = Colors.red; // Hata mesajı için kırmızı renk

//         if (error is DioException) {
//           final statusCode = error.response?.statusCode;
//           if (statusCode == 409) {
//             message = 'Kullanıcı bu etkinliğe zaten kayıtlı.';
//             bgColor = Colors.orange; // Uyarı mesajı için turuncu renk
//           } else if (statusCode == 400) {
//             message = 'Geçersiz kart numarası.';
//             bgColor = Colors.red; // Hata için kırmızı renk
//           } else {
//             message =
//                 'Error: ${error.response?.data['message'] ?? 'Unknown error'}';
//           }
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(message), backgroundColor: bgColor),
//         );
//       });
//     }
//   }
// }

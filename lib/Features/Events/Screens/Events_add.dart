import 'package:esbasapp/core/comman/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:esbasapp/Features/Events/Screens/Events_screen.dart';
import '../../../services/Events_services/models.dart';
import '../../../services/Events_services/service.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  String? _name;
  String? _type;
  String? _location;
  DateTime? _eventDateTime;
  final bool _eventStatus = true;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _eventDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_eventDateTime ?? DateTime.now()),
      );

      if (selectedTime != null) {
        setState(() {
          _eventDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final event = EventsModel(
        name: _name,
        type: _type,
        location: _location,
        eventDateTime: _eventDateTime,
        eventStatus: _eventStatus,
      );

      try {
        await _apiService.postEvent(event);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event created successfully')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventsScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating event: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event', style: TextStyle(color: Colors.white)),
        backgroundColor: backroundcolor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventsScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: GoogleFonts.lato(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.teal[50],
                ),
                onSaved: (value) => _name = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Type',
                  labelStyle: GoogleFonts.lato(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.teal[50],
                ),
                onSaved: (value) => _type = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a type' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: GoogleFonts.lato(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.teal[50],
                ),
                onSaved: (value) => _location = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDateTime(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Event DateTime',
                      labelStyle: GoogleFonts.lato(fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.teal[50],
                      hintText: _eventDateTime != null
                          ? _eventDateTime!.toLocal().toString().split(' ')[0]
                          : 'Select a date',
                    ),
                    validator: (value) =>
                        _eventDateTime == null ? 'Please select a date' : null,
                    controller: TextEditingController(
                      text: _eventDateTime != null
                          ? _eventDateTime!.toLocal().toString().split(' ')[0]
                          : '',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: backroundcolor, // Butonun yazı rengi
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5, // Hafif gölge efekti
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










// import 'package:esbasapp/Features/Events/Screens/Events_screen.dart';
// import 'package:flutter/material.dart';
// import '../../../services/Events_services/models.dart';
// import '../../../services/Events_services/service.dart';

// class AddEventScreen extends StatefulWidget {
//   const AddEventScreen({super.key});

//   @override
//   _AddEventScreenState createState() => _AddEventScreenState();
// }

// class _AddEventScreenState extends State<AddEventScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final ApiService _apiService = ApiService();

//   String? _name;
//   String? _type;
//   String? _location;
//   DateTime? _eventDateTime;
//   // final bool _status = true;
//   final bool _eventStatus = true;

//   Future<void> _selectDateTime(BuildContext context) async {
//     final DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: _eventDateTime ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (selectedDate != null) {
//       final TimeOfDay? selectedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(_eventDateTime ?? DateTime.now()),
//       );

//       if (selectedTime != null) {
//         setState(() {
//           _eventDateTime = DateTime(
//             selectedDate.year,
//             selectedDate.month,
//             selectedDate.day,
//             selectedTime.hour,
//             selectedTime.minute,
//           );
//         });
//       }
//     }
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       final event = EventsModel(
//         name: _name,
//         type: _type,
//         location: _location,
//         eventDateTime: _eventDateTime,
//         // status: _status,
//         eventStatus: _eventStatus,
//       );

//       try {
//         await _apiService.postEvent(event);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Event created successfully')),
//         );
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const EventsScreen()),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error creating event: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Event'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const EventsScreen()),
//             );
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                   border: const OutlineInputBorder(),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                 ),
//                 onSaved: (value) => _name = value,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a name' : null,
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Type',
//                   border: const OutlineInputBorder(),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                 ),
//                 onSaved: (value) => _type = value,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a type' : null,
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Location',
//                   border: const OutlineInputBorder(),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                 ),
//                 onSaved: (value) => _location = value,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a location' : null,
//               ),
//               const SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () => _selectDateTime(context),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Event DateTime',
//                       border: const OutlineInputBorder(),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       hintText: _eventDateTime != null
//                           ? _eventDateTime!.toLocal().toString().split(' ')[0]
//                           : 'Select a date',
//                     ),
//                     validator: (value) =>
//                         _eventDateTime == null ? 'Please select a date' : null,
//                     controller: TextEditingController(
//                       text: _eventDateTime != null
//                           ? _eventDateTime!.toLocal().toString().split(' ')[0]
//                           : '',
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: const Text('Submit'),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 40.0, vertical: 20.0),
//                   textStyle: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

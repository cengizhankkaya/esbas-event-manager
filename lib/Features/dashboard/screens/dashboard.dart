import 'package:esbasapp/Features/dashboard/widgets/submit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esbasapp/services/Events_services/service.dart';

import '../../../core/comman/colors.dart';
import '../../../core/comman/paths.dart';
import '../../../core/comman/sizes.dart';
import '../widgets/list_drawer_widget.dart';

class Dashboard extends StatefulWidget {
  final int eventID;

  const Dashboard({super.key, required this.eventID});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardIDController = TextEditingController();
  final FocusNode _cardIDFocusNode = FocusNode();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_cardIDFocusNode);
      _submitForm();
    });
  }

  @override
  void dispose() {
    _cardIDController.dispose();
    _cardIDFocusNode.dispose();
    super.dispose();
  }

  void _handleCardIDChange(String value) {
    if (value.isNotEmpty) {
      String updatedValue = value.replaceFirst(RegExp(r'^0+'), '');
      _cardIDController.value = _cardIDController.value.copyWith(
        text: updatedValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: updatedValue.length),
        ),
      );
    }
    if (_cardIDController.text.length == 7) {
      _submitForm();
    }
  }

  void _submitForm() {
    SubmitForm().submitForm(
      formKey: _formKey,
      cardIDController: _cardIDController,
      context: context,
      eventID: widget.eventID,
      focusNode: _cardIDFocusNode,
    );
  }

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
              'WELCOME TO THE EVENT.\nPLEASE SCAN YOUR CARD!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            child: Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 350.0,
                        child: TextFormField(
                          controller: _cardIDController,
                          focusNode: _cardIDFocusNode,
                          onChanged: _handleCardIDChange,
                          style: const TextStyle(color: black),
                          keyboardType:
                              TextInputType.none, // Klavyeyi engellemek için
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          // Kullanıcı girişini engeller ancak controller ile programlı girişe izin verir
                          decoration: InputDecoration(
                            fillColor: whitecolor,
                            filled: true,
                            hintText: "Card Number",
                            hintStyle: const TextStyle(color: grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a card ID';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Submit'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await _apiService
                                .softDeleteEventByStatus(widget.eventID);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Event successfully ended.'),
                              ),
                            );
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to end event.'),
                              ),
                            );
                          }
                        },
                        child: const Text('End Event'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

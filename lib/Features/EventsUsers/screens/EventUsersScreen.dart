import 'package:esbasapp/services/EventsUsers_services/EventUsers_service.dart';
import 'package:esbasapp/services/EventsUsers_services/models.dart';
import 'package:flutter/material.dart';

class EventUsersScreen extends StatefulWidget {
  final int eventID;

  const EventUsersScreen({Key? key, required this.eventID}) : super(key: key);

  @override
  _EventUsersScreenState createState() => _EventUsersScreenState();
}

class _EventUsersScreenState extends State<EventUsersScreen> {
  late Future<List<EventUsers>> _futureEventUsers;
  ApiEventUserService apiEventUserService = ApiEventUserService();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _futureEventUsers =
        apiEventUserService.fetchEventUsersByEventID(widget.eventID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Users for EventID: ${widget.eventID}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<EventUsers>>(
              future: _futureEventUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No users found for this event.'));
                } else {
                  final eventUsers = snapshot.data!
                      .where((user) =>
                          user.user?.fullName
                              ?.toLowerCase()
                              .contains(searchQuery.toLowerCase()) ??
                          false)
                      .toList();

                  return ListView.builder(
                    itemCount: eventUsers.length,
                    itemBuilder: (context, index) {
                      final user = eventUsers[index].user;
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              user?.fullName?.substring(0, 1) ?? '?',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            user?.fullName ?? 'No name',
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 5.0),
                              Text(
                                user?.department ?? 'No department',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                user?.isOfficeEmployee ?? 'Unknown',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                user?.gender?.toLowerCase() == 'male'
                                    ? Icons.male
                                    : user?.gender?.toLowerCase() == 'female'
                                        ? Icons.female
                                        : Icons.person,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(width: 8.0),
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ],
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
    );
  }
}

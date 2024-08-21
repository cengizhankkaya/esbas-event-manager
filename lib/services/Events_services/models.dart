class EventsModel {
  int? eventID;
  String? name;
  String? type;
  String? location;
  DateTime? eventDateTime;
  bool? status;
  bool? eventStatus;

  EventsModel({
    this.eventID,
    this.name,
    this.type,
    this.location,
    this.eventDateTime,
    this.status,
    this.eventStatus,
  });

  EventsModel.fromJson(Map<String, dynamic> json) {
    eventID = json['eventID'];
    name = json['name'];
    type = json['type'];
    location = json['location'];
    eventDateTime = json['eventDateTime'] != null
        ? DateTime.parse(json['eventDateTime'])
        : null;
    status = json['status'];
    eventStatus = json['event_Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventID != null) data['eventID'] = eventID; // Only include if not null
    data['name'] = name;
    data['type'] = type;
    data['location'] = location;
    data['eventDateTime'] = eventDateTime?.toIso8601String();
    data['status'] = status;
    data['event_Status'] = eventStatus;

    return data;
  }
}

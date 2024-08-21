class EventUsers {
  int? id;
  int? eventID;
  int? userID;
  bool? status;
  Event? event;
  User? user;
  bool? eventStatus;

  EventUsers(
      {this.id,
      this.eventID,
      this.userID,
      this.status,
      this.event,
      this.user,
      this.eventStatus});

  EventUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventID = json['eventID'];
    userID = json['userID'];
    status = json['status'];
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    eventStatus = json['event_Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventID'] = eventID;
    data['userID'] = userID;
    data['status'] = status;
    if (event != null) {
      data['event'] = event!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Event {
  int? eventID;
  String? name;
  String? type;
  String? location;
  String? eventDateTime;
  bool? status;
  bool? eventStatus;

  Event(
      {this.eventID,
      this.name,
      this.type,
      this.location,
      this.eventDateTime,
      this.status,
      this.eventStatus});

  Event.fromJson(Map<String, dynamic> json) {
    eventID = json['eventID'];
    name = json['name'];
    type = json['type'];
    location = json['location'];
    eventDateTime = json['eventDateTime'];
    status = json['status'];
    eventStatus = json['event_Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventID'] = eventID;
    data['name'] = name;
    data['type'] = type;
    data['location'] = location;
    data['eventDateTime'] = eventDateTime;
    data['status'] = status;
    data['event_Status'] = eventStatus;
    return data;
  }
}

class User {
  int? id;
  int? userID;
  String? fullName;
  String? department;
  String? isOfficeEmployee;
  String? gender;
  bool? status;

  User(
      {this.id,
      this.userID,
      this.fullName,
      this.department,
      this.isOfficeEmployee,
      this.gender,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    fullName = json['fullName'];
    department = json['department'];
    isOfficeEmployee = json['isOfficeEmployee'];
    gender = json['gender'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['fullName'] = fullName;
    data['department'] = department;
    data['isOfficeEmployee'] = isOfficeEmployee;
    data['gender'] = gender;
    data['status'] = status;
    return data;
  }
}

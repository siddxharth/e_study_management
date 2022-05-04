// import 'dart:collection';

// import 'package:e_study_management/models/event.dart';
// import 'package:flutter/cupertino.dart';

// class EventNotifier with ChangeNotifier {
//   List<Event> _EventList = [];
//   late Event _currentEvent;

//   UnmodifiableListView<Event> get eventList => UnmodifiableListView(_EventList);

//   Event get currentEvent => _currentEvent;

//   set eventList(List<Event> eventList) {
//     _EventList = eventList;
//     notifyListeners();
//   }

//   set currentEvent(Event event) {
//     _currentEvent = event;
//     notifyListeners();
//   }
// }
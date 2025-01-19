import 'package:flutter/material.dart';
import 'package:labs4/models/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late ValueNotifier<List<Event>> _selectedEvents;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now(); // initially focused on the current day
    _selectedEvents = ValueNotifier([]);  // Empty list of events initially
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Here, you can return a list of events for the selected day
    // For now, we'll just return a dummy event.
    return [
      Event('Exam 1', day.add(Duration(hours: 9))),  // Example event at 9 AM
      Event('Exam 2', day.add(Duration(hours: 14)))  // Example event at 2 PM
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar Screen"),
      ),
      body: Column(
        children: [
          // TableCalendar widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 01, 01),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);  // Highlight selected day
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);  // Update events for selected day
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;  // Update focused day when calendar page changes
            },
          ),
          // Display events for the selected day
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, events, _) {
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(events[index].title),
                      subtitle: Text(DateFormat('HH:mm').format(events[index].date)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


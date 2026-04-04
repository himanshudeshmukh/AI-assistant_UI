import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A separate page that shows a calendar and lets the user pick a date.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Start with today's date selected.
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Pick any date from the calendar below.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          // Main calendar widget.
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CalendarDatePicker(
                // The date that is currently selected.
                initialDate: _selectedDate,

                // Earliest allowed date in the calendar.
                firstDate: DateTime(now.year - 50),

                // Latest allowed date in the calendar.
                lastDate: DateTime(now.year + 50),

                // Called whenever the user taps a date.
                onDateChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Show the selected date below the calendar.
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Selected date'),
              subtitle: Text(_formatDate(_selectedDate)),
            ),
          ),
        ],
      ),
    );
  }

  /// Small helper to format DateTime as yyyy-mm-dd.
  String _formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}

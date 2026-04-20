import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../config/theme/app_colors.dart';
import '../../widgets/ripple_background_layer.dart';

enum CalendarMode {
  event,
  trip,
}


class CalendarEntry {
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final String title;
  final String type;
  final String theme;
  final String weather;

  CalendarEntry({
    required this.id,
    required this.startDate,
    this.endDate,
    required this.title,
    required this.type,
    required this.theme,
    required this.weather,
  });
}


class UnifiedCalendarPage extends StatefulWidget {
  final CalendarMode mode;

  const UnifiedCalendarPage({
    super.key,
    required this.mode,
  });

  @override
  State<UnifiedCalendarPage> createState() => _UnifiedCalendarPageState();
}



class _UnifiedCalendarPageState extends State<UnifiedCalendarPage> {
  DateTime focusedDay = DateTime.now();

  DateTime? selectedDay;

  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController themeCtrl = TextEditingController();

  final List<CalendarEntry> entries = [];

  /* ================= SELECTION LOGIC ================= */

  void onDaySelected(DateTime selected, DateTime focused) {
    setState(() {
      focusedDay = focused;

      if (widget.mode == CalendarMode.event) {
        selectedDay = selected;
        return;
      }

      // TRIP MODE
      if (startDate == null || endDate != null) {
        startDate = selected;
        endDate = null;
      } else if (selected.isAfter(startDate!)) {
        endDate = selected;
      } else {
        startDate = selected;
        endDate = null;
      }
    });
  }

  bool isInRange(DateTime day) {
    if (startDate == null || endDate == null) return false;
    return day.isAfter(startDate!) && day.isBefore(endDate!);
  }

  bool isSelected(DateTime day) {
    if (widget.mode == CalendarMode.event) {
      return isSameDay(selectedDay, day);
    } else {
      return isSameDay(startDate, day) ||
          isSameDay(endDate, day);
    }
  }

  /* ================= SAVE ================= */

  void save() {
    final entry = CalendarEntry(
      id: DateTime.now().toString(),
      startDate: widget.mode == CalendarMode.event
          ? selectedDay ?? focusedDay
          : startDate ?? focusedDay,
      endDate: widget.mode == CalendarMode.trip ? endDate : null,
      title: titleCtrl.text,
      type: widget.mode.name,
      theme: themeCtrl.text,
      weather: "Sunny",
    );

    setState(() => entries.add(entry));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Saved Successfully")),
    );

    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(

          appBar: AppBar(
            title: Text(
              widget.mode == CalendarMode.event
                  ? "Plan Event"
                  : "Trip Planner",
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.softTeal700,
                        AppColors.softTeal300,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2035),
                    focusedDay: focusedDay,

                    onDaySelected: onDaySelected,
                    selectedDayPredicate: isSelected,

                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      leftChevronIcon: Icon(
                          Icons.chevron_left, color: Colors.white),
                      rightChevronIcon: Icon(
                          Icons.chevron_right, color: Colors.white),
                    ),

                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white70),
                      weekendStyle: TextStyle(color: Colors.white70),
                    ),

                    calendarStyle: const CalendarStyle(
                      outsideDaysVisible: false,
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                    ),

                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, _) {
                        final selected = isSelected(day);
                        final range = widget.mode == CalendarMode.trip &&
                            isInRange(day);

                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.white
                                : range
                                ? Colors.white24
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${day.day}",
                            style: TextStyle(
                              color: selected ? Colors.black : Colors.white,
                              fontWeight: selected ? FontWeight.bold : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(
                    labelText: "Title / Occasion",
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: themeCtrl,
                  decoration: const InputDecoration(
                    labelText: "Theme",
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      widget.mode == CalendarMode.event
                          ? "Save Event"
                          : "Plan Trip",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
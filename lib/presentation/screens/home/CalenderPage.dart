import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

/* ================= MODEL ================= */

class OutfitEvent {
  final String id;
  final DateTime date;
  final String occasion;
  final String time;
  final String theme;
  final String weather;

  OutfitEvent({
    required this.id,
    required this.date,
    required this.occasion,
    required this.time,
    required this.theme,
    required this.weather,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "occasion": occasion,
        "time": time,
        "theme": theme,
        "weather": weather,
      };

  factory OutfitEvent.fromJson(Map<String, dynamic> json) {
    return OutfitEvent(
      id: json["id"],
      date: DateTime.parse(json["date"]),
      occasion: json["occasion"],
      time: json["time"],
      theme: json["theme"],
      weather: json["weather"],
    );
  }
}

/* ================= PAGE ================= */

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final List<OutfitEvent> events = [];

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  void deleteEvent(String id) {
    setState(() {
      events.removeWhere((e) => e.id == id);
    });

    saveEventsToCache(); // ⭐ update cache too
  }

  Future<void> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("events");

    if (data != null) {
      final List decoded = jsonDecode(data);
      events.clear();
      events.addAll(decoded.map((e) => OutfitEvent.fromJson(e)));
      setState(() {});
    }
  }

  Future<void> saveEventsToCache() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(events.map((e) => e.toJson()).toList());
    await prefs.setString("events", data);
  }

  /* ================= EVENT FILTER ================= */

  List<OutfitEvent> getEventsForDay(DateTime day) {
    return events
        .where((e) =>
            e.date.year == day.year &&
            e.date.month == day.month &&
            e.date.day == day.day)
        .toList();
  }

  bool isDuplicate(DateTime date, String time) {
    return events.any((e) =>
        e.date.year == date.year &&
        e.date.month == date.month &&
        e.date.day == date.day &&
        e.time == time);
  }

  /* ================= UI ================= */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Outfit Planner")),
      body: Column(
        children: [
          /* ================= CALENDAR ================= */

          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2035),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),

            startingDayOfWeek: StartingDayOfWeek.monday,

            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),

            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
            ),

            daysOfWeekVisible: true,

            // ⭐ ADD THIS (THIS IS THE FIX)
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final dayEvents = getEventsForDay(day);

                if (dayEvents.isEmpty) {
                  return null; // normal day rendering
                }

                final event = dayEvents.first;
                final isNight = event.time == "Night";

                return Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isNight
                        ? Colors.blueGrey.shade800
                        : Colors.orange.shade400,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),

            onDaySelected: (selected, focused) {
              setState(() {
                selectedDay = selected;
                focusedDay = focused;
              });

              _openEventPopup(selected);
            },
          ),
          const SizedBox(height: 30),

          /* ================= DIVIDER ================= */
          _divider(),
          const SizedBox(height: 30),
          /* ================= EVENT LIST ================= */

          Expanded(
            child: ListView(
              children: events.map((e) => _eventCard(e)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /* ================= EVENT CARD ================= */

  Widget _eventCard(OutfitEvent event) {
    final isNight = event.time == "Night";
    final textColor = isNight ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () => _openDetails(event),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isNight ? Colors.blueGrey.shade900 : Colors.orange.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isNight ? Colors.white10 : Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "${event.date.day}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    DateFormat.MMM().format(event.date),
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.occasion,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text("Theme: ${event.theme}",
                      style: TextStyle(color: textColor.withOpacity(0.8))),
                  Text("Time: ${event.time}",
                      style: TextStyle(color: textColor.withOpacity(0.8))),
                  Text("Weather: ${event.weather}",
                      style: TextStyle(color: textColor.withOpacity(0.8))),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Delete Event?"),
                    content: const Text(
                        "Are you sure you want to remove this event?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          deleteEvent(event.id);
                          Navigator.pop(context);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
              child: Icon(Icons.close, color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  /* ================= POPUP ================= */

  void _openEventPopup(DateTime date) {
    showDialog(
      context: context,
      builder: (_) {
        return EventFormDialog(
          date: date,
          onSave: (event) {
            setState(() {
              events.add(event);
            });

            saveEventsToCache(); // ⭐ FIX ADDED
          },
        );
      },
    );
  }

  /* ================= FULL SCREEN VIEW ================= */

  void _openDetails(OutfitEvent event) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight * 0.65,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24), // ⭐ MAIN ROUNDING
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24), // ⭐ CLIP CONTENT
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Stack(
                          children: [
                            // 🖼 IMAGE (no crop)
                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                color: Colors.grey.shade100,
                                child: Image.asset(
                                  "assets/images/mannequin.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            // ❌ CLOSE BUTTON (TOP RIGHT)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 📄 BOTTOM CONTENT
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ❌ CLOSE BUTTON

                              const SizedBox(height: 8),

                              const Text(
                                "Perfect For Today's Event",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "This outfit is designed based on your selected event, "
                                "weather conditions, and time preference. It ensures "
                                "maximum comfort and style balance.",
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _divider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 60, height: 3, color: Colors.grey),
        const SizedBox(width: 6),
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Container(width: 60, height: 3, color: Colors.grey),
      ],
    );
  }
}

class EventFormDialog extends StatefulWidget {
  final DateTime date;
  final Function(OutfitEvent) onSave;

  const EventFormDialog({
    super.key,
    required this.date,
    required this.onSave,
  });

  @override
  State<EventFormDialog> createState() => _EventFormDialogState();
}

class _EventFormDialogState extends State<EventFormDialog> {
  final TextEditingController occasionCtrl = TextEditingController();
  final TextEditingController themeCtrl = TextEditingController();

  String time = "Day";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Plan Outfit - ${widget.date.day}/${widget.date.month}",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 📝 OCCASION
          TextField(
            controller: occasionCtrl,
            decoration: const InputDecoration(
              labelText: "Occasion",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          // 🌗 DAY/NIGHT
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => time = "Day"),
                  child: _toggle("Day"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => time = "Night"),
                  child: _toggle("Night"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 🎨 THEME
          TextField(
            controller: themeCtrl,
            decoration: const InputDecoration(
              labelText: "Theme",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final event = OutfitEvent(
              id: DateTime.now().toString(),
              date: widget.date,
              occasion: occasionCtrl.text,
              time: time,
              theme: themeCtrl.text,
              weather: "Sunny",
            );

            widget.onSave(event);

            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }

  Widget _toggle(String label) {
    final selected = time == label;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

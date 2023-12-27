import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;

    return Center(
      child: TableCalendar(
          calendarFormat: _calendarFormat,
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2023, 12, 31),
          selectedDayPredicate: (day) {
            // Use isso para destacar o dia selecionado
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            // Callback quando um dia é selecionado
            print('Dia selecionado: $selectedDay');
            setState(() {
              _selectedDay = selectedDay;
            });
          },
          calendarBuilders: CalendarBuilders(
            // Personalize a aparência do dia
            selectedBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
    );
  }
}
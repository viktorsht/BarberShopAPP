class ScheduleEntity{
  final int id;
  final int barberman;
  final int customer;
  final String scheduleHours;
  final int service;
  final int payMethods;

  const ScheduleEntity({
    required this.id,
    required this.barberman, 
    required this.customer,
    required this.scheduleHours,
    required this.service,
    required this.payMethods
  });
}
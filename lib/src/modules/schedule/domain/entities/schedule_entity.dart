class ScheduleEntity{
  final int id;
  final String barberman;
  final String customer;
  final String scheduleHours;
  final String service;
  final String payMethods;

  const ScheduleEntity({
    required this.id,
    required this.barberman, 
    required this.customer,
    required this.scheduleHours,
    required this.service,
    required this.payMethods
  });
}
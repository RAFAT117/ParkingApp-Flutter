import 'package:flutter/material.dart';

class TicketProvider with ChangeNotifier {
  final List<Map<String, String>> _activeTickets = [];

  List<Map<String, String>> get activeTickets => _activeTickets;

  void addTicket(Map<String, String> ticket) {
    _activeTickets.add(ticket);
    notifyListeners();
  }
}
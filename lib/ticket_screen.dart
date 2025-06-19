import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ticket_provider.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Biljetter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Biljetter",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Här hittar du dina aktiva parkeringsbiljetter.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ticketProvider.activeTickets.isEmpty
                  ? const Center(
                      child: Text(
                        "Inga aktiva biljetter.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: ticketProvider.activeTickets.length,
                      itemBuilder: (context, index) {
                        final ticket = ticketProvider.activeTickets[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text("Plats: ${ticket['location']}"),
                            subtitle: Text(
                              "Starttid: ${ticket['startTime']}\nSluttid: ${ticket['endTime']}",
                            ),
                            trailing: const Icon(Icons.local_parking),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Konto-sektionen
          const Text(
            "Konto",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: const Text("Profil"),
            subtitle: const Text("Hantera din profil och kontoinformation"),
            onTap: () {
              // Navigera till profilsidan
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_card, color: Colors.blueAccent),
            title: const Text("Betalningar"),
            subtitle: const Text("Hantera betalningsmetoder"),
            onTap: () {
              // Navigera till betalningsinställningar
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.blueAccent),
            title: const Text("Park plus"),
            onTap: () {
              // Navigera till kontaktsidan
            },
          ),
          const Divider(),

          // Hjälp-sektionen
          const Text(
            "Hjälp",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.blueAccent),
            title: const Text("Vanliga frågor"),
            onTap: () {
              // Navigera till FAQ-sidan
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.blueAccent),
            title: const Text("Kontakta oss"),
            onTap: () {
              // Navigera till kontaktsidan
            },
          ),
          const Divider(),

          // Inställningar-sektionen
          const Text(
            "Inställningar",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.blueAccent),
            title: const Text("Notifikationer"),
            onTap: () {
              // Navigera till notifikationsinställningar
            },
          ),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.blueAccent),
            title: const Text("Språk"),
            onTap: () {
              // Navigera till språkändringsinställningar
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.blueAccent),
            title: const Text("Utseende"),
            onTap: () {
              // Navigera till kontaktsidan
            },
          ),
          const Divider(),

          // Om-sektionen
          const Text(
            "Om",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blueAccent),
            title: const Text("Om appen"),
            onTap: () {
              // Navigera till "Om appen"-sidan
            },
          ),
          ListTile(
            leading: const Icon(Icons.policy, color: Colors.blueAccent),
            title: const Text("Sekretesspolicy"),
            onTap: () {
              // Navigera till sekretesspolicy-sidan
            },
          ),
          ListTile(
            leading: const Icon(Icons.gavel, color: Colors.blueAccent),
            title: const Text("Användarvillkor"),
            onTap: () {
              // Navigera till användarvillkor-sidan
            },
          ),
        ],
      ),
    );
  }
}

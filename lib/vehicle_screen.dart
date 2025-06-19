import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final List<Map<String, String>> _vehicles = []; // Lista med fordon som map

  // Visa modal för att lägga till nytt fordon
  void _showAddVehicleModal(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Lägg till nytt fordon",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Registreringsnummer",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final String vehicle = controller.text.trim();
                    if (vehicle.isNotEmpty) {
                      setState(() {
                        _vehicles.add({
                          "reg": vehicle,
                          "nickname": "",
                          "color": "Vit",
                          "model": "Sedan"
                        }); // Lägg till fordon i listan
                      });
                      Navigator.pop(context); // Stäng modalen
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Lägg till fordon"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Visa modal för att redigera fordon
  void _showEditVehicleModal(BuildContext context, int index) {
    final vehicle = _vehicles[index];
    final TextEditingController nicknameController =
        TextEditingController(text: vehicle["nickname"]);
    String selectedColor = vehicle["color"]!;
    String selectedModel = vehicle["model"]!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Redigera fordon",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  labelText: "Smeknamn",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedColor,
                items: ["Vit", "Svart", "Röd", "Blå", "Grön"]
                    .map((color) => DropdownMenuItem(
                          value: color,
                          child: Text(color),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedColor = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Färg",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedModel,
                items: ["Sedan", "Halvkombi", "SUV", "Pickup"]
                    .map((model) => DropdownMenuItem(
                          value: model,
                          child: Text(model),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedModel = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Modell",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _vehicles[index] = {
                          "reg": vehicle["reg"]!,
                          "nickname": nicknameController.text,
                          "color": selectedColor,
                          "model": selectedModel,
                        };
                      });
                      Navigator.pop(context); // Stäng modalen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Bekräfta"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _vehicles.removeAt(index);
                      });
                      Navigator.pop(context); // Stäng modalen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Ta bort"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fordon"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dina fordon",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _vehicles.isEmpty
                  ? const Center(
                      child: Text(
                        "Inga fordon tillagda ännu.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _vehicles.length,
                      itemBuilder: (context, index) {
                        final vehicle = _vehicles[index];
                        return ListTile(
                          leading: const Icon(Icons.directions_car,
                              color: Colors.blueAccent),
                          title: Text(vehicle["reg"]!),
                          subtitle: Text(
                              "${vehicle["nickname"]} (${vehicle["color"]}, ${vehicle["model"]})"),
                          onTap: () => _showEditVehicleModal(context, index),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _showAddVehicleModal(context),
                icon: const Icon(Icons.add),
                label: const Text("Lägg till nytt fordon"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

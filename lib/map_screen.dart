import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ticket_screen.dart';
import 'parking_api.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(59.334591, 18.063240); // Malmö som startpunkt
  final Location _location = Location();
  LatLng? _currentLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadParkingData();
  }

  // Hämtar användarens plats
  Future<void> _getUserLocation() async {
    try {
      final permissionGranted = await _location.requestPermission();
      if (permissionGranted == PermissionStatus.granted) {
        final locationData = await _location.getLocation();
        setState(() {
          _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        });
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _currentLocation!,
              zoom: 14.0,
            ),
          ),
        );
      }
    } catch (e) {
      print("❌ Kunde inte hämta plats: $e");
    }
  }

 void _loadParkingData() async {
  try {
    print("🔍 Laddar parkeringsplatser...");
    final parkingLots = await ParkingApi.fetchParkingLots();
    setState(() {
      _markers = parkingLots.map((lot) {
        final double lat = lot['latitude'] as double;
        final double lng = lot['longitude'] as double;
        print("Lägger marker: ${lot['name']} på ($lat, $lng)");
        return Marker(
          markerId: MarkerId(lot['id'].toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: lot['name'],
            snippet: 'Parkering',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      }).toSet();
    });
    print("✅ Markeringar tillagda: ${_markers.length}");
  } catch (e) {
    print("🚨 Fel vid laddning av parkeringsdata: $e");
  }
}


  Future<void> _searchLocation(String query) async {
    const String apiKey = 'AIzaSyEXAMPLE1234567890APIKEY'; // Ange din Google Maps API-nyckel
    final String url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final location = data['results'][0]['geometry']['location'];
          final LatLng newLatLng = LatLng(location['lat'], location['lng']);
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: newLatLng,
                zoom: 16.0,
              ),
            ),
          );
        } else {
          print("🚨 Ingen plats hittades");
        }
      } else {
        print("🚨 API-fel: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Fel vid sökning: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Hitta parkering'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TicketScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Kartan täcker hela skärmen
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 14.0,
              ),
              markers: _markers,
            ),
          ),

          // Draggable panel för sökfält
          DraggableScrollableSheet(
            initialChildSize: 0.30,
            minChildSize: 0.13,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    // Dra-indikator
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.only(top: 10, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Sökfält
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Sök efter plats eller zonkod",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        onSubmitted: (query) {
                          _searchLocation(query);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

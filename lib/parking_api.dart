import 'package:http/http.dart' as http;
import 'dart:convert';

class ParkingApi {
  static const String apiKey = '64774687-e68e-4a8b-93ae-47efe3f297da';
  static const String baseUrl = 'https://openparking.stockholm.se/LTF-Tolken/v1/ptillaten/all';

  static Future<List<Map<String, dynamic>>> fetchParkingLots() async {
    const String url = '$baseUrl?outputFormat=json&apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        print("✅ API-svar: ${response.body}"); // Debug-logging

        if (data is Map && data.containsKey('features')) {
          return _parseParkingData(data['features']);
        } else {
          print("⚠️ JSON-svaret saknar 'features'.");
          return [];
        }
      } else {
        print("🚨 API-fel: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("🚨 Exception vid API-anrop: $e");
      return [];
    }
  }

  // Parsar en lista med features och beräknar en central punkt för varje parkeringsplats
  static List<Map<String, dynamic>> _parseParkingData(List<dynamic> features) {
    List<Map<String, dynamic>> parkingLots = [];

    for (var feature in features) {
      // Kontrollera att feature har geometri och properties
      if (feature['geometry'] != null && feature['properties'] != null) {
        String geometryType = feature['geometry']['type'];
        List<dynamic> coordinates = feature['geometry']['coordinates'];

        double lat;
        double lng;

        // Om det är en Point, ta värdena direkt
        if (geometryType == 'Point') {
          lng = coordinates[0];
          lat = coordinates[1];
        }
        // Om det är en LineString, beräkna medelvärdet av alla koordinater
        else if (geometryType == 'LineString') {
          double totalLat = 0.0;
          double totalLng = 0.0;
          int count = coordinates.length;
          for (var point in coordinates) {
            // GeoJSON anger longitud först
            totalLng += point[0];
            totalLat += point[1];
          }
          lat = totalLat / count;
          lng = totalLng / count;
        } else {
          // Om annat geometrityp – hoppa över
          continue;
        }

        String name = feature['properties']['STREET_NAME'] ?? 'Okänd plats';
        String id = feature['id'] ?? '';

        parkingLots.add({
          'id': id,
          'name': name,
          'latitude': lat,
          'longitude': lng,
        });

        print("📍 Parkeringsplats: $name | Lat: $lat, Lng: $lng");
      }
    }
    print("✅ Totalt ${parkingLots.length} parkeringsplatser hämtade.");
    return parkingLots;
  }
}



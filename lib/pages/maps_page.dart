import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  LatLng? _currentLocation;
  List<LatLng> smartbinLocations = [
    LatLng(-5.1491, 119.3952),
    LatLng(-5.140000, 119.420000),
    LatLng(-5.155000, 119.440000),
  ];
  LatLng? _nearestSmartbin;
  double? _shortestDistance;
  List<LatLng> _polylinePoints = [];

  @override
  void initState() {
    super.initState();
    _initLocationAndDistance();
  }

  Future<void> _initLocationAndDistance() async {
    LatLng location = await _getCurrentLocation();
    _calculateNearestSmartbin(location);
    await _fetchRoute(location, _nearestSmartbin!);
    setState(() {
      _currentLocation = location;
    });
  }

  Future<LatLng> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  }

  void _calculateNearestSmartbin(LatLng current) {
    double? minDistance;
    LatLng? nearest;

    for (var bin in smartbinLocations) {
      final distance = Geolocator.distanceBetween(
        current.latitude,
        current.longitude,
        bin.latitude,
        bin.longitude,
      );

      if (minDistance == null || distance < minDistance) {
        minDistance = distance;
        nearest = bin;
      }
    }

    _shortestDistance = minDistance;
    _nearestSmartbin = nearest;
  }

  Future<void> _fetchRoute(LatLng start, LatLng end) async {
    final url =
        'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry']['coordinates'] as List;

      setState(() {
        _polylinePoints =
            geometry.map((point) => LatLng(point[1], point[0])).toList();
      });
    } else {
      print('Failed to fetch route');
    }
  }

  void _openStreetView(double lat, double lng) async {
    final streetViewUrl =
        'https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=$lat,$lng';
    final fallbackMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    if (await canLaunchUrl(Uri.parse(streetViewUrl))) {
      final success = await launchUrl(Uri.parse(streetViewUrl),
          mode: LaunchMode.externalApplication);
      if (!success) {
        print('Gagal buka Street View, fallback ke Maps biasa.');
        await launchUrl(Uri.parse(fallbackMapUrl),
            mode: LaunchMode.externalApplication);
      }
    } else {
      print('Street View tidak tersedia, fallback ke Maps biasa.');
      await launchUrl(Uri.parse(fallbackMapUrl),
          mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lokasi Tempat Sampah')),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: _currentLocation,
                    zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'com.example.app',
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: _polylinePoints,
                          strokeWidth: 4.0,
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        // Marker pengguna
                        Marker(
                          point: _currentLocation!,
                          width: 40,
                          height: 40,
                          child: Icon(Icons.my_location,
                              color: Colors.blue, size: 40),
                        ),
                        // Marker smartbin
                        ...smartbinLocations.map((smartbin) {
                          return Marker(
                            point: smartbin,
                            width: 30,
                            height: 30,
                            child: GestureDetector(
                              onTap: () {
                                _openStreetView(
                                    smartbin.latitude, smartbin.longitude);
                              },
                              child: Icon(
                                smartbin == _nearestSmartbin
                                    ? Icons.delete_forever
                                    : Icons.delete,
                                color: smartbin == _nearestSmartbin
                                    ? Colors.green
                                    : Colors.red,
                                size: 30,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
                if (_shortestDistance != null)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Tempat sampah terdekat: ${_shortestDistance!.toStringAsFixed(1)} meter',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

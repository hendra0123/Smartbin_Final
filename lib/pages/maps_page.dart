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
  bool _locationDenied = false;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationDialog(
        title: 'Layanan Lokasi Tidak Aktif',
        content:
            'Aktifkan layanan lokasi untuk melihat tempat sampah terdekat.',
      );
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationDialog(
          title: 'Izin Lokasi Diperlukan',
          content:
              'Aplikasi membutuhkan izin lokasi untuk bekerja dengan benar.',
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationDialog(
        title: 'Izin Lokasi Ditolak Permanen',
        content:
            'Izin lokasi ditolak secara permanen. Silakan buka pengaturan aplikasi untuk mengaktifkannya.',
        openSettings: true,
      );
      return false;
    }

    return true;
  }

  void _showLocationDialog({
    required String title,
    required String content,
    bool openSettings = false,
  }) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.location_off, color: Colors.redAccent),
            const SizedBox(width: 8),
            Expanded(child: Text(title)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(content, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 12),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _locationDenied = true;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Tutup'),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.settings),
            label: Text(openSettings ? 'Buka Pengaturan' : 'Aktifkan Lokasi'),
            onPressed: () async {
              Navigator.of(context).pop();
              if (openSettings) {
                await Geolocator.openAppSettings();
              } else {
                await Geolocator.openLocationSettings();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeMaps();
  }

  Future<void> _initializeMaps() async {
    bool permissionGranted = await _handleLocationPermission();
    if (permissionGranted) {
      await _initLocationAndDistance();
    }
  }

  Future<void> _initLocationAndDistance() async {
    LatLng location = await _getCurrentLocation();
    _calculateNearestSmartbin(location);
    await _fetchRoute(location, _nearestSmartbin!);
    if (mounted) {
      setState(() {
        _currentLocation = location;
      });
    }
  }

  Future<void> _fetchRoute(LatLng start, LatLng end) async {
    final url =
        'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry']['coordinates'] as List;

      if (mounted) {
        setState(() {
          _polylinePoints =
              geometry.map((point) => LatLng(point[1], point[0])).toList();
        });
      }
    } else {
      print('Failed to fetch route');
    }
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
    if (_locationDenied) {
      return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Lokasi Tempat Sampah',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_off, size: 80, color: Colors.redAccent),
              const SizedBox(height: 24),
              Text(
                'Akses Lokasi Diperlukan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Untuk melihat rute dan tempat sampah terdekat, aplikasi memerlukan akses ke lokasi perangkat Anda.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Buka Pengaturan Lokasi'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await Geolocator.openAppSettings();
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  setState(() {
                    _locationDenied = false;
                  });
                  _initializeMaps();
                },
                child: Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'Lokasi Tempat Sampah',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
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

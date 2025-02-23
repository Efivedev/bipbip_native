import 'package:bipbip/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/home/destination_card.dart';
import '../widgets/home/service_bottom_sheet.dart';
import '../controllers/map_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? _originLocation;
  LatLng? _destinationLocation;
  String? _selectedService;
  bool _showServiceSelection = false;

  final MapController _mapController = MapController();
  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocation();
    });
  }

  Future<void> _initializeLocation() async {
    await _checkLocationPermission();
    if (_locationPermissionGranted) {
      final position = await _mapController.getCurrentLocation();
      if (position != null) {
        final latLng = LatLng(position.latitude, position.longitude);
        setState(() {
          _mapController.updateMarker(latLng);
        });
        _mapController.animateToPosition(latLng);
      }
    }
  }

  Future<void> _checkLocationPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Por favor activa el servicio de ubicación')),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Necesitamos acceso a tu ubicación')),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Por favor habilita los permisos de ubicación en la configuración'),
            ),
          );
        }
        return;
      }

      if (mounted) {
        setState(() {
          _locationPermissionGranted = true;
        });
      }
    } catch (e) {
      print("Error checking location permission: $e");
    }
  }

  // Add this method
  void _handleServiceSelection(String service) {
    setState(() {
      _selectedService = service;
      _showServiceSelection = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'BipBip',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // En el AppBar, actualizar el onPressed del IconButton:
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: !_locationPermissionGranted
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) =>
                      _mapController.mapController = controller,
                  initialCameraPosition: const CameraPosition(
                    target: MapController.iquitosCenter,
                    zoom: 14.0,
                  ),
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  markers: _mapController.markers,
                  polylines: _mapController.polylines,
                  // Agregar esta línea
                  onCameraMove: (position) {
                    _mapController.lastMapPosition = position.target;
                  },
                ),
               if (_originLocation == null && _destinationLocation == null)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Icon(
                        Icons.location_on,
                        size: 42,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                Column(
                  children: [
                    DestinationCard(
                      onOriginSelected: (place) {
                        setState(() {
                          _originLocation = LatLng(
                            place.geometry?.location.lat ?? 0,
                            place.geometry?.location.lng ?? 0,
                          );
                          _showServiceSelection = _destinationLocation != null;
                        });
                        if (_originLocation != null &&
                            _destinationLocation != null) {
                          _mapController.drawRoute(
                              _originLocation!, _destinationLocation!);
                        }
                      },
                      onDestinationSelected: (place) {
                        setState(() {
                          _destinationLocation = LatLng(
                            place.geometry?.location.lat ?? 0,
                            place.geometry?.location.lng ?? 0,
                          );
                          _showServiceSelection = _originLocation != null;
                        });
                        if (_originLocation != null &&
                            _destinationLocation != null) {
                          _mapController.drawRoute(
                              _originLocation!, _destinationLocation!);
                        }
                      },
                    ),
                    const Spacer(),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 300),
                      offset: _showServiceSelection
                          ? Offset.zero
                          : const Offset(0, 1),
                      child: ServiceBottomSheet(
                        onServiceSelected: _handleServiceSelection,
                        selectedService: _selectedService,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 16,
                  bottom: 250,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      final position =
                          await _mapController.getCurrentLocation();
                      if (position != null) {
                        final latLng =
                            LatLng(position.latitude, position.longitude);
                        setState(() {
                          _mapController.updateMarker(latLng);
                        });
                        _mapController.animateToPosition(latLng);
                      }
                    },
                    child:
                        const Icon(Icons.my_location, color: AppColors.primary),
                  ),
                ),
              ],
            ),
    );
  }
}

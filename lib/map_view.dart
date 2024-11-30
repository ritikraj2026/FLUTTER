import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<MapView> {
  final MapController _mapController = MapController();

  final List<LatLng> markerLocations = const [
    LatLng(37.7749, -122.4194),
    LatLng(37.7522, -122.4430),
    LatLng(37.7022, -122.4537),
    LatLng(37.7502, -122.4237),
    LatLng(37.7122, -122.4337),
    LatLng(37.7128, -122.4460),
  ];

  final List<Member> members = [
    Member("Wade Warren", "WSL0003", "09:30 am", "WORKING", Colors.green),
    Member("Esther Howard", "WSL0034", "09:30 am", "06:40 pm", Colors.red),
    Member("Cameron Williamson", "WSL0054", "Not Logged-in Yet", "",
        Colors.grey.shade200),
    Member("Brooklyn Simmons", "WSL0076", "09:30 am", "06:40 pm", Colors.red),
    Member("Savannah Nguyen", "WSL0065", "09:30 am", "06:40 pm", Colors.red),
    Member("Leslie Alexander", "WSL0069", "09:30 am", "06:40 pm", Colors.red),
    Member("Kathryn Murphy", "WSL0095", "09:30 am", "06:40 pm", Colors.red),
  ];

  void _zoomToFit() {
    var bounds = LatLngBounds.fromPoints(markerLocations);

    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(50)),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _zoomToFit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 55, 172),
        elevation: 1,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'ATTENDENCE',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(width: 8),
          ],
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: Color.fromARGB(255, 234, 240, 246),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.people,
                        color: const Color.fromARGB(255, 126, 118, 177)),
                    SizedBox(width: 8),
                    Text(
                      "All Members",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Change",
                    style: TextStyle(
                      color: Color.fromARGB(255, 71, 55, 172),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(51.509364, -0.128928),
                initialZoom: 3.2,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: markerLocations.map((location) {
                    return Marker(
                      point: location,
                      width: 80.0,
                      height: 80.0,
                      child: Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 71, 55, 172),
                        size: 50.0,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Show List view",
                      style: TextStyle(
                        color: Color.fromARGB(255, 71, 55, 172),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Color.fromARGB(255, 71, 55, 172), size: 18),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Member {
  final String name;
  final String id;
  final String checkIn;
  final String checkOut;
  final String status;
  final Color statusColor;

  Member(this.name, this.id, this.checkIn, this.checkOut, this.statusColor,
      {this.status = ""});
}

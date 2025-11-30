import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition intialCameraPosition;
  late GoogleMapController googleMapController;
  @override
  void initState() {
    intialCameraPosition = CameraPosition(
      target: LatLng(29.948358, 31.141849),
      zoom: 12,
    );

    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          zoomControlsEnabled: false,
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: LatLng(29.945358, 31.138849),
          //     northeast: LatLng(29.951358, 31.144849),
          //   ),
          // ),
          initialCameraPosition: intialCameraPosition,
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: () {
              initCameraStyle();
              googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(29.955358, 31.145849),
                    zoom: 14,
                  ),
                ),
              );
            },
            child: Text("Change Location"),
          ),
        ),
      ],
    );
  }

  void initCameraStyle() async {
    var newStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map-styles/retro_map_styles.json');
    googleMapController.setMapStyle(newStyle);
  }
}
 // Zoom level
 // World View  0-> 3
 // Country View 4-> 6
 //  City View  10-> 12
 //  Streets View 13->17
 //  Building Views 18->20
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/model/placement_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
    initMyMarkers();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
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
                    target: LatLng(40.535470, -74.151350),
                    zoom: 6,
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

  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imagecodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.toInt(),
    );
    var frameInfo = await imagecodec.getNextFrame();
    var byteData = await frameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!.buffer.asUint8List();
  }

  void initMyMarkers() async {
    await getImageFromRawData("assets/images/image.jpg", 48);
    // var markerIcon = await BitmapDescriptor.asset(
    //   ImageConfiguration(),
    //   "assets/images/image.jpg",
    // );
    var markerIcon =  BitmapDescriptor.bytes(
      await getImageFromRawData("assets/images/image.jpg", 200),
    );
    markers.addAll(
      PlacementModel.places.map((model) {
        return Marker(
          icon: markerIcon,
          markerId: MarkerId(model.id.toString()),
          position: model.latLng,
          infoWindow: InfoWindow(title: model.name),
        );
      }).toSet(),
    );
    setState(() {});
  }
}
 // Zoom level
 // World View  0-> 3
 // Country View 4-> 6
 //  City View  10-> 12
 //  Streets View 13->17
 //  Building Views 18->20
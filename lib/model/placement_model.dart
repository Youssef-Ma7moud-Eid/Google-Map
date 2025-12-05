import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacementModel {
  final int id;
  final String name;
  final LatLng latLng;
  PlacementModel({required this.id, required this.name, required this.latLng});
  static List<PlacementModel> places = [
    PlacementModel(
      id: 1,
      name: 'زاوية ابو مسلم',
      latLng: LatLng(29.921484, 31.173720),
    ),
    PlacementModel(
      id: 2,
      name: 'Place 2',
      latLng: LatLng(29.950545, 31.183190),
    ),
  ];
}

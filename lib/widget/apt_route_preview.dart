// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/widget/gpx_download.dart';

Widget _buildOsmAttributionLabel() {
  return Material(
    color: Colors.black.withValues(alpha: 0.68),
    borderRadius: BorderRadius.circular(6),
    child: InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        launchUrl(
          Uri.parse('https://www.openstreetmap.org/copyright'),
          mode: LaunchMode.externalApplication,
        );
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        child: Text(
          '\u00a9 OpenStreetMap contributors',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            height: 1.1,
          ),
        ),
      ),
    ),
  );
}

void _downloadGpxFile(String gpxData) async {
  await downloadGpxFile(gpxData);
}

class AptRoutePreview extends StatelessWidget {
  final RouteProposal route;
  final Color routeColor;

  const AptRoutePreview({
    Key? key,
    required this.route,
    this.routeColor = const Color(0xFF0066FF),
  }) : super(key: key);

  List<LatLng> _parseRoutePoints(String? routeGeoJson) {
    if (routeGeoJson == null || routeGeoJson.isEmpty) {
      return const [];
    }

    try {
      final dynamic decoded = jsonDecode(routeGeoJson);
      final points = <LatLng>[];
      _collectRoutePoints(decoded, points);
      return points;
    } catch (_) {
      return const [];
    }
  }

  void _collectRoutePoints(dynamic geoJson, List<LatLng> points) {
    if (geoJson is! Map<String, dynamic>) {
      return;
    }

    final type = geoJson['type'];
    if (type == 'FeatureCollection') {
      final features = geoJson['features'];
      if (features is List) {
        for (final feature in features) {
          _collectRoutePoints(feature, points);
        }
      }
      return;
    }

    if (type == 'Feature') {
      _collectRoutePoints(geoJson['geometry'], points);
      return;
    }

    if (type == 'LineString') {
      _addCoordinates(geoJson['coordinates'], points);
      return;
    }

    if (type == 'MultiLineString') {
      final lines = geoJson['coordinates'];
      if (lines is List) {
        for (final line in lines) {
          _addCoordinates(line, points);
        }
      }
    }
  }

  void _addCoordinates(dynamic coordinates, List<LatLng> points) {
    if (coordinates is! List) {
      return;
    }

    for (final coordinate in coordinates) {
      if (coordinate is! List || coordinate.length < 2) {
        continue;
      }

      final longitude = (coordinate[0] as num?)?.toDouble();
      final latitude = (coordinate[1] as num?)?.toDouble();

      if (latitude != null && longitude != null) {
        points.add(LatLng(latitude, longitude));
      }
    }
  }

  Widget? _buildRouteDurationOverlay() {
    int duration = route.durationMins ?? 0;
    if (duration <= 0) {
      return null;
    }
    return Positioned(
      left: 8,
      top: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              route.mode == RoutingMode.bike ? Icons.directions_bike : Icons.directions_walk,
              size: 16,
              color: primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '${duration} Min.',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routePoints = _parseRoutePoints(route.routeGeoJSON);
    if (routePoints.length < 2) {
      return const SizedBox.shrink();
    }

    final Widget? routeDurationOverlay = _buildRouteDurationOverlay();
    final bounds = LatLngBounds.fromPoints(routePoints);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
      child: SizedBox(
        height: 160,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AptRouteDetailPage(
                routePoints: routePoints,
                routeColor: routeColor,
                routingMode: route.mode,
                routeDurationOverlay: routeDurationOverlay,
                routeGpx: route.routeGPX ?? '',
              ),
            ),
          ),
          child: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCameraFit: CameraFit.bounds(
                    bounds: bounds,
                    padding: const EdgeInsets.all(20),
                  ),
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.none,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'aptapp',
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        strokeWidth: 4,
                        color: routeColor,
                      ),
                    ],
                  ),
                  CurrentLocationLayer(),
                ],
              ),
              if (routeDurationOverlay != null) routeDurationOverlay,
              Positioned(
                right: 8,
                bottom: 8,
                child: _buildOsmAttributionLabel(),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    context.i18n.tapToExpand,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AptRouteDetailPage extends StatelessWidget {
  final List<LatLng> routePoints;
  final Color routeColor;
  final RoutingMode? routingMode;
  final Widget? routeDurationOverlay;
  final String routeGpx;

  const AptRouteDetailPage({
    Key? key,
    required this.routePoints,
    required this.routeColor,
    required this.routingMode,
    required this.routeDurationOverlay,
    required this.routeGpx,
  }) : super(key: key);

  String _formatLatLng(LatLng point) => '${point.latitude},${point.longitude}';

  List<LatLng> _sampleWaypoints(List<LatLng> points, {int maxWaypoints = 8}) {
    if (points.length <= 2) {
      return const [];
    }

    final intermediates = points.sublist(1, points.length - 1);
    if (intermediates.length <= maxWaypoints) {
      return intermediates;
    }

    final sampled = <LatLng>[];
    final seen = <String>{};
    for (var i = 0; i < maxWaypoints; i++) {
      final t = (i + 1) / (maxWaypoints + 1);
      final index = (t * (intermediates.length - 1)).round();
      final point = intermediates[index];
      final key = _formatLatLng(point);
      if (seen.add(key)) {
        sampled.add(point);
      }
    }
    return sampled;
  }

  String? _googleTravelMode() {
    if (routingMode == RoutingMode.walk) {
      return 'walking';
    }
    if (routingMode == RoutingMode.bike) {
      return 'bicycling';
    }
    return null;
  }

  Uri _buildGoogleMapsDirectionsUri() {
    final origin = routePoints.first;
    final destination = routePoints.last;
    final waypoints = _sampleWaypoints(routePoints);

    final params = <String, String>{
      'api': '1',
      'origin': _formatLatLng(origin),
      'destination': _formatLatLng(destination),
    };

    final travelMode = _googleTravelMode();
    if (travelMode != null) {
      params['travelmode'] = travelMode;
    }

    if (waypoints.isNotEmpty) {
      params['waypoints'] = waypoints.map(_formatLatLng).join('|');
    }

    return Uri.https('www.google.com', '/maps/dir/', params);
  }

  String? _appleDirectionFlag() {
    if (routingMode == RoutingMode.walk) {
      return 'w';
    }
    return null;
  }

  Uri _buildAppleMapsDirectionsUri() {
    final destination = routePoints.last;
    final params = <String, String>{
      'daddr': _formatLatLng(destination),
    };

    final dirFlag = _appleDirectionFlag();
    if (dirFlag != null) {
      params['dirflg'] = dirFlag;
    }

    return Uri.https('maps.apple.com', '/', params);
  }

  Future<void> _startNavigation(BuildContext context) async {
    final navigationUri = _buildGoogleMapsDirectionsUri();
    var didLaunch = await launchUrl(
      navigationUri,
      mode: LaunchMode.externalApplication,
    );

    if (!didLaunch && !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      final appleMapsUri = _buildAppleMapsDirectionsUri();
      didLaunch = await launchUrl(
        appleMapsUri,
        mode: LaunchMode.externalApplication,
      );
    }

    if (!didLaunch && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open navigation app.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bounds = LatLngBounds.fromPoints(routePoints);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Route'),
        actions: [
          if (routeGpx.isNotEmpty)
            IconButton(
              tooltip: 'GPX',
              icon: const Icon(Icons.file_download),
              onPressed: () => _downloadGpxFile(routeGpx),
            ),
          IconButton(
            tooltip: context.i18n.startNavigation,
            icon: const Icon(Icons.navigation),
            onPressed: () => _startNavigation(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCameraFit: CameraFit.bounds(
                bounds: bounds,
                padding: const EdgeInsets.all(28),
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'aptapp',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints,
                    strokeWidth: 5,
                    color: routeColor,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: routePoints.first,
                    width: 20,
                    height: 20,
                    child: const Icon(Icons.play_circle_fill, color: Colors.green, size: 20),
                  ),
                  Marker(
                    point: routePoints.last,
                    width: 20,
                    height: 20,
                    child: const Icon(Icons.flag_circle, color: Colors.red, size: 20),
                  ),
                ],
              ),
              CurrentLocationLayer(),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: _buildOsmAttributionLabel(),
          ),
        ],
      ),
    );
  }
}

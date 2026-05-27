import 'package:apt_api/api.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../colors.dart';

class LocationPicker extends StatefulWidget {
  final LocationDTO? initialLocation;
  final String initialLocationAddress;
  final String labelText;
  final Function(LocationDTO?, String) onLocationChanged;
  final String? errorText;
  final LocationDTO? homeLocation;
  final String? homeLocationAddress;
  final LocationDTO? workLocation;
  final String? workLocationAddress;

  LocationPicker({
    Key? key,
    required this.labelText,
    required this.onLocationChanged,
    this.initialLocation,
    this.initialLocationAddress = "",
    this.errorText,
    this.homeLocation,
    this.homeLocationAddress,
    this.workLocation,
    this.workLocationAddress,
  }) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LocationDTO? location;
  String locationAddress = "";

  @override
  void initState() {
    super.initState();
    location = widget.initialLocation;
    locationAddress = widget.initialLocationAddress;
  }

  Future<void> _pickLocation(bool useHomeLocation) async {
    if (!mounted) return;
    LatLong initialPosition = location != null ? LatLong(location!.latitude!, location!.longitude!) : LatLong(47.80452041904827, 13.03096081298628);
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(context.i18n.location)),
          body: FlutterLocationPicker(
            initZoom: 11,
            minZoomLevel: 5,
            maxZoomLevel: 16,
            trackMyPosition: true,
            showSelectLocationButton: true,
            showZoomController: true,
            initPosition: initialPosition,
            userAgent: 'aktivplan+',
            mapLanguage: Localizations.localeOf(context).languageCode,
            selectLocationButtonText: context.i18n.select,
            onPicked: (pickedData) {
              Navigator.of(_).pop({
                "lat": pickedData.latLong.latitude,
                "lng": pickedData.latLong.longitude,
                "address": getAdressName(pickedData.addressData),
              });
            },
            showContributorBadgeForOSM: true,
          ),
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        location = LocationDTO(longitude: result["lng"], latitude: result["lat"]);
        locationAddress = result["address"];
      });
      widget.onLocationChanged(location, locationAddress);
    }
  }

  getAdressName(Map<String, dynamic> addressData) {
    if (addressData.containsKey('amenity')) {
      return addressData['amenity'];
    }
    String toReturn = "";
    if (addressData.containsKey('road')) {
      toReturn += addressData['road']!;
    }
    if (addressData.containsKey('house_number')) {
      toReturn += " " + addressData['house_number']!;
    }
    if (addressData.containsKey('postcode')) {
      toReturn += ", " + addressData['postcode']!;
    }
    if (addressData.containsKey('city')) {
      toReturn += " " + addressData['city']!;
    } else if (addressData.containsKey('village')) {
      toReturn += " " + addressData['village']!;
    }
    if (addressData.containsKey('country')) {
      toReturn += ", " + addressData['country']!;
    }
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (widget.homeLocation != null)
              _presetLocationButton(
                icon: Icons.home,
                label: context.i18n.homeLocation,
                selected: _isLocationEqual(location, widget.homeLocation),
                onPressed: () {
                  setState(() {
                    location = widget.homeLocation;
                    locationAddress = widget.homeLocationAddress ?? locationAddress;
                  });
                  widget.onLocationChanged(location, locationAddress);
                },
              ),
            if (widget.workLocation != null)
              _presetLocationButton(
                icon: Icons.work,
                label: context.i18n.workLocation,
                selected: _isLocationEqual(location, widget.workLocation),
                onPressed: () {
                  setState(() {
                    location = widget.workLocation;
                    locationAddress = widget.workLocationAddress ?? locationAddress;
                  });
                  widget.onLocationChanged(location, locationAddress);
                },
              ),
            if (locationAddress.isEmpty)
              _presetLocationButton(
                icon: Icons.location_on_outlined,
                label: context.i18n.select,
                selected: true,
                onPressed: () => _pickLocation(true),
              ),
            if (locationAddress.isNotEmpty)
              _presetLocationButton(
                icon: Icons.location_on_outlined,
                labelWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        locationAddress,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (location != null) ...[
                      const SizedBox(width: 8),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            location = null;
                            locationAddress = "";
                          });
                          widget.onLocationChanged(location, locationAddress);
                        },
                        child: Icon(Icons.clear, size: 18),
                      ),
                    ],
                  ],
                ),
                selected: true,
                onPressed: () => _pickLocation(true),
              ),
            /*      ElevatedButton(
              style: getElevatedButtonStyle(context, backgroundColor: primaryColor.withValues(alpha: .2)),
              onPressed: () => _pickLocation(true),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      locationAddress.isEmpty ? context.i18n.select : locationAddress,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (location != null) ...[
                    const SizedBox(width: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          location = null;
                          locationAddress = "";
                        });
                        widget.onLocationChanged(location, locationAddress);
                      },
                      child: Icon(Icons.clear, size: 18),
                    ),
                  ],
                ],
              ),
            ),*/
          ],
        ),
        if ((widget.errorText ?? '').isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 13),
            ),
          ),
      ],
    );
  }

  bool _isLocationEqual(LocationDTO? a, LocationDTO? b) {
    if (a == null || b == null) return false;
    return a.latitude == b.latitude && a.longitude == b.longitude;
  }

  Widget _presetLocationButton(
      {required IconData icon, String? label, Widget? labelWidget, required bool selected, required VoidCallback onPressed}) {
    final Color bg = selected ? primaryColor.withValues(alpha: .2) : Colors.white;
    return SizedBox(
      height: 42,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          minimumSize: const Size(64, 42),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: bg,
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: labelWidget ?? Text(label ?? '', overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

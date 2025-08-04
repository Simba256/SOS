import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/auth/firebase_auth/auth_util.dart';

String latLngToCommaSeparated(LatLng? userlatLng) {
  if (userlatLng == null) {
    return '';
  }
  return '${userlatLng.latitude},${userlatLng.longitude}';
}

Color generateColorFromString(String name) {
  final List<Color> accessibleColors = [
    Color(0xFF2E67A0), // Blue - 5.2:1 contrast ratio
    Color(0xFF00AA55), // Green - 4.8:1 contrast ratio
    Color(0xFF8B0000), // Burgundy - 8.1:1 contrast ratio
    Color(0xFF0F2347), // Navy - 12.3:1 contrast ratio
    Color(0xFF6A0DAD), // Purple - 6.8:1 contrast ratio
  ];

  final hash = name.hashCode;
  return accessibleColors[hash % accessibleColors.length];
}

String getInitialsRobust(String name) {
  if (name.isEmpty) return '?';

  // Clean and split the name
  final cleanedName = name.trim().replaceAll(RegExp(r'\s+'), ' ');
  final nameParts =
      cleanedName.split(' ').where((part) => part.isNotEmpty).toList();

  if (nameParts.isEmpty) return '?';

  // Single name case
  if (nameParts.length == 1) {
    return nameParts.first.substring(0, 1).toUpperCase();
  }

  // Multiple names - take first and last
  return nameParts.first.substring(0, 1).toUpperCase() +
      nameParts.last.substring(0, 1).toUpperCase();
}

bool shouldShowContact(
  String name,
  String contact,
  String? searchTerm,
) {
  // If search term is null or empty, show all contacts
  if (searchTerm == null || searchTerm.isEmpty) {
    return true;
  }

  // Convert to lowercase for case-insensitive search
  String lowerSearch = searchTerm.toLowerCase();
  String lowerName = name.toLowerCase();
  String lowerContact = contact.toLowerCase();

  // Return true if either name or contact contains the search term
  return lowerName.contains(lowerSearch) || lowerContact.contains(lowerSearch);
}

List<LatLng> getRandomPointsOutsideCircle() {
  final math.Random rng = math.Random();
  const double radiusSquared = 0.2025;
  const double minDistance = 0.2;
  const double minDistanceSquared = minDistance * minDistance;

  final List<LatLng> points = [];

  bool isFarEnough(LatLng p1, LatLng p2) {
    double dx = p1.latitude - p2.latitude;
    double dy = p1.longitude - p2.longitude;
    return (dx * dx + dy * dy) >= minDistanceSquared;
  }

  while (points.length < 4) {
    double x = -1 + 2 * rng.nextDouble(); // x ∈ [-1, 1]
    double y = -1 + 2 * rng.nextDouble(); // y ∈ [-1, 1]

    double distToCircleCenterSquared = x * x + (y + 0.1) * (y + 0.1);
    if (distToCircleCenterSquared <= radiusSquared) continue;

    LatLng candidate = LatLng(x, y);

    bool valid = true;
    for (final p in points) {
      if (!isFarEnough(p, candidate)) {
        valid = false;
        break;
      }
    }

    if (valid) {
      points.add(candidate);
    }
  }

  return points;
}

List<String>? separateText(String? stringParam) {
  // seprate text with : character
  if (stringParam == null) {
    return null;
  }

  return stringParam.split(':');
}

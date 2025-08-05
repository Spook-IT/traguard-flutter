import 'package:flutter/material.dart';

/// Simple model representing a training session preview used in the
/// dashboard mockup. This contains only the fields necessary for
/// displaying static information in the dashboard UI.
class SessionPreview {
  const SessionPreview({
    required this.name,
    required this.date,
    required this.durationMinutes,
    required this.players,
    required this.intensity,
    required this.distanceKm,
    required this.averageSpeed,
    required this.maxSpeed,
  });

  final String name;
  final DateTime date;
  final int durationMinutes;
  final int players;
  final String intensity;
  final double distanceKm;
  final double averageSpeed;
  final double maxSpeed;

  String get formattedDate =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

/// Sample sessions shown on the dashboard. These are placeholders
/// used to match the design of the provided mockup.
const List<SessionPreview> sampleSessions = [
  SessionPreview(
    name: 'Allenamento Tattico - 4-3-3',
    date: DateTime(2024, 1, 29),
    durationMinutes: 90,
    players: 11,
    intensity: 'Alta',
    distanceKm: 78.5,
    averageSpeed: 8.2,
    maxSpeed: 28.5,
  ),
  SessionPreview(
    name: 'Preparazione Atletica',
    date: DateTime(2024, 1, 28),
    durationMinutes: 75,
    players: 8,
    intensity: 'Massima',
    distanceKm: 60.0,
    averageSpeed: 7.5,
    maxSpeed: 26.0,
  ),
  SessionPreview(
    name: 'Partitella 11 vs 11',
    date: DateTime(2024, 1, 27),
    durationMinutes: 120,
    players: 11,
    intensity: 'Media',
    distanceKm: 95.0,
    averageSpeed: 7.0,
    maxSpeed: 25.0,
  ),
  SessionPreview(
    name: 'Tecnica Individuale',
    date: DateTime(2024, 1, 26),
    durationMinutes: 60,
    players: 6,
    intensity: 'Bassa',
    distanceKm: 40.0,
    averageSpeed: 6.0,
    maxSpeed: 22.0,
  ),
  SessionPreview(
    name: 'Allenamento Setpiece',
    date: DateTime(2024, 1, 25),
    durationMinutes: 45,
    players: 11,
    intensity: 'Bassa',
    distanceKm: 30.0,
    averageSpeed: 5.5,
    maxSpeed: 21.0,
  ),
  SessionPreview(
    name: 'Test Fisico Pre-Stagione',
    date: DateTime(2024, 1, 24),
    durationMinutes: 105,
    players: 11,
    intensity: 'Massima',
    distanceKm: 85.0,
    averageSpeed: 8.0,
    maxSpeed: 29.0,
  ),
];

/// Returns a color associated with the session intensity badge.
Color intensityColor(BuildContext context, String intensity) {
  switch (intensity.toLowerCase()) {
    case 'massima':
      return Colors.red;
    case 'alta':
      return Colors.orange;
    case 'media':
      return Colors.yellow.shade700;
    default:
      return Colors.green;
  }
}

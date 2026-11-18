import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int fee;
  final Color avatarColor; // On utilise une couleur à la place de l'image
  final IconData icon;     // Et une icône

  Doctor(this.name, this.specialty, this.rating, this.fee, this.avatarColor, this.icon);
}

class Specialty {
  final String name;
  Specialty(this.name);
}

List<Specialty> specialties = [
  Specialty("General Medicine"),
  Specialty("Cardiology"),
  Specialty("Pediatrics"),
  Specialty("Neurology"),
  Specialty("Dermatology"),
  Specialty("Ophthalmology"),
];

List<Doctor> doctors = [
  Doctor("Dr. Grace Uwimana", "Cardiology", 4.9, 20000, const Color(0xFFE57373), Icons.favorite),
  Doctor("Dr. Eric Ndayisaba", "Cardiology", 4.7, 15000, const Color(0xFF64B5F6), Icons.monitor_heart),
  Doctor("Dr. Patrick Habimana", "General Medicine", 4.8, 12000, const Color(0xFF81C784), Icons.medical_services),
  Doctor("Dr. Josiane Ingabire", "Pediatrics", 4.9, 15000, const Color(0xFFFFB74D), Icons.child_care),
  Doctor("Dr. Alain Kamanzi", "Neurology", 4.8, 20000, const Color(0xFFBA68C8), Icons.psychology),
];
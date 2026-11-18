import 'package:flutter/material.dart';
import 'data.dart';

class SuccessScreen extends StatelessWidget {
  final Doctor doctor;
  final String date;
  final String time;

  const SuccessScreen({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // La coche verte (Feedback visuel)
              const Icon(Icons.check_circle, size: 100, color: Color(0xFF1E8E5A)),
              const SizedBox(height: 20),
              
              // Le message de succès
              const Text(
                "You're booked!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF243746)),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your appointment is confirmed. We'll send you a reminder.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF587080)),
              ),
              const SizedBox(height: 40),

              // La carte récapitulative
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFDCE6EB)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    _buildRow("Doctor", doctor.name),
                    const Divider(height: 24),
                    _buildRow("Date", date),
                    const Divider(height: 24),
                    _buildRow("Time", time),
                    const Divider(height: 24),
                    _buildRow("Fee", "${doctor.fee} RWF", isBold: true),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Bouton pour revenir au Dashboard
              ElevatedButton(
                onPressed: () {
                  // On revient tout au début (au Dashboard)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087F8C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Un petit widget pour faire les lignes du récapitulatif
  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF587080))),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? const Color(0xFF087F8C) : const Color(0xFF243746),
            fontSize: isBold ? 18 : 14,
          ),
        ),
      ],
    );
  }
}
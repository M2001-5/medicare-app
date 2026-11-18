import 'package:flutter/material.dart';
import 'app_state.dart';
import 'data.dart';
import 'booking_screen.dart';

class DoctorsListScreen extends StatelessWidget {
  final String specialty;
  final AppState appState;
  
  const DoctorsListScreen({super.key, required this.specialty, required this.appState});

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = doctors.where((d) => d.specialty == specialty).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FA),
      appBar: AppBar(
        title: Text(specialty),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
      ),
      body: filteredDoctors.isEmpty
          ? const Center(child: Text("No doctors available."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(
                          doctor: doctor,
                          appState: appState,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFDCE6EB)),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // L'avatar avec la couleur et l'icône
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: doctor.avatarColor.withOpacity(0.2),
                            child: Icon(doctor.icon, color: doctor.avatarColor, size: 30),
                          ),
                          const SizedBox(width: 16),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doctor.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF243746))),
                                const SizedBox(height: 4),
                                Text(doctor.specialty, style: const TextStyle(color: Color(0xFF587080))),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Color(0xFFF2A93B), size: 16),
                                    const SizedBox(width: 4),
                                    Text(doctor.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF243746))),
                                    const Spacer(),
                                    Text("${doctor.fee} RWF", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF087F8C))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
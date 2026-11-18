import 'package:flutter/material.dart';
import 'app_state.dart';
import 'booking_screen.dart';

class MyAppointmentsScreen extends StatelessWidget {
  final AppState appState;

  const MyAppointmentsScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FA),
      appBar: AppBar(
        title: const Text('My Appointments'),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
      ),
      body: appState.appointments.isEmpty
          ? const Center(child: Text("No appointments yet.", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: appState.appointments.length,
              itemBuilder: (context, index) {
                final appt = appState.appointments[index];
                final isCancelled = appt.status == 'Cancelled';
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFDCE6EB)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFFDDF3F2),
                            child: Text(
                              appt.doctor.name.split(' ')[1][0] + appt.doctor.name.split(' ')[2][0],
                              style: const TextStyle(color: Color(0xFF087F8C), fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appt.doctor.name, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isCancelled ? Colors.grey : const Color(0xFF243746),
                                )),
                                Text(appt.doctor.specialty, style: const TextStyle(color: Color(0xFF587080))),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isCancelled ? const Color(0xFFFDECEA) : const Color(0xFFE4F5EC),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              appt.status,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isCancelled ? const Color(0xFFB3261E) : const Color(0xFF1E8E5A),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text("${appt.date} at ${appt.time}", style: const TextStyle(color: Color(0xFF243746))),
                        ],
                      ),
                      if (!isCancelled) ...[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // Action de modification
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingScreen(
                                        doctor: appt.doctor,
                                        appState: appState,
                                        existingAppointment: appt,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Reschedule"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  appState.cancelAppointment(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Appointment cancelled')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFDECEA), 
                                  foregroundColor: const Color(0xFFB3261E)
                                ),
                                child: const Text("Cancel"),
                              ),
                            ),
                          ],
                        )
                      ]
                    ],
                  ),
                );
              },
            ),
    );
  }
}
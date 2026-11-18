import 'package:flutter/material.dart';
import 'app_state.dart';
import 'data.dart';
import 'payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final Doctor doctor;
  final AppState appState;
  final Appointment? existingAppointment;

  const BookingScreen({
    super.key,
    required this.doctor,
    required this.appState,
    this.existingAppointment,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedDate;
  String? selectedTime;

  final List<String> dates = ["Mon 24", "Tue 25", "Wed 26", "Thu 27", "Fri 28", "Sat 29"];
  final List<String> times = ["08:30", "09:00", "09:30", "10:00", "11:00", "14:00", "15:30"];

  @override
  void initState() {
    super.initState();
    // Si on modifie un rendez-vous existant, on pré-remplit les champs
    if (widget.existingAppointment != null) {
      selectedDate = widget.existingAppointment!.date;
      selectedTime = widget.existingAppointment!.time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FA),
      appBar: AppBar(
        title: Text(widget.existingAppointment != null ? 'Modifier le RDV' : 'Date & Time'),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDCE6EB)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFDDF3F2),
                    child: Icon(Icons.person, color: Color(0xFF087F8C)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.doctor.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("${widget.doctor.specialty} • ${widget.doctor.fee} RWF", style: const TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text("Choose a date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final date = dates[index];
                  final isSelected = selectedDate == date;
                  return GestureDetector(
                    onTap: () => setState(() => selectedDate = date),
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF087F8C) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isSelected ? const Color(0xFF087F8C) : const Color(0xFFDCE6EB)),
                      ),
                      child: Center(
                        child: Text(
                          date,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF243746),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text("Available times", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: times.map((time) {
                final isSelected = selectedTime == time;
                return GestureDetector(
                  onTap: () => setState(() => selectedTime = time),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF087F8C) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? const Color(0xFF087F8C) : const Color(0xFFDCE6EB)),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF243746),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedDate != null && selectedTime != null)
                    ? () {
                        if (widget.existingAppointment != null) {
                          // Mode Modification : on met à jour et on revient
                          final index = widget.appState.appointments.indexOf(widget.existingAppointment!);
                          widget.appState.updateAppointment(index, selectedDate!, selectedTime!);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Rendez-vous modifié !')),
                          );
                        } else {
                          // Mode Réservation : on va au paiement
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                doctor: widget.doctor,
                                date: selectedDate!,
                                time: selectedTime!,
                                appState: widget.appState,
                              ),
                            ),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087F8C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
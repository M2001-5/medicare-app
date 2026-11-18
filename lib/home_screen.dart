import 'package:flutter/material.dart';
import 'app_state.dart';
import 'data.dart';
import 'doctors_list_screen.dart';
import 'login_screen.dart';
import 'my_appointments_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;
  const HomeScreen({super.key, required this.appState});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildDashboard(context),
      MyAppointmentsScreen(appState: widget.appState),
      ProfileScreen(appState: widget.appState),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FA),
      appBar: AppBar(
        title: const Text('MediCare'),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen(appState: widget.appState)),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF087F8C),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Visits'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    final upcoming = widget.appState.appointments.where((a) => a.status == 'Upcoming').toList();
    final nextAppt = upcoming.isNotEmpty ? upcoming.first : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning, ${widget.appState.userName.split(' ')[0]}!',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF243746)),
          ),
          const SizedBox(height: 20),
          
          // Carte du prochain RDV avec Dégradé
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0A8C9A), Color(0xFF055A64)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: nextAppt != null 
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                        SizedBox(width: 8),
                        Text('Next Appointment', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(nextAppt.doctor.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text('${nextAppt.doctor.specialty} • ${nextAppt.date} at ${nextAppt.time}', style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF087F8C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('View details'),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.white70, size: 16),
                        SizedBox(width: 8),
                        Text('No upcoming visits', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Book your first appointment.', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF087F8C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Book now'),
                    )
                  ],
                ),
          ),
          const SizedBox(height: 30),
          const Text('Medical Specialties', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF243746))),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
            ),
            itemCount: specialties.length,
            itemBuilder: (context, index) {
              final spec = specialties[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorsListScreen(
                        specialty: spec.name,
                        appState: widget.appState,
                      ),
                    ),
                  ).then((_) => setState(() {}));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFDCE6EB)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icône de spécialité
                      Icon(_getIconForSpecialty(spec.name), color: const Color(0xFF087F8C), size: 28),
                      const SizedBox(height: 8),
                      Text(
                        spec.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF087F8C), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getIconForSpecialty(String name) {
    switch (name) {
      case 'Cardiology': return Icons.favorite;
      case 'Pediatrics': return Icons.child_care;
      case 'Neurology': return Icons.psychology;
      case 'Dermatology': return Icons.face;
      case 'Ophthalmology': return Icons.remove_red_eye;
      default: return Icons.medical_services;
    }
  }
}
import 'package:flutter/material.dart';
import 'app_state.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final AppState appState;
  const ProfileScreen({super.key, required this.appState});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.appState.userName);
    _phoneController = TextEditingController(text: widget.appState.userPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FA),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFFDDF3F2),
                        child: Text(
                          widget.appState.userName.split(' ').length > 1 
                              ? widget.appState.userName.split(' ')[0][0] + widget.appState.userName.split(' ')[1][0]
                              : widget.appState.userName[0],
                          style: const TextStyle(color: Color(0xFF087F8C), fontWeight: FontWeight.bold, fontSize: 20)
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isEditing) ...[
                              TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
                              TextField(controller: _phoneController, decoration: const InputDecoration(labelText: "Phone")),
                            ] else ...[
                              Text(widget.appState.userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF243746))),
                              Text(widget.appState.userEmail, style: const TextStyle(color: Color(0xFF587080))),
                              Text(widget.appState.userPhone, style: const TextStyle(color: Color(0xFF587080))),
                            ]
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(isEditing ? Icons.save : Icons.edit, color: const Color(0xFF087F8C)),
                        onPressed: () {
                          if (isEditing) {
                            widget.appState.updateProfile(_nameController.text, _phoneController.text);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil mis à jour !')));
                          }
                          setState(() => isEditing = !isEditing);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen(appState: widget.appState)),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFB3261E),
                  side: const BorderSide(color: Color(0xFFB3261E)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Log Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class Appointment {
  final Doctor doctor;
  String date;
  String time;
  String status;

  Appointment({
    required this.doctor,
    required this.date,
    required this.time,
    this.status = 'Upcoming',
  });
}

class AppState extends ChangeNotifier {
  final List<Appointment> appointments = [];
  
  // Informations de l'utilisateur (simulées avec SharedPreferences)
  String userName = "Amara Uwase";
  String userEmail = "amara@example.com";
  String userPhone = "788123456";
  String userPassword = "MediCare1";

  AppState() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? "Amara Uwase";
    userEmail = prefs.getString('userEmail') ?? "amara@example.com";
    userPhone = prefs.getString('userPhone') ?? "788123456";
    userPassword = prefs.getString('userPassword') ?? "MediCare1";
    notifyListeners();
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // Si l'email est déjà utilisé (dans notre simulation, on vérifie juste si c'est celui par défaut)
    if (email == userEmail) return false; 

    userName = name;
    userEmail = email;
    userPhone = phone;
    userPassword = password;

    await prefs.setString('userName', userName);
    await prefs.setString('userEmail', userEmail);
    await prefs.setString('userPhone', userPhone);
    await prefs.setString('userPassword', userPassword);
    
    notifyListeners();
    return true;
  }

  bool login(String email, String password) {
    if (email == userEmail && password == userPassword) {
      return true;
    }
    return false;
  }

  Future<void> updateProfile(String name, String phone) async {
    userName = name;
    userPhone = phone;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('userPhone', userPhone);
    notifyListeners();
  }

  void addAppointment(Doctor doctor, String date, String time) {
    appointments.add(Appointment(doctor: doctor, date: date, time: time));
    notifyListeners();
  }

  void cancelAppointment(int index) {
    appointments[index].status = 'Cancelled';
    notifyListeners();
  }

  void updateAppointment(int index, String newDate, String newTime) {
    appointments[index].date = newDate;
    appointments[index].time = newTime;
    notifyListeners();
  }
}
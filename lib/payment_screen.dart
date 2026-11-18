import 'package:flutter/material.dart';
import 'app_state.dart';
import 'data.dart';
import 'success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Doctor doctor;
  final String date;
  final String time;
  final AppState appState;

  const PaymentScreen({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
    required this.appState,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = 'Mobile Money';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FA),
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte du montant
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDCE6EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Amount due", style: TextStyle(color: Color(0xFF587080))),
                  const SizedBox(height: 5),
                  Text("${widget.doctor.fee} RWF", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF087F8C))),
                  const SizedBox(height: 5),
                  Text("${widget.doctor.name} • ${widget.date} • ${widget.time}", style: const TextStyle(color: Color(0xFF587080))),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text("Payment method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // Choix Mobile Money
            _buildPaymentOption('Mobile Money', Icons.phone_android),
            const SizedBox(height: 10),
            
            // Choix Carte Bancaire
            _buildPaymentOption('Credit / debit card', Icons.credit_card),
            const SizedBox(height: 10),

            // Choix Payer à l'hôpital
            _buildPaymentOption('Pay at hospital', Icons.local_hospital),
            
            const SizedBox(height: 20),

            // Champs de saisie conditionnels
            if (selectedMethod == 'Mobile Money')
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Numéro Mobile Money (+250)",
                    prefixIcon: const Icon(Icons.phone_android, color: Color(0xFF087F8C)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              )
            else if (selectedMethod == 'Credit / debit card') ...[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Numéro de carte",
                    prefixIcon: const Icon(Icons.credit_card, color: Color(0xFF087F8C)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Date d'expiration (MM/YY)",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "CVV",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 40),
            
            // Bouton Payer
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.appState.addAppointment(widget.doctor, widget.date, widget.time);
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessScreen(
                        doctor: widget.doctor,
                        date: widget.date,
                        time: widget.time,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087F8C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  selectedMethod == 'Pay at hospital' ? 'Confirm booking' : 'Pay ${widget.doctor.fee} RWF',
                  style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget pour les boutons de paiement
  Widget _buildPaymentOption(String title, IconData icon) {
    final isSelected = selectedMethod == title;
    return InkWell(
      onTap: () => setState(() => selectedMethod = title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF9F8) : Colors.white,
          border: Border.all(color: isSelected ? const Color(0xFF087F8C) : const Color(0xFFDCE6EB), width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF087F8C) : Colors.grey),
            const SizedBox(width: 16),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? const Color(0xFF087F8C) : const Color(0xFF243746))),
            const Spacer(),
            if (isSelected) const Icon(Icons.check_circle, color: Color(0xFF087F8C)),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'confirmation_screen.dart';


class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> classDetails;
  const PaymentScreen({super.key, required this.classDetails});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _paymentMethod = 'card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Детали занятия', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildClassSummary(),
            const SizedBox(height: 20),
            const Text('Способ оплаты', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildPaymentMethodSelector(),
            if (_paymentMethod == 'card') _buildCardDetailsForm(),
            const SizedBox(height: 20),
            _buildPriceSummary(),
          ],
        ),
      ),
      bottomNavigationBar: _buildPayButton(),
    );
  }

  Widget _buildClassSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(widget.classDetails['image'], width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.classDetails['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.classDetails['instructor'], style: const TextStyle(color: Colors.grey)),
                const Text('Пн, 20 Окт, 18:00', style: TextStyle(color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      children: [
        RadioListTile(
          title: const Text('Банковская карта'),
          value: 'card',
          groupValue: _paymentMethod,
          onChanged: (value) => setState(() => _paymentMethod = value!),
          secondary: const Icon(Icons.credit_card),
        ),
        RadioListTile(
          title: const Text('Apple Pay / Google Pay'),
          value: 'mobile',
          groupValue: _paymentMethod,
          onChanged: (value) => setState(() => _paymentMethod = value!),
          secondary: const Icon(Icons.phone_android),
        ),
      ],
    );
  }

  Widget _buildCardDetailsForm() {
    return const Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Номер карты')),
        Row(
          children: [
            Expanded(child: TextField(decoration: InputDecoration(labelText: 'Срок действия'))),
            SizedBox(width: 10),
            Expanded(child: TextField(decoration: InputDecoration(labelText: 'CVV'), obscureText: true)),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSummary() {
    return const Card(
      color: Color(0xFFE8D5F2),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Стоимость занятия'), Text('₽800')]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Скидка'), Text('-₽0', style: TextStyle(color: Colors.green))]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Итого'), Text('₽800', style: TextStyle(fontWeight: FontWeight.bold))]),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.check, color: Colors.white),
        label: const Text('Оплатить ₽800', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfirmationScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9B59B6),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}

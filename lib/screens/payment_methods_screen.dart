import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Способы оплаты'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Логика добавления новой карты
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPaymentMethodCard(
            context,
            cardType: 'Visa',
            lastFourDigits: '4242',
            isDefault: true,
          ),
          _buildPaymentMethodCard(
            context,
            cardType: 'Mastercard',
            lastFourDigits: '5555',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(
    BuildContext context, {
    required String cardType,
    required String lastFourDigits,
    bool isDefault = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(
          cardType == 'Visa' ? Icons.credit_card : Icons.credit_card_outlined,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
        title: Text('$cardType **** $lastFourDigits'),
        subtitle: isDefault ? const Text('Основная карта') : null,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            // обработка выбора
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'edit',
              child: Text('Редактировать'),
            ),
            if (!isDefault)
              const PopupMenuItem<String>(
                value: 'default',
                child: Text('Сделать основной'),
              ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Удалить'),
            ),
          ],
        ),
      ),
    );
  }
}

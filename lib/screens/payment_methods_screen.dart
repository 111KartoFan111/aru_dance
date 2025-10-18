import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<Map<String, dynamic>> paymentMethods = [
    {
      'id': '1',
      'cardType': 'Visa',
      'lastFourDigits': '4242',
      'isDefault': true,
      'expiryDate': '12/25',
    },
    {
      'id': '2',
      'cardType': 'Mastercard',
      'lastFourDigits': '5555',
      'isDefault': false,
      'expiryDate': '09/26',
    },
  ];

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
              _showAddCardDialog();
            },
          ),
        ],
      ),
      body: paymentMethods.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                return _buildPaymentMethodCard(
                  context,
                  paymentMethod: paymentMethods[index],
                  index: index,
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.credit_card_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Нет сохраненных карт',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Добавьте карту для быстрой оплаты',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _showAddCardDialog();
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Добавить карту', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9B59B6),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(
    BuildContext context, {
    required Map<String, dynamic> paymentMethod,
    required int index,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: paymentMethod['isDefault']
              ? LinearGradient(
                  colors: [
                    const Color(0xFF9B59B6).withOpacity(0.1),
                    const Color(0xFFD4A5E8).withOpacity(0.1),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: paymentMethod['cardType'] == 'Visa'
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.credit_card,
              color: paymentMethod['cardType'] == 'Visa'
                  ? Colors.blue
                  : Colors.orange,
              size: 28,
            ),
          ),
          title: Text(
            '${paymentMethod['cardType']} •••• ${paymentMethod['lastFourDigits']}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text('Срок: ${paymentMethod['expiryDate']}'),
              if (paymentMethod['isDefault']) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9B59B6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Основная',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              _handleMenuSelection(value, index);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 12),
                    Text('Редактировать'),
                  ],
                ),
              ),
              if (!paymentMethod['isDefault'])
                const PopupMenuItem<String>(
                  value: 'default',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 20),
                      SizedBox(width: 12),
                      Text('Сделать основной'),
                    ],
                  ),
                ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Удалить', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuSelection(String value, int index) {
    switch (value) {
      case 'edit':
        _showEditCardDialog(index);
        break;
      case 'default':
        setState(() {
          for (var method in paymentMethods) {
            method['isDefault'] = false;
          }
          paymentMethods[index]['isDefault'] = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Карта установлена как основная')),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(index);
        break;
    }
  }

  void _showAddCardDialog() {
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();
    String selectedCardType = 'Visa';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Добавить карту'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedCardType,
                      decoration: const InputDecoration(
                        labelText: 'Тип карты',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Visa', 'Mastercard', 'МИР']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedCardType = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: cardNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Номер карты',
                        hintText: '0000 0000 0000 0000',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 19,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: expiryController,
                            decoration: const InputDecoration(
                              labelText: 'Срок',
                              hintText: 'ММ/ГГ',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: cvvController,
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                              hintText: '123',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (cardNumberController.text.length >= 16 &&
                        expiryController.text.length == 5 &&
                        cvvController.text.length == 3) {
                      setState(() {
                        String lastFour = cardNumberController.text
                            .replaceAll(' ', '')
                            .substring(
                              cardNumberController.text.replaceAll(' ', '').length - 4,
                            );
                        paymentMethods.add({
                          'id': DateTime.now().toString(),
                          'cardType': selectedCardType,
                          'lastFourDigits': lastFour,
                          'isDefault': paymentMethods.isEmpty,
                          'expiryDate': expiryController.text,
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Карта успешно добавлена')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Заполните все поля корректно'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B59B6),
                  ),
                  child: const Text('Добавить', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditCardDialog(int index) {
    final expiryController = TextEditingController(
      text: paymentMethods[index]['expiryDate'],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактировать карту'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: expiryController,
                decoration: const InputDecoration(
                  labelText: 'Срок действия',
                  hintText: 'ММ/ГГ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                if (expiryController.text.length == 5) {
                  setState(() {
                    paymentMethods[index]['expiryDate'] = expiryController.text;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Карта обновлена')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9B59B6),
              ),
              child: const Text('Сохранить', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удалить карту?'),
          content: Text(
            'Вы уверены, что хотите удалить карту ${paymentMethods[index]['cardType']} •••• ${paymentMethods[index]['lastFourDigits']}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  paymentMethods.removeAt(index);
                  // Если удалили основную карту и есть другие карты
                  if (paymentMethods.isNotEmpty) {
                    bool hasDefault = paymentMethods.any((m) => m['isDefault']);
                    if (!hasDefault) {
                      paymentMethods[0]['isDefault'] = true;
                    }
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Карта удалена')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Удалить', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
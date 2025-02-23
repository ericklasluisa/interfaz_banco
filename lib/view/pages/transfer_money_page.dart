import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../controller/card_controller.dart';
import '../../controller/payment_controller.dart';
import '../../model/card_model.dart' as card_model;

class TransferMoneyPage extends StatefulWidget {
  const TransferMoneyPage({super.key});

  @override
  State<TransferMoneyPage> createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _destinationCardController = TextEditingController();
  card_model.Card? _selectedSourceCard;
  bool _isLoading = false;

  bool get _isTransferDisabled =>
      _isLoading || (_selectedSourceCard?.isFrozen ?? false);

  void _mostrarMensaje(String mensaje, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: isError ? Colors.red.shade400 : Colors.green.shade400,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _realizarTransferencia() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final payment = await PaymentController.makePayment(
        _selectedSourceCard!.id!,
        _destinationCardController.text,
        double.parse(_amountController.text),
      );

      if (!mounted) return;

      if (payment.status == 'EXITOSO') {
        _mostrarMensaje('Transferencia realizada exitosamente', false);
        Navigator.pop(context, true);
      } else {
        _mostrarMensaje('Error: ${payment.status}', true);
      }
    } catch (e) {
      if (!mounted) return;
      _mostrarMensaje(e.toString(), true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Agregamos método para actualizar la tarjeta seleccionada
  void _updateSelectedCard(card_model.Card card) {
    setState(() => _selectedSourceCard = card);
  }

  Widget _buildBalanceInfo(card_model.Card card) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
      child: Row(
        children: [
          const Icon(
            Icons.account_balance_wallet_outlined,
            size: 16,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            'Saldo disponible: \$${card.balance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: _destinationCardController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.credit_card, color: Colors.black),
              labelText: 'Número de tarjeta destino',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el número de tarjeta';
              }
              if (value.length != 16) {
                return 'El número debe tener 16 dígitos';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: _amountController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.attach_money, color: Colors.black),
              labelText: 'Monto a transferir',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el monto';
              }
              final amount = double.tryParse(value);
              if (amount == null || amount <= 0) {
                return 'Ingrese un monto válido';
              }
              if (_selectedSourceCard != null &&
                  amount > _selectedSourceCard!.balance) {
                return 'Saldo insuficiente';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _realizarTransferencia,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.yellow.shade600,
              disabledBackgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.indigo.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Transferir', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildFrozenMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.ac_unit,
            size: 48,
            color: Colors.blue.shade700,
          ),
          const SizedBox(height: 16),
          Text(
            'Tarjeta Congelada',
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No es posible realizar transferencias con esta tarjeta porque se encuentra congelada. Para poder utilizarla, primero debes descongelarla.',
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.payments_outlined,
                color: Colors.yellow.shade600, size: 40),
            const SizedBox(width: 16),
            Text(
              'Transferir\nDinero',
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selecciona la tarjeta origen y el monto a transferir',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              // Selector de tarjeta origen
              FutureBuilder<List<card_model.Card>>(
                future: CardController.getUserCards(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final cards = snapshot.data ?? [];

                  if (cards.isEmpty) {
                    return const Text('No tienes tarjetas disponibles');
                  }

                  // Inicializamos _selectedSourceCard si es null
                  if (_selectedSourceCard == null) {
                    Future.microtask(() => _updateSelectedCard(cards.first));
                  } else {
                    // Actualizamos _selectedSourceCard con la instancia actual si existe
                    _selectedSourceCard = cards.firstWhere(
                      (card) => card.id == _selectedSourceCard!.id,
                      orElse: () => cards.first,
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonFormField<card_model.Card>(
                          value: _selectedSourceCard ?? cards.first,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.credit_card, color: Colors.black),
                            labelText: 'Tarjeta origen',
                          ),
                          items: cards.map((card) {
                            return DropdownMenuItem<card_model.Card>(
                              value: card,
                              child: Text(
                                '${card.cardType} ****${card.number.substring(card.number.length - 4)}',
                              ),
                            );
                          }).toList(),
                          onChanged: (card) {
                            if (card != null) {
                              _updateSelectedCard(card);
                            }
                          },
                          validator: (value) {
                            if (value == null) return 'Seleccione una tarjeta';
                            return null;
                          },
                        ),
                      ),
                      if (_selectedSourceCard != null || cards.isNotEmpty)
                        _buildBalanceInfo(_selectedSourceCard ?? cards.first),
                      const SizedBox(height: 16),
                      // Condicionalmente mostrar el formulario o mensaje de congelado
                      if (_selectedSourceCard?.isFrozen ?? false)
                        _buildFrozenMessage()
                      else
                        _buildTransferForm(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _destinationCardController.dispose();
    super.dispose();
  }
}

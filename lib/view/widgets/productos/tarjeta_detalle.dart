import 'package:flutter/material.dart';
import '../../../controller/card_controller.dart';
import '../../../model/card_model.dart' as card_model;

class TarjetaDetalle extends StatefulWidget {
  final card_model.Card card;

  const TarjetaDetalle({super.key, required this.card});

  @override
  State<TarjetaDetalle> createState() => _TarjetaDetalleState();
}

class _TarjetaDetalleState extends State<TarjetaDetalle> {
  bool _showSensitiveData = false;
  final _pinController = TextEditingController();
  card_model.Card? _currentCard;

  @override
  void initState() {
    super.initState();
    _currentCard = widget.card;
  }

  Future<void> _verificarPin() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Verificar PIN',
            style: TextStyle(color: Colors.indigo.shade900),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Ingresa el PIN de tu tarjeta para ver los datos completos'),
              const SizedBox(height: 16),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'PIN',
                  counterText: '',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar',
                  style: TextStyle(color: Colors.grey.shade600)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_pinController.text == widget.card.pin) {
                  setState(() => _showSensitiveData = true);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('PIN incorrecto'),
                      backgroundColor: Colors.red.shade400,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade600,
                foregroundColor: Colors.indigo.shade900,
              ),
              child: const Text('Verificar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _toggleFreezeCard() async {
    bool? confirmado = await showDialog(
      context: context,
      builder: (BuildContext context) {
        _pinController.clear();
        return AlertDialog(
          title: Text(
            'Verificar PIN',
            style: TextStyle(color: Colors.indigo.shade900),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_currentCard!.isFrozen
                  ? 'Ingresa el PIN para descongelar la tarjeta'
                  : 'Ingresa el PIN para congelar la tarjeta'),
              const SizedBox(height: 16),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'PIN',
                  counterText: '',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar',
                  style: TextStyle(color: Colors.grey.shade600)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_pinController.text == widget.card.pin) {
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('PIN incorrecto'),
                      backgroundColor: Colors.red.shade400,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade600,
                foregroundColor: Colors.indigo.shade900,
              ),
              child: const Text('Verificar'),
            ),
          ],
        );
      },
    );

    if (confirmado == true && mounted) {
      try {
        final updatedCard = await (_currentCard!.isFrozen
            ? CardController.toggleUnfreezeCard(_currentCard!.id!)
            : CardController.toggleFreezeCard(_currentCard!.id!));

        if (mounted) {
          setState(() {
            _currentCard = updatedCard;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(updatedCard.isFrozen
                  ? 'Tarjeta congelada exitosamente'
                  : 'Tarjeta descongelada exitosamente'),
              backgroundColor: Colors.green.shade400,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red.shade400,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = _currentCard ?? widget.card;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shadowColor: Colors.indigo.shade900,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _verificarPin(),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Primera fila: Tipo de tarjeta y badge de estado
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        card.cardType == 'CREDITO'
                            ? Icons.credit_card
                            : Icons.credit_card_outlined,
                        color: Colors.indigo.shade900,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        card.cardType,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: card.isFrozen
                          ? Colors.blue.shade50
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          card.isFrozen ? Icons.ac_unit : Icons.check_circle,
                          size: 16,
                          color: card.isFrozen ? Colors.blue : Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          card.isFrozen ? 'Congelada' : 'Activa',
                          style: TextStyle(
                            color: card.isFrozen ? Colors.blue : Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Segunda fila: Número de tarjeta y botón de congelar/descongelar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _showSensitiveData
                              ? card.number
                              : "******${card.number.substring(card.number.length - 4)}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (_showSensitiveData) ...[
                          const SizedBox(height: 8),
                          Text('CVV: ${card.cvv}'),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _toggleFreezeCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: card.isFrozen
                          ? Colors.blue.shade50
                          : Colors.blue.shade100,
                      foregroundColor: Colors.blue.shade900,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          card.isFrozen
                              ? Icons.ac_unit
                              : Icons.ac_unit_outlined,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          card.isFrozen
                              ? 'Descongelar tarjeta'
                              : 'Congelar tarjeta',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Tercera fila: Saldo y fecha de vencimiento
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Saldo Disponible',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${card.balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Vence',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        '${card.expiryMonth}/${card.expiryYear}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}

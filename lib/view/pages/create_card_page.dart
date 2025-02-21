import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../controller/card_controller.dart';
import '../../model/card_model.dart' as card_model;
import '../../provider/user_provider.dart';
import 'package:provider/provider.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({super.key});

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedCardType = 'DEBITO';
  final _pinController = TextEditingController();

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

  Future<void> _crearTarjeta() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Generar datos aleatorios para la tarjeta
      final now = DateTime.now();
      final card = card_model.Card(
        number: '4532${now.millisecondsSinceEpoch.toString().substring(0, 12)}',
        creationYear: now.year,
        expiryYear: now.year + 4,
        expiryMonth: now.month,
        cvv: (100 + now.millisecond % 899).toString(),
        cardType: _selectedCardType,
        isFrozen: false,
        pin: _pinController.text,
        balance: 0.0,
        user: context.read<UserProvider>().currentUser,
      );

      await CardController.createCard(context, card);

      if (!mounted) return;
      _mostrarMensaje('Tarjeta creada exitosamente', false);
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      _mostrarMensaje(e.toString(), true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
            Icon(Icons.account_balance,
                color: Colors.yellow.shade600, size: 40),
            const SizedBox(width: 16),
            Text(
              'Nueva\nTarjeta',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Selecciona el tipo de tarjeta y establece tu PIN',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: _selectedCardType,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.credit_card, color: Colors.black),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'DEBITO', child: Text('Débito')),
                    DropdownMenuItem(value: 'CREDITO', child: Text('Crédito')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedCardType = value!);
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
                padding: const EdgeInsets.only(left: 16),
                child: TextFormField(
                  controller: _pinController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock_outline, color: Colors.black),
                    border: InputBorder.none,
                    hintText: 'PIN (4 dígitos)',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un PIN';
                    }
                    if (value.length != 4) {
                      return 'El PIN debe tener 4 dígitos';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _crearTarjeta,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.yellow.shade600,
                  disabledBackgroundColor: Colors.yellow.shade100,
                  foregroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Crear Tarjeta',
                        style: TextStyle(fontSize: 16)),
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

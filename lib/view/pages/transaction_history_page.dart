import 'package:flutter/material.dart';
import '../../controller/transaction_controller.dart';
import '../../model/card_model.dart' as card_model;
import '../../model/transaction_model.dart';

class TransactionHistoryPage extends StatefulWidget {
  final card_model.Card card;

  const TransactionHistoryPage({super.key, required this.card});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  Key _futureBuilderKey = UniqueKey();

  void _refreshTransactions() {
    setState(() {
      _futureBuilderKey = UniqueKey();
    });
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
            Icon(Icons.history, color: Colors.yellow.shade600, size: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Historial',
                  style: TextStyle(
                    color: Colors.indigo.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  '****${widget.card.number.substring(widget.card.number.length - 4)}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshTransactions();
        },
        child: FutureBuilder<List<Transaction>>(
          key: _futureBuilderKey,
          future: TransactionController.getCardTransactions(widget.card.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 48, color: Colors.red.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red.shade800),
                    ),
                  ],
                ),
              );
            }

            final transactions = snapshot.data ?? [];

            if (transactions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty,
                        size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'No hay transacciones',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(
                      transaction.type == 'CREDITO'
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transaction.type == 'CREDITO'
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text(
                      transaction.type == 'CREDITO'
                          ? 'Transferencia recibida'
                          : 'Transferencia enviada',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(transaction.status),
                    trailing: Text(
                      '${transaction.type == 'CREDITO' ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: transaction.type == 'CREDITO'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

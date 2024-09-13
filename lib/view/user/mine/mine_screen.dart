import 'package:flutter/material.dart';

class MineScreen extends StatelessWidget {
  const MineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Crypto Mining Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Icon(
          Icons.minimize,
          size: 100,
          color: Colors.orange,
        ),
        const SizedBox(height: 20),
        const Text(
          'Mining Rate: 0.0000 BTC/h',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Total Earnings: 0.0000 BTC',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.orange,
          ),
          child: const Text('Start Mining'),
        ),
      ],
    ));
  }
}

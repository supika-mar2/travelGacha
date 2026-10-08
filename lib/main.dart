import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MaterialApp(home: HamsterGacha()));

class HamsterGacha extends StatefulWidget {
  const HamsterGacha({super.key});

  @override
  State<HamsterGacha> createState() => _HamsterGachaState();
}

class _HamsterGachaState extends State<HamsterGacha> {
  int n = 0, e = 0;
  bool loading = false;
  final emojis = ['🚌', '🚃', '🚢', '🚗'];
  final images = [
    'images/aburatsu.jpg',
    'images/hirugami.jpg',
    'images/nanokamachi.jpg',
    'images/rikuchuyagi.jpg',
    'images/shinanoomachi.jpg',
    'images/uno.jpg',
  ];
  final captions = [
    '油津港（宮崎県日南市）',
    '昼神温泉郷（長野県阿智村）',
    '七日町駅（福島県会津若松市）',
    '陸中八木駅（岩手県洋野町）',
    '大町山岳博物館（長野県大町市）',
    '宇野港（岡山県玉野市）',
  ];

  Future<void> gacha() async {
    setState(() => loading = true);
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() => e = (e + 1) % emojis.length);
    }
    setState(() {
      n = Random().nextInt(images.length);
      loading = false;
    });
  }

  @override
    Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('🗾 旅の行先ガチャ')),
      body: Center ( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: loading
                ? Center( 
                  child: Text(
                    emojis[e],
                    style: const TextStyle(fontSize: 100),
                  ),
                )
                : Image.network(images[n], fit: BoxFit.cover),
            ),
            const SizedBox(height: 30),
            if (!loading)
              Text(
                captions[n],
                style: const TextStyle(fontSize: 24),
              ),
            const Text('🗾', style: TextStyle(fontSize: 72)),
            ElevatedButton(
              onPressed: loading ? null : gacha, 
              child: const Text('ガチャを回す！'),
            ),
          ],
        ),
      ),
    );
}

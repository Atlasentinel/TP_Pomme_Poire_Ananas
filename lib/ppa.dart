import 'package:flutter/material.dart';

class FruitInfo {
  final String image;
  final String type;
  final Color color;

  FruitInfo(this.image, this.type, this.color);
}

class Ppa extends StatefulWidget {
  const Ppa({super.key, required this.title});

  final String title;

  @override
  State<Ppa> createState() => _Ppa();
}

class _Ppa extends State<Ppa> {
  final List<Map<String, dynamic>> _fruits = [];
  final List<String> _images = ["images/1.png", "images/2.png", "images/3.png"];
  int _counter = 0;

  bool isOdd(int counter) => counter % 2 != 0;

  bool isPremier(int counter) {
    if (counter <= 1) return false;
    for (int i = 2; i <= counter ~/ 2; i++) {
      if (counter % i == 0) return false;
    }
    return true;
  }

  FruitInfo getFruitInfo(int counter) {
    String image;
    String type;
    Color color;

    if (isPremier(counter)) {
      image = _images[0];
      type = "premier";
      color = const Color.fromARGB(255, 240, 105, 188);
    } else if (isOdd(counter)) {
      image = _images[1];
      type = "impair";
      color = const Color.fromARGB(255, 101, 241, 66);
    } else {
      image = _images[2];
      type = "pair";
      color = Colors.blueAccent;
    }

    return FruitInfo(image, type, color);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      FruitInfo fruitInfo = getFruitInfo(_counter);
      _fruits.add({
        "id": _counter,
        "image": fruitInfo.image,
        "type": fruitInfo.type,
        "color": fruitInfo.color,
      });
    });
  }

  void _showDialog(int index) {
    final fruit = _fruits[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fruit ${fruit['id']}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                fruit['image'],
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 10),
              Text("Type: ${fruit['type']}"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Fermer"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _fruits.removeAt(index);
                });
                // Désactive la boite de dialogue
                Navigator.of(context).pop();
              },
              child: const Text("Supprimer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "$_counter ${getFruitInfo(_counter).type}",
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                "Liste de fruits",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _fruits.length,
                  itemBuilder: (context, index) {
                    final fruit = _fruits[index];
                    return ListTile(
                      onTap: () => _showDialog(index),
                      tileColor: fruit['color'],
                      leading: Image.asset(
                        fruit['image'],
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        "Fruit ${fruit['id']}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Ajouter un fruit',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        mini: true,
        child: const Icon(Icons.add),
      ),
    );
  }
}
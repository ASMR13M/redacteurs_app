import 'package:flutter/material.dart';
import 'db/database.dart';
import 'models/redacteur.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Rédacteurs',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RedacteurInterface(),
    );
  }
}

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final _nomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  final _db = DatabaseHelper.instance;
  List<Redacteur> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await _db.getRedacteurs();
    setState(() => _items = data);
  }

  void _clearInputs() {
    _nomCtrl.clear();
    _emailCtrl.clear();
  }

  Future<void> _add() async {
    final nom = _nomCtrl.text.trim();
    final email = _emailCtrl.text.trim();

    if (nom.isEmpty || email.isEmpty) {
      _snack('Veuillez remplir tous les champs');
      return;
    }

    try {
      await _db.insertRedacteur(Redacteur(nom: nom, email: email));
      _clearInputs();
      await _load();
      _snack('Rédacteur ajouté');
    } catch (e) {
      _snack('Erreur: $e');
    }
  }

  void _snack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Rédacteurs')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomCtrl,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _add, child: const Text('Ajouter')),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final r = _items[index];
                  return ListTile(title: Text(r.nom), subtitle: Text(r.email));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

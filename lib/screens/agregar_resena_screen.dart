import 'package:flutter/material.dart';
import 'package:recetas_app/data/resenas_db.dart';
import 'package:recetas_app/models/resena.dart';

class AgregarResenaScreen extends StatefulWidget {
  final int recetaId;
  final String recetaNombre;

  const AgregarResenaScreen({
    super.key,
    required this.recetaId,
    required this.recetaNombre,
  });

  @override
  State<AgregarResenaScreen> createState() => _AgregarResenaScreenState();
}

class _AgregarResenaScreenState extends State<AgregarResenaScreen> {
  final _comentarioCtrl = TextEditingController();
  double _calificacion = 3;
  bool _guardando = false;

  final _db = ResenasDb.instancia;

  Future<void> _guardar() async {
    if (_comentarioCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe un comentario')),
      );
      return;
    }

    setState(() => _guardando = true);

    final resena = Resena(
      recetaId: widget.recetaId,
      comentario: _comentarioCtrl.text.trim(),
      calificacion: _calificacion,
    );

    await _db.insert(resena);

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _comentarioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar reseña'),
        backgroundColor: const Color.fromARGB(255, 80, 23, 3),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.recetaNombre,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Calificación:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _calificacion,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _calificacion.toStringAsFixed(0),
                    activeColor: Colors.deepOrange,
                    onChanged: (val) => setState(() => _calificacion = val),
                  ),
                ),
                Text(
                  '${_calificacion.toStringAsFixed(0)} ⭐',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Comentario:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _comentarioCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '¿Qué te pareció esta receta?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _guardando ? null : _guardar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _guardando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Guardar reseña',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recetas_app/models/receta.dart';

class RecipeService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<Receta>> obtenerRecetas() async {
    final response = await http.get(Uri.parse('$_baseUrl/recipes'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> lista = data['recipes'];
      return lista.map((json) => Receta.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener recetas: ${response.statusCode}');
    }
  }
}

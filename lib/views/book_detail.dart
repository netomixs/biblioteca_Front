import 'package:biblioteca_temporal/models/Model.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  BookDetailsPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.imagen),
            SizedBox(height: 16),
            Text(
              book.titulo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "ISBN: ${book.isbn}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              "Fecha de Publicación: ${book.fechaPublicacion}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              "Fecha de Adquisición: ${book.fechaAdquicicion}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              "Existencias: ${book.existencias}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              "Es Prestable: ${book.esPrestable ? 'Sí' : 'No'}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              "Descripción",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              book.descripcion,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Géneros",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...book.genero.map((g) => Text(
              g.nombre,
              style: TextStyle(fontSize: 16),
            )),
            SizedBox(height: 16),
            Text(
              "Autores",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...book.autor.map((a) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${a.persona.nombre} ${a.persona.apellidoP} ${a.persona.apellidoM}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Código: ${a.codigo}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Text(
                  "Nacimiento: ${a.persona.nacimiento}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Text(
                  "Sexo: ${a.persona.sexo}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 8),
              ],
            )),
          ],
        ),
      ) ;
  }
}

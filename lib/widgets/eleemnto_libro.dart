import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';

class ElementLibro extends StatelessWidget {
  final Map libro;
  final int index;
  final void Function()? onPressed;
  final void Function(BuildContext)? onPressedDelete;
  final void Function(BuildContext)? onPressedEdit;

  const ElementLibro({
    super.key,
    required this.index,
    this.onPressed,
    this.onPressedDelete,
    this.onPressedEdit,
    required this.libro,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(index),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        children: [
          SlidableAction(
            onPressed: onPressedDelete,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Eliminar',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onPressedEdit,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit_document,
            label: 'Editar',
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                  0, 3), // Cambia la dirección de la sombra (eje x, eje y)
            ),
          ],
        ),
        child: Row(
          children: [
            // Container para la imagen (lado derecho)
            Container(
              width: 100, // ajusta según el tamaño de tu imagen
              height: 100, // ajusta según el tamaño de tu imagen
              child: Image.network(
                libro["Imagen"], // Reemplaza por la URL de tu imagen
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10), // Espacio entre la imagen y el título
            // Columna para el título y el autor (lado izquierdo)
            Expanded(
                child: ListTile(
                  onTap: onPressed,
              title: Text(
                libro["Titulo"],
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                "Autor: ${libro["autor"][0]["persona"]["Nombre"]} ${libro["autor"][0]["persona"]["Apellido_P"]} ${libro["autor"][0]["persona"]["Apellido_M"]}",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

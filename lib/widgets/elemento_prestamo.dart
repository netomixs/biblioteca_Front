import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ElementoPrestamo extends StatefulWidget {
  final String id_prestamo;
  final String id_Admin;
  final String id_Lector;
  final String Fecha_Prestamo;
  final String Fecha_Limite;
  final String? Fecha_Entrega;
  final int index;

  final void Function()? onPressed;
  final void Function(BuildContext)? onPressedDelete;
  final void Function(BuildContext)? onPressedEdit;

  const ElementoPrestamo(
      {super.key,
      required this.id_prestamo,
      required this.id_Admin,
      required this.id_Lector,
      required this.Fecha_Prestamo,
      required this.Fecha_Limite,
      this.Fecha_Entrega,
      required this.index,
      this.onPressed,
      this.onPressedDelete,
      this.onPressedEdit});

  @override
  State<ElementoPrestamo> createState() => _ElementoPrestamoState();
}

class _ElementoPrestamoState extends State<ElementoPrestamo> {
  String Fecha_Prestamo = "";
  String Fecha_Limite = "";
  String? Fecha_Entrega = "";
  final formatoFecha = DateFormat('yyyy-MM-dd');

  TextStyle syleEstado = TextStyle();
  void initState() {
    super.initState();
    final _fechaLimite = formatoFecha.parse(widget.Fecha_Limite);

    Fecha_Prestamo = widget.Fecha_Prestamo;
    Fecha_Limite = widget.Fecha_Limite;

    if (widget.Fecha_Entrega == null) {
      Fecha_Entrega = "No entregado";
      if (DateTime.now().isBefore(_fechaLimite)) {
        syleEstado =
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
      } else {
        syleEstado = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
      }
    } else {
      Fecha_Entrega = widget.Fecha_Entrega;
      final _fechaEntrega = formatoFecha.parse(widget.Fecha_Entrega!);
      if (_fechaEntrega.isBefore(_fechaLimite)) {
        syleEstado =
            TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
      } else {
        syleEstado = TextStyle(color: Color.fromARGB(255, 255, 165, 47), fontWeight: FontWeight.bold);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(widget.index),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        children: [
          SlidableAction(
            onPressed: widget.onPressedDelete,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Eliminar',
          ),
        ],
      ),
      endActionPane: ((widget.Fecha_Entrega!=null) ?  null:   ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: widget.onPressedEdit,
            backgroundColor: Color.fromARGB(255, 101, 255, 70),
            foregroundColor: Colors.white,
            icon: Icons.receipt,
            label: 'Entregar libro',
          ),
        ],
      )),
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
            SizedBox(width: 10), // Espacio entre la imagen y el título
            // Columna para el título y el autor (lado izquierdo)
            Expanded(
                child: ListTile(
              onTap: widget.onPressed,
              title: Text(
                "Numero de prestamo: ${widget.id_prestamo}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Id del Lector: ${widget.id_Lector}" ),
                    Text("Prestado: ${Fecha_Prestamo}"),
                    Text("Fecha limite :  ${Fecha_Limite}"),
                    Text(
                      "Entregado :  ${Fecha_Entrega}",
                      style: syleEstado,
                    ),
                    Text("Clave de supervisor  ${widget.id_Admin}")
                  ]),
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownAutor extends StatefulWidget {
  final List<dynamic> opciones;
  final Function(int) onSeleccion;
  final String hintText;
    final int? indiceInicial;
  final IconData? icon;
  CustomDropdownAutor(
      {required this.opciones,
      required this.onSeleccion,
      required this.hintText,
      this.icon, this.indiceInicial});

  @override
  _CustomDropdownAutorState createState() => _CustomDropdownAutorState();
}

class _CustomDropdownAutorState extends State<CustomDropdownAutor> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    if (widget.indiceInicial != null) {
      int index = widget.opciones
          .indexWhere((opcion) => opcion["Id"] == widget.indiceInicial);
      _selectedIndex = index;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: DropdownButtonFormField2(
          hint: Text(
              "${widget.opciones[_selectedIndex]["Codigo"]} - ${widget.opciones[_selectedIndex]["persona"]["Nombre"]} ${widget.opciones[_selectedIndex]["persona"]["Apellido_P"]} ${widget.opciones[_selectedIndex]["persona"]["Apellido_M"]}"),
          value: _selectedIndex == -1 ? null : _selectedIndex,
          items: _buildDropdownItems(),
          decoration: InputDecoration(
            prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
            hintText: widget.hintText,
            labelText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          onChanged: (index) {
            setState(() {
              _selectedIndex = index as int;
            });
            widget.onSeleccion(index as int);
          },
        ));
  }

  List<DropdownMenuItem<int>> _buildDropdownItems() {
    return widget.opciones
        .asMap()
        .entries
        .map<DropdownMenuItem<int>>(
          (entry) => DropdownMenuItem<int>(
            value: entry.key,
            child: Text(
                "${entry.value["Codigo"]} - ${entry.value["persona"]["Nombre"]} ${entry.value["persona"]["Apellido_P"]} ${entry.value["persona"]["Apellido_M"]}"),
          ),
        )
        .toList();
  }
}

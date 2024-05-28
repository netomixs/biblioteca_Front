import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<dynamic> opciones;
  final Function(int) onSeleccion;
  final String hintText;
  final IconData? icon;
  final int? indiceInicial; // Nuevo parámetro opcional

  CustomDropdown(
      {required this.opciones,
      required this.onSeleccion,
      required this.hintText,
      this.icon,
      this.indiceInicial});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
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
          hint: Text("${widget.opciones[_selectedIndex]["Nombre"]}"),
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
            child: Text(entry.value['Nombre']),
          ),
        )
        .toList();
  }
}

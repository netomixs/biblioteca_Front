import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SexoDropdown extends StatefulWidget {
  final List<Map<String, String>> opciones;
  final Function(String) onSeleccion;
  final String hintText;
  final IconData? icon;
  final String? identificadorInicial;

  SexoDropdown({
    required this.opciones,
    required this.onSeleccion,
    required this.hintText,
    this.icon,
    this.identificadorInicial,
  });

  @override
  _SexoDropdownState createState() => _SexoDropdownState();
}

class _SexoDropdownState extends State<SexoDropdown> {
  String? _selectedIdentificador;

  @override
  void initState() {
    super.initState();
    if (widget.identificadorInicial != null) {
      _selectedIdentificador = widget.identificadorInicial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: DropdownButtonFormField2(
        hint: Text(_selectedIdentificador != null
            ? widget.opciones
                .firstWhere((opcion) =>
                    opcion['Identificador'] == _selectedIdentificador)['Nombre']
                .toString()
            : widget.hintText),
        value: _selectedIdentificador,
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
        onChanged: (identificador) {
          setState(() {
            _selectedIdentificador = identificador as String?;
          });
          widget.onSeleccion(identificador as String);
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return widget.opciones
        .map<DropdownMenuItem<String>>(
          (opcion) => DropdownMenuItem<String>(
            value: opcion['Identificador'],
            child: Text(opcion['Nombre']!),
          ),
        )
        .toList();
  }
}
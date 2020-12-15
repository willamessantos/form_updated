import 'package:flutter/material.dart';

class DefaultInput extends StatelessWidget {
  final String label;
  final String Function(String) validator;
  final void Function(String) onSaved;
  final keyboardType;
  final String initialValue;

  const DefaultInput(
      {Key key, this.label, this.validator, this.onSaved, this.keyboardType, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: this.label,
      ),
      validator: this.validator,
      onSaved: this.onSaved,
    );
  }
}

import 'package:flutter/material.dart';

class ProviderButton extends StatefulWidget {
  final BuildContext context;
  final String signInType;

  const ProviderButton({Key key, this.context, this.signInType})
      : super(key: key);

  @override
  _ProviderButtonState createState() => _ProviderButtonState();
}

class _ProviderButtonState extends State<ProviderButton> {
  @override
  Widget build(BuildContext context) {
    return Text('Error');
  }
}

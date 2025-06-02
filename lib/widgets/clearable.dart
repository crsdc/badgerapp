import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

// Thanks to
// https://www.flutterclutter.dev/flutter/tutorials/text-field-with-clear-button/2020/104/

class ClearableTextField extends StatefulWidget {
  const ClearableTextField({
    required Key key,
    required this.controller,
    TextInputType? keyboardType,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _ClearableTextFieldState();
}

class _ClearableTextFieldState extends State<ClearableTextField> {
  bool _showClearButton = false;
  TextInputType? keyboardType;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _showClearButton = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: _getClearButton(),
      ),
    );
  }

  Widget? _getClearButton() {
    if (!_showClearButton) {
      return null;
    }

    return IconButton(
      onPressed: () => widget.controller.clear(),
      icon: const Icon(Icons.clear),
    );
  }
}

import '../exports_config.dart';

Widget customTextFormField({
  TextEditingController? controller,
  IconData? icon,
  String? hintText,
  TextInputType? keyboardType,
  TextCapitalization? textCapitalization,
  }) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization ?? TextCapitalization.sentences,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      filled: true,
      icon: Icon(icon, color: crimeRed),
      iconColor: crimeRed,
      focusColor: crimeRed,
      hintText: hintText,
      labelText: hintText,

      // TODO figure out how to reinstate this abstractly, e.g. Settings.dart before v1.3.7
      //suffixIcon: _getClearButton(),
    ),
  );
}

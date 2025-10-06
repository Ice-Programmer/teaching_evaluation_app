import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final double? width;
  final double height;
  final double borderRadius;
  final String? hintText;
  final double horizontalPadding;
  final double fontSize;
  final Color? backgroundColor;
  final int maxLines;
  final bool isPassword;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final IconData? prefixIcon;
  final double prefixGap;
  final String? defaultValue;
  final Color? borderColor;

  const CustomInput({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 10,
    this.hintText,
    this.horizontalPadding = 20,
    this.fontSize = 16,
    this.maxLines = 1,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.backgroundColor,
    this.prefixIcon,
    this.prefixGap = 20,
    this.defaultValue,
    this.borderColor,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final bool _obscureText = true;
  String? _errorMessage;
  final _fieldKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color:
                widget.backgroundColor ??
                Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border:
                _errorMessage != null
                    ? Border.all(color: Colors.red, width: 1.5)
                    : (widget.borderColor != null
                        ? Border.all(color: widget.borderColor!, width: 1.5)
                        : null),
          ),
          child: TextFormField(
            key: _fieldKey,
            initialValue: widget.defaultValue,
            maxLines: widget.maxLines,
            obscureText: widget.isPassword ? _obscureText : false,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: Colors.black,
              height: 1.0,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding,
                vertical: (widget.height - widget.fontSize) / 2,
              ),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: widget.fontSize,
                color: Colors.grey,
              ),
              errorStyle: const TextStyle(height: 0, fontSize: 0),
            ),
            validator: (value) {
              final error = widget.validator?.call(value);
              _errorMessage = error;
              return error;
            },
            onChanged: (value) {
              widget.onChanged?.call(value);
              Future.microtask(() {
                if (mounted) {
                  final state = _fieldKey.currentState;
                  final error = widget.validator?.call(value);
                  if (error != _errorMessage) {
                    setState(() {
                      _errorMessage = error;
                    });
                  }
                  state?.validate();
                }
              });
            },
          ),
        ),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10.0),
            child: Text(
              _errorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: widget.fontSize * 0.8,
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// 自定义输入框
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
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  // 控制密码可见性
  bool _obscureText = true;
  // 是否显示错误
  bool _hasError = false;
  // 错误信息
  String? _errorMessage;

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
                _hasError ? Border.all(color: Colors.red, width: 1.5) : null,
          ),
          child: TextFormField(
            maxLines: widget.maxLines,
            textAlignVertical: TextAlignVertical.center,
            obscureText: widget.isPassword ? _obscureText : false,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: Theme.of(context).colorScheme.inversePrimary,
              height: 1.0, // 固定行高
            ),
            // 确保输入框高度固定
            minLines: widget.maxLines,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding,
                vertical:
                    (widget.height - widget.fontSize) / 2, // 动态计算垂直内边距使文本居中
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: widget.fontSize,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              prefixIconColor: Theme.of(context).colorScheme.inversePrimary,
              prefixIconConstraints: BoxConstraints(
                minWidth: widget.prefixGap, // 设置最小宽度，控制间距
                minHeight: widget.height, // 设置最小高度，与输入框高度一致
              ),
              hintText: widget.hintText,
              suffixIcon:
                  widget.isPassword
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                      : Icon(
                        widget.prefixIcon,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
              // 完全移除错误样式的影响
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              // 禁用错误文本容器
              errorMaxLines: 0,
            ),
            onChanged: widget.onChanged,
            validator: (value) {
              if (widget.validator != null) {
                final error = widget.validator!(value);
                setState(() {
                  _hasError = error != null;
                  _errorMessage = error;
                });
                return null;
              }
              return null;
            },
          ),
        ),
        if (_hasError && _errorMessage != null)
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

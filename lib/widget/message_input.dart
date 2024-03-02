import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qnotes_flutter/main.dart';
import 'package:qnotes_flutter/widget/text_form_field_widget.dart';

class MessageInput extends StatefulWidget {
  const MessageInput(
      {required this.controller,
      this.node,
      this.hintText,
      this.suffixIcon,
      super.key});

  final TextEditingController controller;
  final FocusNode? node;
  final Widget? suffixIcon;
  final String? hintText;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: appTheme.lineColor,
        border: Border.all(color: appTheme.frameColor),
      ),
      child: TextFormFieldWidget(
        controller: widget.controller,
        hintText: widget.hintText ?? '',
        borderCircular: 8,
        focusNode: widget.node,
        vertical: 6,
        colorText: appTheme.textInputColor,
        focusedColor: appTheme.lineColor,
        cursorColor: appTheme.fatherActiveColor,
        colorSide: appTheme.lineColor,
        maxLines: 4,
        borderRadius: 8,
        suffixIcon: widget.suffixIcon,
        inputFormatters: [LengthLimitingTextInputFormatter(2023)],
      ),
    );
  }
}

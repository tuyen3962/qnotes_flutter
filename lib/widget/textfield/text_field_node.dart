import 'package:flutter/material.dart';
import 'package:base_flutter_source/extension.dart';

class TextFieldNode {
  final textCtrl = TextEditingController();
  final node = FocusNode();
  final errorValidate = ValueNotifier(false);
  final emptyError = ValueNotifier(false);
  final String? errorText;
  final String initializeText;

  bool get isError => errorValidate.value;

  bool get isEmptyError => emptyError.value;

  String get text => textCtrl.text;

  set isError(bool value) {
    errorValidate.value = value;
  }

  set text(String value) {
    textCtrl.text = value;
  }

  TextFieldNode({
    bool Function(String value)? fieldValidate,
    this.errorText,
    VoidCallback? onListernText,
    this.initializeText = '',
    bool isRequired = false,
    VoidCallback? onUnfocusListener,
  }) {
    textCtrl.text = initializeText;
    node.unfocusListener(() {
      if (fieldValidate != null) {
        errorValidate.value = fieldValidate(textCtrl.text);
      }
      if (onUnfocusListener != null) {
        onUnfocusListener();
      }
      if (isRequired) {
        emptyError.value = textCtrl.text.isEmpty;
      }
    });
    if (onListernText != null || isRequired) {
      textCtrl.addListener(() {
        if (onListernText != null) {
          onListernText();
        }
      });
    }
  }

  void dispose() {
    emptyError.dispose();
    textCtrl.dispose();
    node.dispose();
    errorValidate.dispose();
  }
}

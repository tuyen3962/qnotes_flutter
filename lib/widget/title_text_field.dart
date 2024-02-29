import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:base_flutter_source/config/constant/emoji_unicode.dart';
import 'package:base_flutter_source/extension.dart';
import 'package:base_flutter_source/main.dart';
import 'package:base_flutter_source/widget/textfield/text_field_node.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    Key? key,
    this.fieldNode,
    this.title,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.textFieldPadding,
    this.topPadding,
    this.paddingTextBottom,
    this.isRequired = false,
    this.hintText = '',
    this.titleStyle,
    this.inputType = TextInputType.text,
    this.canEdit = true,
    this.content = '',
    this.includeDenyEmojy = true,
    this.onEditingComplete,
    this.isErrorInForm = false,
    this.errorFormText = '',
    this.minLine,
    this.maxLine,
    this.prefix,
    this.inputFormatters = const [],
    this.onTap,
    this.node,
  }) : super(key: key);

  final String? title;
  final TextEditingController? controller;
  final TextFieldNode? fieldNode;
  final bool obscureText;
  final Widget? suffixIcon;
  final EdgeInsets? textFieldPadding;
  final double? topPadding;
  final double? paddingTextBottom;
  final bool isRequired;
  final TextInputType inputType;
  final String hintText;
  final TextStyle? titleStyle;
  final bool canEdit;
  final bool isErrorInForm;
  final String errorFormText;
  final String content;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter> inputFormatters;
  final bool includeDenyEmojy;
  final FocusNode? node;
  final Widget? prefix;
  final int? maxLine;
  final int? minLine;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topPadding?.h ?? 30.h),
        if ((title ?? '').isNotEmpty) ...[
          Text(title ?? '',
              style: titleStyle ??
                  TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16.fontSize)),
          SizedBox(height: paddingTextBottom?.h ?? 5.h)
        ],
        _buildValueListenerView(
          (isEmpty, isValid) => Container(
            padding: textFieldPadding ?? padding(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: isValid || isEmpty || isErrorInForm
                      ? appTheme.errorColor
                      : appTheme.borderColor),
            ),
            child: GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: obscureText,
                        controller: fieldNode?.textCtrl ?? controller,
                        keyboardType: inputType,
                        onEditingComplete: onEditingComplete,
                        inputFormatters: [
                          ...inputFormatters,
                          if (inputType == TextInputType.phone ||
                              inputType == TextInputType.number) ...[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          if (includeDenyEmojy) ...formatterEmojiDeny,
                        ],
                        focusNode: fieldNode?.node ?? node,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.fontSize),
                        maxLines: maxLine,
                        minLines: minLine,
                        enabled: canEdit,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefix: prefix,
                          hintText: hintText,
                          hintStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.fontSize)
                              .copyWith(color: appTheme.hintColor),
                        ),
                      ),
                    ),
                    suffixIcon ?? SizedBox(),
                  ],
                )),
          ),
        ),
        _buildValueListenerView(
          (isEmpty, isValid) => isValid || isEmpty || isErrorInForm
              ? Padding(
                  padding: padding(top: 12),
                  child: Text(
                    isErrorInForm
                        ? errorFormText
                        : isEmpty
                            ? "Rỗng"
                            : fieldNode?.errorText ?? 'Dữ liệu không hợp lệ',
                    style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12.fontSize)
                        .copyWith(color: appTheme.errorColor),
                  ),
                )
              : SizedBox(),
        )
      ],
    );
  }

  Widget _buildValueListenerView(
      Widget Function(bool isEmpty, bool isValid) viewBuilder) {
    if (fieldNode != null) {
      return ValueListenableBuilder<bool>(
        valueListenable: fieldNode!.emptyError,
        builder: (context, isEmpty, child) => ValueListenableBuilder<bool>(
          valueListenable: fieldNode!.errorValidate,
          builder: (context, value, child) => viewBuilder(isEmpty, value),
        ),
      );
    }

    return viewBuilder(false, false);
  }
}

// class _CustomTextField extends StatefulWidget {
//   const _CustomTextField({Key? key}) : super(key: key);

//   @override
//   State<_CustomTextField> createState() => __CustomTextFieldState();
// }

// class __CustomTextFieldState extends State<_CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

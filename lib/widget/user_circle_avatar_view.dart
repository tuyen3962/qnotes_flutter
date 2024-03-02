import 'package:flutter/material.dart';
import 'package:qnotes_flutter/config/model/account.dart';
import 'package:qnotes_flutter/extension.dart';
import 'package:qnotes_flutter/main.dart';
import 'package:qnotes_flutter/widget/circle_avatar_custom.dart';

class UserCircleAvatar extends StatelessWidget {
  const UserCircleAvatar({this.account, this.size, super.key});

  final Account? account;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 24.w,
      height: size ?? 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: appTheme.whiteText),
      ),
      child: CircleAvatarCustom(
          imageUrl: account?.avatarUrl ?? '', size: size ?? 24.w),
    );
  }
}

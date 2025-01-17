/*
 * Created by haozhicao@tencent.com on 6/20/22.
 * td_input_dialog.dart
 * 
 */

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/src/components/dialog/td_dialog_widget.dart';
import 'package:tdesign_flutter/src/util/auto_size.dart';

import '../../../td_export.dart';

/// 弹窗控件
class TDInputDialog extends StatelessWidget {
  const TDInputDialog({
    Key? key,
    required this.textEditingController,
    this.backgroundColor = Colors.white,
    this.radius = 8.0,
    this.title = "输入框标题",
    this.titleColor = Colors.black,
    this.content,
    this.contentColor,
    this.leftBtn,
    this.rightBtn,
  })  : assert((title != null || content != null)),
        super(key: key);

  /// 背景颜色
  final Color backgroundColor;

  /// 圆角
  final double radius;

  /// 标题
  final String? title;

  /// 标题颜色
  final Color titleColor;

  /// 内容
  final String? content;

  /// 内容颜色
  final Color? contentColor;

  /// 输入controller
  final TextEditingController textEditingController;

  final TDDialogButton? leftBtn;
  final TDDialogButton? rightBtn;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
          width: 320.scale,
          decoration: BoxDecoration(
            color: backgroundColor, // 底色
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TDInfoWidget(
              title: title,
              titleColor: titleColor,
              content: content,
              contentColor: contentColor,
            ),
            Container(
              color: Colors.white,
              height: 80,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide.none),
                  hintText: '请输入',
                  fillColor: Color(0xfff0f0f0),
                  filled: true,
                  // labelText: '左上角',
                ),
              ),
            ),
            const TDDivider(
              height: 1,
            ),
            _horizontalButtons(context),
          ])),
    );
  }

  Widget _horizontalButtons(BuildContext context) {
    TDDialogButton left = leftBtn ?? TDDialogButton(title: "取消", action: () {});
    TDDialogButton right =
        rightBtn ?? TDDialogButton(title: "好的", action: () {});
    return HorizontalButtons(
      leftBtn: left,
      rightBtn: right,
    );
  }
}

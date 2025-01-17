/*
 * Created by haozhicao@tencent.com on 6/20/22.
 * td_dialog_widget.dart
 * 
 */

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/src/util/auto_size.dart';
import '../../../td_export.dart';

/// 弹窗标题
class TDDialogTitle extends StatelessWidget {
  const TDDialogTitle({
    Key? key,
    this.title = "对话框标题",
    this.titleColor = Colors.black,
  }) : super(key: key);

  /// 标题颜色
  final Color titleColor;

  /// 标题文字
  final String title;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return TDText(
      title,
      textColor: titleColor,
      fontWeight: FontWeight.w600,
      font: Font(size: 16, lineHeight: 24),
      textAlign: TextAlign.center,
    );
  }
}

/// 弹窗内容
class TDDialogContent extends StatelessWidget {
  const TDDialogContent({
    Key? key,
    this.content = "当前弹窗内容",
    this.contentColor = const Color(0x66000000),
  }) : super(key: key);

  /// 标题颜色
  final Color contentColor;

  /// 标题文字
  final String content;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return TDText(
      content,
      textColor: contentColor,
      font: Font(size: 16, lineHeight: 24),
      textAlign: TextAlign.center,
    );
  }
}

/// 弹窗信息
class TDInfoWidget extends StatelessWidget {
  const TDInfoWidget({
    Key? key,
    this.title,
    this.titleColor = Colors.black,
    this.content,
    this.contentColor,
    this.contentMaxHeight = 0,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 标题颜色
  final Color titleColor;

  /// 内容
  final String? content;

  /// 内容颜色
  final Color? contentColor;

  /// 内容的最大高度，默认为0，也就是不限制高度
  final double contentMaxHeight;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    assert((title != null || content != null));
    return Container(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null
                ? TDText(
                    title,
                    textColor: titleColor,
                    fontWeight: FontWeight.w600,
                    font: Font(size: 16, lineHeight: 24),
                    textAlign: TextAlign.center,
                  )
                : Container(),
            content == null
                ? Container()
                : Container(
                    padding: EdgeInsets.fromLTRB(
                        0, (title != null && content != null) ? 8.0 : 0, 0, 0),
                    constraints: contentMaxHeight > 0
                        ? BoxConstraints(
                            maxHeight: contentMaxHeight,
                          )
                        : null,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: TDDialogContent(
                          content: content!,
                        ),
                      ),
                    ),
                  ),
          ],
        ));
  }
}

/// 水平按钮
class HorizontalButtons extends StatelessWidget {
  const HorizontalButtons({
    Key? key,
    required this.leftBtn,
    required this.rightBtn,
  }) : super(key: key);

  /// 标题颜色
  final TDDialogButton leftBtn;

  /// 标题文字
  final TDDialogButton rightBtn;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return Row(
      children: [
        Expanded(
          child: TDDialogTextButton(
            buttonText: leftBtn.title,
            buttonTextColor: leftBtn.titleColor ?? const Color(0xe6000000),
            onPressed: () {
              Navigator.pop(context);
              leftBtn.action();
            },
          ),
        ),
        const TDDivider(
          height: 57,
          width: 1,
          direction: Axis.vertical,
        ),
        Expanded(
          child: TDDialogTextButton(
            buttonText: rightBtn.title,
            buttonTextColor:
                rightBtn.titleColor ?? TDTheme.of(context).brandColor8,
            onPressed: () {
              Navigator.pop(context);
              rightBtn.action();
            },
          ),
        ),
      ],
    );
  }
}

/// 弹窗标题
class TDDialogTextButton extends StatelessWidget {
  const TDDialogTextButton({
    Key? key,
    this.buttonText = "按钮",
    this.buttonTextColor,
    required this.onPressed,
    this.height = 56.0,
    this.width,
  }) : super(key: key);

  /// 按钮文字
  final String? buttonText;

  /// 按钮文字颜色
  final Color? buttonTextColor;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 点击
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: buttonTextColor ?? TDTheme.of(context).brandColor8,
        padding: const EdgeInsets.all(0),
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: TDText(
            buttonText,
            textColor: buttonTextColor ?? TDTheme.of(context).brandColor8,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rapidoclone/theme/app_colors.dart';
import 'package:rapidoclone/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 56.0,
    this.borderRadius = 12.0,
    this.padding,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isOutlined ? Colors.transparent : (backgroundColor ?? AppColors.primary),
      foregroundColor: textColor ?? (isOutlined ? AppColors.primary : Colors.white),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: isOutlined
            ? const BorderSide(color: AppColors.primary, width: 1.5)
            : BorderSide.none,
      ),
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16.0),
      minimumSize: Size(width ?? double.infinity, height),
      textStyle: AppTextStyles.buttonMedium.copyWith(
        color: textColor ?? (isOutlined ? AppColors.primary : Colors.white),
        fontWeight: FontWeight.w600,
      ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: child,
    );
  }

  factory CustomButton.outlined({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    Color? textColor,
    double? width,
    double? height,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return CustomButton(
      key: key,
      onPressed: onPressed,
      child: child,
      textColor: textColor ?? AppColors.primary,
      backgroundColor: Colors.transparent,
      width: width,
      height: height ?? 48.0,
      borderRadius: borderRadius ?? 8.0,
      padding: padding,
      isOutlined: true,
    );
  }
}

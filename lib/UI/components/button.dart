import 'package:dashlingo/UI/components/progress_indicator.dart';
import 'package:dashlingo/UI/theme/colors.dart';
import 'package:dashlingo/UI/theme/spaces.dart';
import 'package:dashlingo/UI/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'bounce_animation.dart';

enum ButtonType { primary, secondary, outline }

enum ButtonState { initial, loading, disabled }

class DashButton extends StatelessWidget {
  final ButtonType type;
  final ButtonState state;
  final String? title;
  final void Function()? onPressed;
  final double? height;
  final Color? background;
  final Color? textColor;
  final Widget? icon;

  const DashButton({
    Key? key,
    this.type = ButtonType.primary,
    this.state = ButtonState.initial,
    this.title,
    this.onPressed,
    this.height,
    this.icon,
    this.background,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disable = [ButtonState.disabled, ButtonState.loading].contains(state);
    final isLoading = [ButtonState.loading].contains(state);

    return BounceAnimation(
      onTap: disable ? null : onPressed,
      child: Builder(
        builder: (context) {
          if (type == ButtonType.secondary) {
            return _secondaryButton(disable, isLoading, context);
          } else if (type == ButtonType.outline) {
            return _outlineButton(disable, isLoading, context);
          }
          return _primaryButton(disable, isLoading, context);
        },
      ),
    );
  }

  Widget _secondaryButton(bool disable, bool isLoading, BuildContext context) {
    final isLight = AppTheme.instance.isLightMode(context);

    return Container(
      height: height ?? 35,
      constraints: const BoxConstraints(minWidth: 100),
      padding: const EdgeInsets.symmetric(horizontal: AppSpaces.cardPadding * 0.8),
      decoration: BoxDecoration(
        color: background ?? (disable ? AppColors.lightBlue : AppColors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: isLoading
            ? Wrap(
                runAlignment: WrapAlignment.center,
                children: const [
                  EdCircularProgressIndicator(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonTitle(
                      context,
                      Theme.of(context).textTheme.button?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: disable
                              ? (isLight ? Theme.of(context).canvasColor : AppColors.grey)
                              : textColor ?? (AppColors.white))),
                  if (icon != null) ...[const SizedBox(width: AppSpaces.elementSpacing * 0.5), icon!],
                ],
              ),
      ),
    );
  }

  Widget _outlineButton(bool disable, bool isLoading, BuildContext context) {
    final isLight = AppTheme.instance.isLightMode(context);

    return Container(
      height: height ?? 45,
      padding: const EdgeInsets.symmetric(horizontal: AppSpaces.cardPadding),
      constraints: const BoxConstraints(minWidth: 130),
      decoration: BoxDecoration(
        color: background ?? Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: isLoading
            ? const EdCircularProgressIndicator(color: AppColors.black)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonTitle(
                    context,
                    Theme.of(context).textTheme.button?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: disable
                            ? (isLight ? Theme.of(context).canvasColor : AppColors.grey)
                            : textColor ?? (isLight ? AppColors.black : AppColors.white)),
                  ),
                  if (icon != null) ...[const SizedBox(width: AppSpaces.elementSpacing * 0.5), icon!],
                ],
              ),
      ),
    );
  }

  Widget _primaryButton(bool disable, bool isLoading, BuildContext context) {
    return Container(
      height: height ?? 45,
      constraints: const BoxConstraints(minWidth: 130),
      padding: const EdgeInsets.symmetric(horizontal: AppSpaces.elementSpacing * 0.5),
      decoration: BoxDecoration(
        color: disable ? (Theme.of(context).canvasColor) : (background ?? AppColors.primaryColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            color: ((disable ? AppColors.accentColor : background ?? AppColors.primaryColorDark)).darken(),
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Center(
        child: isLoading
            ? const EdCircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: AppSpaces.elementSpacing * 0.25),
                  ],
                  buttonTitle(context,
                      Theme.of(context).textTheme.button?.copyWith(fontWeight: FontWeight.w600, color: textColor)),
                ],
              ),
      ),
    );
  }

  Text buttonTitle(BuildContext context, [TextStyle? style]) {
    final String text = (() {
      if (kIsWeb && title != null) {
        return title!.toUpperCase();
      }
      return '$title';
    })();
    return Text(text, style: style);
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

import 'dart:async';

import 'package:dashlingo/src/widgets/texts.dart';
import 'package:dashlingo/src/theme/colors.dart';
import 'package:dashlingo/src/theme/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextfieldState { initial, typing, filled, disabled, loading, error }

class EdTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final TextfieldState textfieldState;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final List<String>? autofillHints;
  final bool? autofocus;
  final Function(String)? onFieldSubmitted;
  final Function(String?, {Function(String?)? callback})? validator;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final bool? obscureText;
  final Color? backgroundColor;
  final int? maxLines;
  final bool isPassword;
  final TextCapitalization textCapitalization;
  final Widget? prefix;
  final Future<bool>? future;
  final bool? userErrorText;
  final EdgeInsets? padding;
  final bool showClear;
  final TextInputAction? textInputAction;

  final int? minLines;

  const EdTextfield({
    Key? key,
    this.controller,
    this.textfieldState = TextfieldState.initial,
    this.labelText,
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.enabled,
    this.inputFormatters,
    this.focusNode,
    this.onChanged,
    this.autofillHints,
    this.autofocus,
    this.onFieldSubmitted,
    this.validator,
    this.suffixIcon,
    this.autovalidateMode,
    this.obscureText,
    this.backgroundColor,
    this.maxLines,
    this.isPassword = false,
    this.textCapitalization = TextCapitalization.none,
    this.prefix,
    this.future,
    this.userErrorText,
    this.padding,
    this.textInputAction,
    this.showClear = true,
    this.minLines,
  }) : super(key: key);

  @override
  State<EdTextfield> createState() => _SnappbumTextfieldState();
}

class _SnappbumTextfieldState extends State<EdTextfield> {
  Function(String?, {Function(String?)? callback})? validate;

  Timer? _timer;

  TextfieldState textFieldState = TextfieldState.initial;
  String _text = '';
  String _errorText = '';

  FocusNode? _focusNode;

  bool isLoading = false;

  bool obscureText = false;

  bool verify = false;

  setObcureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    validate ??= widget.validator;

    obscureText = widget.isPassword;
    textFieldState = widget.textfieldState;

    _focusNode = widget.focusNode ?? FocusNode();
    _listenToTextfield();
    widget.controller?.addListener(_listenToTextfield);

    super.initState();
  }

  void _listenToTextfield() {
    setState(() {
      if (_text != widget.controller?.text &&
          (textFieldState != TextfieldState.disabled || textFieldState != TextfieldState.loading)) {
        textFieldState = TextfieldState.typing;
      }

      _text = widget.controller?.text ?? '';

      if (widget.controller != null &&
          widget.controller!.text.isNotEmpty &&
          (textFieldState != TextfieldState.disabled || textFieldState != TextfieldState.loading)) {
        if (widget.future == null) {
          textFieldState = TextfieldState.filled;
        }
      }

      if (textFieldState == TextfieldState.disabled &&
          (widget.textfieldState != TextfieldState.disabled || textFieldState != TextfieldState.loading)) {
        textFieldState = TextfieldState.disabled;
      }

      if (widget.textfieldState == TextfieldState.disabled) {
        textFieldState = TextfieldState.disabled;
      }
    });

    if (_text.isNotEmpty) {
      if (widget.future != null) {
        _timer?.cancel();
        _timer = null;
        _timer = Timer(const Duration(milliseconds: 800), () async {
          validate = widget.validator;

          setState(() {
            isLoading = true;
          });

          await Future.delayed(const Duration(milliseconds: 500));
          if (widget.validator!(_text) == null) {
            verify = await Future.value(widget.future);
          } else {
            verify = false;
          }

          if (mounted) {
            setState(() {
              isLoading = false;

              if (verify) {
                textFieldState = TextfieldState.filled;
                validate = widget.validator;
              } else {
                textFieldState = TextfieldState.error;
                if (widget.userErrorText == true) {
                  validate = ((p0, {callback}) => widget.errorText);
                } else {
                  validate = widget.validator;
                }
              }
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_listenToTextfield);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: (isFocused) {
        if (textFieldState != TextfieldState.loading) {
          setState(() {
            if (!isFocused) {
              if (_errorText.isNotEmpty) {
                textFieldState = TextfieldState.error;
              }
            }

            if (!isFocused && _text.isEmpty) {
              textFieldState = TextfieldState.initial;
            }

            if (!isFocused && _text.isNotEmpty) {
              if (widget.future == null) {
                textFieldState = TextfieldState.filled;
              }
            }
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null) ...[
            DashTexts.callout(widget.labelText!, context),
          ],
          const SizedBox(height: AppSpaces.elementSpacing * 0.5),
          SizedBox(
            height: 55,
            child: TextFormField(
              autofillHints: widget.autofillHints,
              autofocus: widget.autofocus ?? false,
              onFieldSubmitted: widget.onFieldSubmitted,
              autovalidateMode: widget.autovalidateMode,
              textCapitalization: widget.textCapitalization,
              validator: (v) {
                if (validate == null) {
                  return widget.validator == null
                      ? null
                      : (widget.validator!(v, callback: (value) {
                          if (value == null) {
                            if (widget.future == null) {
                              textFieldState = TextfieldState.filled;
                            }
                          } else {
                            textFieldState = TextfieldState.error;
                          }
                          _errorText = value ?? '';
                        }));
                } else {
                  return validate!(v);
                }
              },
              enabled: widget.enabled,
              obscureText: obscureText,
              onChanged: (v) {
                if (widget.onChanged != null) {
                  widget.onChanged!(v);
                }
                setState(() => _text = v);
              },
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              maxLines: widget.isPassword ? 1 : widget.maxLines,
              minLines: widget.minLines,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: widget.prefix,
                suffixIcon: widget.showClear
                    ? Builder(builder: (context) {
                        final isError =
                            textFieldState == TextfieldState.error && (validate != null && validate!(_text) != null);
                        final isTyping =
                            _focusNode?.hasFocus == true && _text.isNotEmpty && !verify && !widget.isPassword;

                        if (isLoading) {
                          return Transform.scale(
                            scale: 0.3,
                            child: const CircularProgressIndicator(),
                          );
                        } else if (!verify && isError && widget.showClear) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.cancel,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                          );
                        } else if (isTyping && widget.showClear) {
                          return InkWell(
                            onTap: () => widget.controller?.clear(),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.cancel,
                                size: 16,
                                color: AppColors.grey,
                              ),
                            ),
                          );
                        } else if (!isError && verify) {
                          return widget.suffixIcon ?? const SizedBox.shrink();
                        } else if (widget.isPassword) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpaces.elementSpacing),
                              child: Icon(
                                !obscureText ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                            ),
                            onTap: () {
                              setObcureText();
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      })
                    : null,
                contentPadding: widget.padding,
                hintText: widget.hintText,
                labelText: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

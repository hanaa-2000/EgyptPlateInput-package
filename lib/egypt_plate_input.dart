import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EgyptPlateInput extends StatefulWidget {
  const EgyptPlateInput({
    super.key,
    required this.field1Controller,
    required this.field2Controller,
    required this.field3Controller,
    required this.numberController,
    this.background,
    this.style,
    this.hintStyle,
    this.onPlateChanged,
     this.hintText1, this.hintText2, this.hintText3, this.hintTextNumber,
  });

  final TextEditingController field1Controller;
  final TextEditingController field2Controller;
  final TextEditingController field3Controller;
  final TextEditingController numberController;
  final Color? background;
  final double width = 60;
  final double height = 60;
  final TextStyle? style;
  final String? hintText1;
    final String? hintText2;
      final String? hintText3;
        final String? hintTextNumber;
  final TextStyle? hintStyle;
  final void Function(String)? onPlateChanged;

  @override
  State<EgyptPlateInput> createState() => _CarNumberWidgetState();
}

enum LocationOption { cairo, other }

class _CarNumberWidgetState extends State<EgyptPlateInput> {
  // controllers لكل حقل
  // LocationOption? _selectedLocation = LocationOption.other;

  // FocusNodes للتحكم في التركيز
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _numbersFocus = FocusNode();
  final FocusNode _keyboardListenerFocus = FocusNode();
  // InputFormatter لقبول فقط حروف عربية
  final FilteringTextInputFormatter arabicOnlyFormatter =
      FilteringTextInputFormatter.allow(
        RegExp(
          r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]',
        ), // مجموعة الحروف العربية
      );

  // وظيفة للتحرك للحقل التالي بعد إدخال حرف واحد
  void _onChanged(
    TextEditingController controller,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    if (controller.text.length >= 1) {
      currentFocus.unfocus();

      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  String? _field1Error;
  String? _field2Error;
  String? _numberError;

  // void validatePlate() {
  //   setState(() {
  //     _field1Error = widget.field1Controller.text.trim().isEmpty
  //         ? "الحقل مطلوب"
  //         : null;

  //     _field2Error = widget.field2Controller.text.trim().isEmpty
  //         ? "الحقل مطلوب"
  //         : null;

  //     String numberText = widget.numberController.text.trim();
  //     _numberError = numberText.length < 3
  //         ? "يجب إدخال 3 أرقام على الأقل"
  //         : null;
  //   });
  // }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _numbersFocus.dispose();
    _keyboardListenerFocus.dispose();
    super.dispose();
  }

  void _notifyPlateChanged() {
    final plate =
        "${widget.field1Controller.text}${widget.field2Controller.text}${widget.field3Controller.text}-${widget.numberController.text}";
    widget.onPlateChanged?.call(plate);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 16),
            Row(
              children: [
                buildTextFileCharacter(
                  onKeyEvent: (event) {
                    if (event.logicalKey == LogicalKeyboardKey.backspace &&
                        widget.field1Controller.text.isEmpty &&
                        _focusNode1.hasFocus) {
                      // هنا ممكن ترجع للفيلد السابق لو محتاج
                    }
                  },
                  errorText: _field1Error,
                  controller: widget.field1Controller,
                  focusNode: _focusNode1,
                  hintText: widget.hintText1 ?? "ق",
                  onChanged: (_) {
                    _onChanged(
                      widget.field1Controller,
                      _focusNode1,
                      _focusNode2,
                    );
                    _notifyPlateChanged();
                  },
                  background: widget.background,
                  style: widget.style,
                  hintStyle: widget.hintStyle,
                  height: widget.height,
                  width: widget.width,
                ),
                SizedBox(width: 16),
                buildTextFileCharacter(
                  onKeyEvent: (value) {
                    if (value.logicalKey == LogicalKeyboardKey.backspace &&
                        widget.field2Controller.text.isEmpty &&
                        _focusNode2.hasFocus) {
                      _focusNode1.requestFocus();
                    }
                  },
                  
                  errorText: _field2Error,
                  controller: widget.field2Controller,
                  focusNode: _focusNode2,
                  hintText: widget.hintText2 ?? "س",
                  onChanged: (_) {
                    _onChanged(
                      widget.field2Controller,
                      _focusNode2,
                      _focusNode3,
                    );
                    _notifyPlateChanged();
                  },
                  background: widget.background,
                  style: widget.style,
                  hintStyle: widget.hintStyle,
                  height: widget.height,
                  width: widget.width,
                ),
                SizedBox(width: 16),
                buildTextFileCharacter(
                  onKeyEvent: (value) {
                    if (value.logicalKey == LogicalKeyboardKey.backspace &&
                        widget.field3Controller.text.isEmpty &&
                        _focusNode3.hasFocus) {
                      _focusNode2.requestFocus();
                    }
                  },

                  controller: widget.field3Controller,
                  focusNode: _focusNode3,
                  hintText: widget.hintText3 ?? "ع",
                  onChanged: (_) {
                    _onChanged(
                      widget.field3Controller,
                      _focusNode3,

                      _numbersFocus,
                    );
                    _notifyPlateChanged();
                  },

                  background: widget.background,
                  style: widget.style,
                  hintStyle: widget.hintStyle,
                  height: widget.height,
                  width: widget.width,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (value) {
                      if (value.logicalKey == LogicalKeyboardKey.backspace &&
                          widget.numberController.text.isEmpty &&
                          _numbersFocus.hasFocus) {
                        _focusNode3.requestFocus();
                      }
                    },
                    child: TextField(
                      focusNode: _numbersFocus,
                      controller: widget.numberController,
                      style:
                          widget.style ??
                          TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                      onChanged: (_) {
                        _onChanged(
                          widget.numberController,
                          _numbersFocus,
                          _numbersFocus,
                        );
                        _notifyPlateChanged();
                      },
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: _numberError,
                        hintText: widget.hintTextNumber ?? "1234",
                        hintStyle:
                            widget.hintStyle ??
                            TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                        counterText: '',
                        filled: true,
                        fillColor: (widget.background ?? Colors.white)
                            .withAlpha((0.8 * 255).round()),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 18,
                        ),
                        enabledBorder: _outline(widget.background),
                        focusedBorder: _outline(
                          widget.background,
                          isFocused: true,
                        ),
                        errorBorder: _outline(widget.background),
                        focusedErrorBorder: _outline(
                          widget.background,
                          isFocused: true,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),

                      cursorColor: Colors.blue,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFileCharacter({
    required void Function(KeyEvent)? onKeyEvent,
    FocusNode? focusNode,
    TextEditingController? controller,
    String? hintText,
    void Function(String)? onChanged,
    double width = 60,
    double height = 60,
    Color? background,
    TextStyle? style,
    TextStyle? hintStyle,
    Color? cursorColor,
    String? errorText,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: KeyboardListener(
        focusNode: FocusNode(), // خاص بـ RawKeyboardListener
        onKeyEvent: onKeyEvent,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          style:
              style ??
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
          maxLength: 1,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[\u0621-\u064A]+$')),
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            hintStyle:
                hintStyle ??
                TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
            counterText: '',
            filled: true,
            fillColor: (widget.background ?? Colors.white).withAlpha(
              (0.8 * 255).round(),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
            enabledBorder: _outline(widget.background),
            focusedBorder: _outline(widget.background, isFocused: true),
            errorBorder: _outline(widget.background),
            focusedErrorBorder: _outline(widget.background, isFocused: true),
            errorStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          onChanged: onChanged,

          cursorColor: cursorColor ?? Colors.blue,
        ),
      ),
    );
  }

  OutlineInputBorder _outline(Color? color, {bool isFocused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color ?? Colors.white,
        width: isFocused ? 0.5 : 0.2,
      ),
    );
  }
}

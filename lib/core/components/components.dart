import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/colors/colors.dart';
import '../constants/images/images.dart';
import '../texts/words.dart';
import '../utils/dimensions.dart';

class AppText extends StatelessWidget {
  AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines
  });

  AppText.subtitleBold(
    this.text, {
    super.key,
    this.fontColor,
    this.textAlign,
    this.maxLines,
  }) {
    fontWeight = FontWeight.bold;
    fontSize = Get.height * 0.025;
  }

  AppText.smallBold(
    this.text, {
    super.key,
    this.fontColor,
    this.textAlign,
    this.maxLines,
  }) {
    fontWeight = FontWeight.bold;
    fontSize = Get.height * 0.015;
  }

  AppText.subtitle(
    this.text, {
    super.key,
    this.fontColor,
    this.textAlign,
    this.maxLines,
  }) {
    fontSize = Get.height * 0.025;
  }

  AppText.small(this.text,
      {super.key, this.fontColor, this.textAlign, this.maxLines}) {
    fontSize = Get.height * 0.015;
  }

  TextStyle? style;
  double? fontSize;
  Color? fontColor;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  int? maxLines;
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: style ??
          TextStyle(
              fontSize: fontSize,
              color: fontColor ?? AppColors.black,
              fontWeight: fontWeight),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.buttonName,
    this.buttonColor,
    this.onTap,
    this.buttonLogo,
  });

  final Color? buttonColor;
  final String buttonName;
  final void Function()? onTap;
  final Widget? buttonLogo;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: ScreenDimensions.widthPercentage(context, 80),
          height: ScreenDimensions.heightPercentage(context, 6),
          decoration: BoxDecoration(
              color: buttonColor ?? AppColors.darkBlue,
              borderRadius:
                  BorderRadius.circular(ScreenDimensions.radius(context, 1))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonLogo??SvgPicture.asset(
                AppImages.rightArrow,
                width: ScreenDimensions.widthPercentage(context, 4),
                height: ScreenDimensions.heightPercentage(context, 3),
              ),
              AppText.subtitleBold(
                buttonName,
                fontColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
      this.prefix,
      this.suffix,
      this.controller,
      this.onSuffixTap,
      this.keyboardType,
      this.readOnly,
      this.maxLines,
      this.obscureText,
      this.prefixColor,
      required this.prefixImage,
      this.suffixImage,
      this.onChanged,
      this.validator,
      required this.labelText,
      this.suffixColor});

  final TextInputType? keyboardType;
  final bool? readOnly;
  final int? maxLines;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String labelText;
  final String prefixImage;
  final Color? prefixColor;
  final String? suffixImage;
  final Color? suffixColor;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? controller;
  final void Function()? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        cursorColor: AppColors.darkBlue,
        obscureText: obscureText ?? false,
        onChanged: onChanged ?? (value) {},
        validator: validator ??
            (value) {
              return null;
            },
        decoration: InputDecoration(
            suffixIcon: suffixImage == null
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: onSuffixTap,
                    child: Container(
                      width: ScreenDimensions.widthPercentage(context, 1),
                      height: ScreenDimensions.heightPercentage(context, 2),
                      alignment: Alignment.center,
                      child: suffixImage == null
                          ? const SizedBox.shrink()
                          : SvgPicture.asset(
                              suffixImage ?? '',
                              fit: BoxFit.cover,
                              color: suffixColor,
                              height:
                                  ScreenDimensions.heightPercentage(context, 3),
                              width:
                                  ScreenDimensions.widthPercentage(context, 4),
                            ),
                    ),
                  ),
            suffix: suffix,
            prefix: prefix,
            border: const OutlineInputBorder(),
            labelText: labelText,
            prefixIcon: Container(
              width: ScreenDimensions.widthPercentage(context, 1),
              height: ScreenDimensions.heightPercentage(context, 2),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                prefixImage,
                color: prefixColor ?? AppColors.darkBlue,
                fit: BoxFit.cover,
                height: ScreenDimensions.heightPercentage(context, 3),
                width: ScreenDimensions.widthPercentage(context, 4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkBlue),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.darkBlue)),
            floatingLabelAlignment: FloatingLabelAlignment.start),
      ),
    );
  }
}

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.content,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 10,
          sigmaX: 10,
        ),
        child: Container(
          width: ScreenDimensions.widthPercentage(context, 80),
          height: ScreenDimensions.heightPercentage(context, 50),
          margin: EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 30),horizontal: ScreenDimensions.widthPercentage(context, 5)),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1))
          ),
          child: Column(
            children: [
              AppText.subtitleBold(AppWord.comingSoon),
              Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                child: SvgPicture.asset(AppImages.comingSoon,width: ScreenDimensions.widthPercentage(context, 13),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                child: SvgPicture.asset(AppImages.timer,width: ScreenDimensions.widthPercentage(context, 18)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                child: SizedBox(
                  width: ScreenDimensions.widthPercentage(context, 60),
                  child: AppText.smallBold(content,maxLines: 3,textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackArrow extends StatelessWidget {
  const BackArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Get.back();},
      child: SizedBox(
        width: ScreenDimensions.widthPercentage(context, 10),
        height: ScreenDimensions.heightPercentage(context, 5),
        child: Icon(Icons.arrow_forward,color: AppColors.darkBlue,size: ScreenDimensions.heightPercentage(context, 2.5)),
      ),
    );
  }
}


class GeneralDialog extends StatelessWidget {
  const GeneralDialog({
    super.key,
    required this.children
  });
 final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 10,
          sigmaX: 10,
        ),
        child: Container(
          width: ScreenDimensions.widthPercentage(context, 80),
          height: ScreenDimensions.heightPercentage(context, 50),
          margin: EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 30),horizontal: ScreenDimensions.widthPercentage(context, 5)),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1))
          ),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
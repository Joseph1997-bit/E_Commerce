import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextUtils extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration underLine;
  const TextUtils({
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.underLine = TextDecoration.none,//TextDecoration degeri none yani yok defulat olark yaptik deger atmasak bile hata vermez ve istedgimiz yerde kullanip farkli deger atabiliriz optional/secmeli oldu
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            decoration: underLine,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ));
  }
}

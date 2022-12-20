import 'package:flutter/material.dart';

//foto ustunde gorunen renkleri arasinda degistirme oluca her daire ayni renk olsun diye bu class olusturduk
class ColorPicker extends StatelessWidget {
  final bool outerBorder;
  final Color color;
  const ColorPicker({
    required this.color,
    required this.outerBorder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(//herhangi bi rengi secince arkasinda/ustunde hafif/ince bi cizgi var daire olarak yapmak icin containe kullandik ve shap ozelligi ile gereceklestirebilirz
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,//shape ozelligi sayesinde bu container her renk uzerinde daire olarak goruntulenecek ve border ozelligi ile etrafi/sinirlari secince degisir
        border: outerBorder ? Border.all(color: color, width: 2) : null,
      ),
      child: Container(//fotolar ustunde renkleri secince ince daire icinde  bi daire olarak ve ayni renk olsun diye ic ice Container yaptik
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,//renkli daire olarak gozuksun diye container kullandik ve shap ozelligi ile bu islem gerceklestirebiliyoz
        ),
      ),
    );
  }
}

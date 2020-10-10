import 'package:chalana_delivery/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InputSliderWidget extends StatelessWidget {
  final Product product;

  const InputSliderWidget(this.product);

  @override
  Widget build(BuildContext context) {

    
    if (product.price.maximumKilo == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 4),
        child: Text(
            'No momento,está disponível apenas ${product.price.maximumKilo} (kg) aproveite!',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      );
    } else {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 4),
            child: Text(
                'Mova a bolinha e escolha a quantidade em (kg) que desejar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveTrackColor: Colors.red[100],
              trackShape: const RoundedRectSliderTrackShape(),
              trackHeight: 8.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Theme.of(context).primaryColor,
              overlayColor: Theme.of(context).primaryColor,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 10.0),
              tickMarkShape: const RoundSliderTickMarkShape(),
              activeTickMarkColor: Theme.of(context).primaryColor,
              inactiveTickMarkColor: Colors.red[100],
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Theme.of(context).primaryColor,
              valueIndicatorTextStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            child: Slider(
                autofocus: true,
                value: product.priceOfKiloSelected,
                min: product.price.minimumKilo.toDouble(),
                max: product.price.maximumKilo.toDouble(),
                label: '${product.priceOfKiloSelected.toStringAsFixed(1)} kg',
                divisions:
                    product.price.maximumKilo == product.price.minimumKilo
                        ? product.price.maximumKilo
                        : product.price.maximumKilo - 1,
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.black26,
                onChanged: (double value) {
                  product.priceOfKiloSelected = value;
                }),
          )
        ],
      );
    }
  }
}

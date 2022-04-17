import 'dart:developer';

import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockInfoWidget extends StatelessWidget {
  const StockInfoWidget({Key? key, required this.stock}) : super(key: key);

  final ResponseStock? stock;

  Widget _stockTextInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Акции / ${stock!.tag}',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          stock!.name,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        InkWell(
          onTap: () => log('Tapped'),
          child: Row(
            children: [
              Image.asset(
                Constants.pathBookmark,
                scale: 1.5,
              ),
              Text(
                'Добавить в избранное',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _stockImage() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: CircleAvatar(
        radius: 75,
        backgroundImage: NetworkImage(
          stock!.imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (stock == null) {
      return customCircularProgressIndicator();
    }

    return customCard(
      child: Row(
        children: [
          _stockImage(),
          _stockTextInfo(context),
        ],
      ),
    );
  }
}

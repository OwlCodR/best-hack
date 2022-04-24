import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_responses/response_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsListItemWidget extends StatelessWidget {
  const NewsListItemWidget({
    Key? key,
    required this.responseNews,
    required this.onTapped,
  }) : super(key: key);

  final ResponseNews responseNews;
  final Function(ResponseNews) onTapped;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Removes default padding from left and right
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Политика',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            responseNews.title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                DateFormat('dd.MM.yyyy')
                    .format(DateTime.parse(responseNews.publishedAt)),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: AppConstants.colors.gray,
                    ),
              ),
              const SizedBox(width: 10),
              Text(
                '${responseNews.url.substring(0, 20)}...',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppConstants.colors.gray,
                    ),
              ),
            ],
          ),
        ],
      ),
      onTap: () => onTapped(responseNews),
    );
  }
}

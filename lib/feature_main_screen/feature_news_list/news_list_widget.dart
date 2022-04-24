import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_responses/response_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'news_item_widget.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({Key? key, required this.onItemTapped})
      : super(key: key);

  final Function(ResponseNews) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return customCard(
      child: cardContent(context),
    );
  }

  Widget cardContent(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Новости',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        FutureBuilder(
          future: ApiProvider.getNews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var listNews = (snapshot.data as ResponseListNews).listNews;
              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: listNews.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsListItemWidget(
                      onTapped: (news) => onItemTapped(news),
                      responseNews: listNews[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: AppConstants.colors.veryLightPurple,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              debugPrint('cardContent() | Error: ${snapshot.error}');
              return Expanded(
                child: Center(
                  child: Text(
                    'Failed to load data.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              );
            } else {
              return customCircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}

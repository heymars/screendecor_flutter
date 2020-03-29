import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:screen_decor/utils/TextStyles.dart';
import 'package:screen_decor/utils/custom_colors.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Home',
                  style: TextStyles.h1Black,
                ),
                Text(
                  'welcome to the ultimate weddings…',
                  style: TextStyles.body2BlackMedium,
                ),
                getTrendingWeddingsRow(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16),
                      child: Text(
                        'Wedding Photo albums',
                        style: TextStyles.body1,
                      ),
                    ),
                  ],
                ),
                getWeddingPhotoAlbumsRow(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16),
                      child: Text(
                        'Submit wedding feature',
                        style: TextStyles.body1,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                      child: Text(
                        'Get fetured on Wittyvows and win too!',
                        style: TextStyles.body2Grey,
                      ),
                    ),
                  ],
                ),
                getSubmitForParticipationRow(),
                getVoteForTheBestEntry(),
              ],
            ),
          ),
        ));
  }

  Widget getTrendingWeddingsRow() {
    return Container(
      margin: const EdgeInsets.only(top: 48),
      width: double.infinity,
      height: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: CustomColors.ice),
              ),
              top: 16,
              right: 16,
              left: 16,
              bottom: 16),
          Positioned(
            right: 0,
            left: 0,
            top: 16,
            bottom: 16,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.transparent),
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: Center(
                  child: ListView.builder(
                      itemCount: 10,
                      padding: const EdgeInsets.only(left: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return InkWell(
                            onTap: (() {}),
                            child: Container(
                              width: 110,
                              margin: const EdgeInsets.only(
                                  left: 14, right: 0, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 24.0),
                                    child: Text(
                                      'Most trending weddings',
                                      style: TextStyles.h3Green,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        size: 12,
                                        color: CustomColors.darkish_pink,
                                      ),
                                      Text(
                                        ' create',
                                        style: TextStyle(
                                          color: CustomColors.darkish_pink,
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 11,
                                          letterSpacing: 0.28,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://i.pinimg.com/originals/16/72/e8/1672e8010b56ea75dbcf5834a24ab91c.jpg',
                                width: 128,
                                height: 138,
                              ),
                            ),
                          );
                        }
                      }),
                )),
          )
        ],
      ),
    );
  }

  Widget getWeddingPhotoAlbumsRow() {
    return Container(
      height: 280,
      width: double.infinity,
      child: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.only(left: 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '#PriyaPranchal',
                    style: TextStyles.body2Grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 2, bottom: 2),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://i.pinimg.com/originals/16/72/e8/1672e8010b56ea75dbcf5834a24ab91c.jpg',
                                width: 105,
                                height: 114,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 2, bottom: 2),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://i.pinimg.com/originals/16/72/e8/1672e8010b56ea75dbcf5834a24ab91c.jpg',
                                width: 105,
                                height: 114,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 2, top: 2),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://i.pinimg.com/originals/16/72/e8/1672e8010b56ea75dbcf5834a24ab91c.jpg',
                                width: 105,
                                height: 114,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 2, top: 2),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://i.pinimg.com/originals/16/72/e8/1672e8010b56ea75dbcf5834a24ab91c.jpg',
                                width: 105,
                                height: 114,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget getSubmitForParticipationRow() {
    return Container(
      height: 180,
      width: double.infinity,
      child: ListView.builder(
          itemCount: 1836,
          padding: const EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://i.pinimg.com/originals/16/72/e8/1672e8010b56ea75dbcf5834a24ab91c.jpg',
                        width: 124,
                        height: 124,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Mother Daughter',
                      style: TextStyles.bodyText3,
                    ),
                  ),
                  Text(
                    '2 days left',
                    style: TextStyle(
                        color: Color(0xff838383),
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 10,
                        letterSpacing: 0),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget getVoteForTheBestEntry() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: double.infinity,
      height: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: CustomColors.ice),
              ),
              top: 16,
              right: 16,
              left: 16,
              bottom: 16),
          Positioned(
            right: 0,
            left: 0,
            top: 16,
            bottom: 16,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.transparent),
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: Center(
                  child: ListView.builder(
                      itemCount: 10,
                      padding: const EdgeInsets.only(left: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.only(
                                left: 14, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 24.0, right: 8),
                                  child: Text(
                                    'Vote the best entry',
                                    style: TextStyles.h3Green,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://i.pinimg.com/originals/16/72/e8/1672e8010b56ea75dbcf5834a24ab91c.jpg',
                                width: 128,
                                height: 138,
                              ),
                            ),
                          );
                        }
                      }),
                )),
          )
        ],
      ),
    );
  }
}

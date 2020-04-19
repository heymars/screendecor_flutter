import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_decor/models/photo_model.dart';
import 'package:screen_decor/ui/home/home_bloc.dart';
import 'package:screen_decor/ui/home/home_event.dart';
import 'package:screen_decor/ui/home/home_state.dart';
import 'package:screen_decor/utils/TextStyles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          builder: (context) {
            return HomeBloc();
          },
          child: HomePageWidget(),
        ));
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePageWidget> {
  HomeBloc _bloc;
  List<PhotoModel> list;
  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.dispatch(GetPhotos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeStateSuccess) {
          setState(() {
            list = state.photoModelList;
          });
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, HomeState state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    image: NetworkImage(
//                        "https://i.pinimg.com/564x/b4/71/e3/b471e3cf440c2f772569912e32aa372b.jpg"),
//                    fit: BoxFit.cover,
//                  ),
//                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'Home',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Bold',
                          fontSize: 32,
                          letterSpacing: 0),
                    ),
                    Text(
                      'welcome to the ultimate weddings…',
                      style: TextStyles.body2BlackMedium,
                    ),
                    Container(
                        child: state is HomeStateSuccess
                            ? getSubmitForParticipationRow(state.photoModelList)
                            : Container()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getSubmitForParticipationRow(List<PhotoModel> photoModels) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 8,
            childAspectRatio: 0.65,
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: new List<Widget>.generate(photoModels.length, (index) {
              return InkWell(
                onTap: (() {}),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Color(
                                  (Random().nextDouble() * 0xFFFFFF).toInt() <<
                                      0)
                              .withOpacity(0.5),
                        ),
                        imageUrl: photoModels[index].urls.regular,
                      )),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

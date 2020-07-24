import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_decor/models/photo_model.dart';
import 'package:screen_decor/ui/home/home_bloc.dart';
import 'package:screen_decor/ui/home/home_event.dart';
import 'package:screen_decor/ui/home/home_state.dart';

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
  List<PhotoModel> list = [];
  int page = 0;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  Future _loadData() {
    _bloc.dispatch(GetPhotos(page));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.dispatch(GetPhotos(page));
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          200) {
        print('------get more date-----');
        _loadData();
        setState(() {
          isLoading = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeStateSuccess) {
          setState(() {
            if (page == 1) {
              list = state.photoModelList;
            } else {
              list = List.from(list)..addAll(state.photoModelList);
            }
            page = page + 1;
          });
          print("-----list size--------${list.length}----$page-----");
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, HomeState state) {
          return SafeArea(
              child: list.isNotEmpty
                  ? GridView.builder(
                      controller: _scrollController,
                      itemCount: list.length,
                      shrinkWrap: false,
                      padding: EdgeInsets.all(8),
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.6),
                      itemBuilder: (BuildContext context, int index) {
                        return PhotoWidget(
                          key: ObjectKey(list[index]),
                          photoModel: list[index],
                        );
                      })
                  : Container());
        },
      ),
    );
  }

  Widget getSubmitForParticipationRow(List<PhotoModel> photoModels) {
    return Column(
      children: <Widget>[
//        GridView.count(
//          controller: _scrollController,
//          crossAxisCount: 2,
//          shrinkWrap: true,
//          crossAxisSpacing: 8,
//          childAspectRatio: 0.65,
//          physics: ScrollPhysics(),
//          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
//          scrollDirection: Axis.vertical,
//          children: new List<Widget>.generate(photoModels.length, (index) {
//            return InkWell(
//              onTap: (() {}),
//              child: Padding(
//                padding: const EdgeInsets.only(top: 8.0),
//                child: ClipRRect(
//                    borderRadius: BorderRadius.all(Radius.circular(6)),
//                    child: CachedNetworkImage(
//                      fit: BoxFit.cover,
//                      placeholder: (context, url) => Container(
//                        color: Color(
//                                (Random().nextDouble() * 0xFFFFFF).toInt() << 0)
//                            .withOpacity(0.5),
//                      ),
//                      imageUrl: photoModels[index].urls.regular,
//                    )),
//              ),
//            );
//          }),
//        ),

        Container(
          height: isLoading ? 50.0 : 0,
          color: Colors.transparent,
          child: Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

class PhotoWidget extends StatelessWidget {
  final PhotoModel photoModel;

  const PhotoWidget({Key key, @required this.photoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: CachedNetworkImage(
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                  .withOpacity(0.5),
            ),
            imageUrl: photoModel.urls.regular,
          )),
    );
  }
}

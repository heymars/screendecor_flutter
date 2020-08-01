import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_decor/models/photo_model.dart';
import 'package:screen_decor/ui/detail/image_detail.dart';
import 'package:screen_decor/ui/home/home_bloc.dart';
import 'package:screen_decor/ui/home/home_event.dart';
import 'package:screen_decor/ui/home/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
        ),
        body: BlocProvider(
          builder: (context) {
            return HomeBloc();
          },
          child: HomePageWidget(),
        ));
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePageWidget>
    with AutomaticKeepAliveClientMixin {
  HomeBloc _bloc;
  List<PhotoModel> list = [];
  int page = 0;
  bool isLoading = false;
  var myVariable = 0;
  ScrollController _scrollController = ScrollController();

  void _loadData() {
    _bloc.dispatch(GetPhotos(page));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    myVariable = myVariable + 1;
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
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.6),
                      itemBuilder: (BuildContext context, int index) {
                        return PhotoWidget(
                          key: ObjectKey(list[index]),
                          photoModel: list[index],
                          onItemClick: (() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ImageDetail(
                                      photoModel: list[index],
                                    )));
                          }),
                        );
                      })
                  : Container());
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PhotoWidget extends StatelessWidget {
  final PhotoModel photoModel;
  final Function onItemClick;
  const PhotoWidget({Key key, @required this.photoModel, this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemClick,
      child: Hero(
        tag: photoModel.id,
        child: Padding(
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
        ),
      ),
    );
  }
}

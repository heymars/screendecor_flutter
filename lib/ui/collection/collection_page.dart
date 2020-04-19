import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_decor/models/collection_model.dart';
import 'package:screen_decor/ui/collection/collection_bloc.dart';
import 'package:screen_decor/ui/collection/collection_event.dart';
import 'package:screen_decor/ui/collection/collection_state.dart';
import 'package:screen_decor/utils/TextStyles.dart';

class CollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (context) {
          return CollectionBloc();
        },
        child: CollectionWidget(),
      ),
    );
  }
}

class CollectionWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Collection();
}

class Collection extends State<CollectionWidget> {
  CollectionBloc _collectionBloc;
  List<CollectionModel> _list;
  @override
  void initState() {
    _collectionBloc = BlocProvider.of<CollectionBloc>(context);
    _collectionBloc.dispatch(GetCollections());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionBloc, CollectionState>(
      listener: (context, state) {
        if (state is CollectionStateSuccess) {
          setState(() {
            _list = state.collectionModelList;
          });
        }
      },
      child: BlocBuilder(
        bloc: _collectionBloc,
        builder: (BuildContext context, CollectionState state) {
          return Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Collections',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Bold',
                            fontSize: 32,
                            letterSpacing: 0),
                      ),
                      getVoteForTheBestEntry(_list)
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget getVoteForTheBestEntry(List<CollectionModel> list) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      width: double.infinity,
//      height: 300,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.transparent),
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          child: Center(
            child: list != null
                ? ListView.builder(
                    itemCount: list.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: Stack(
                            children: <Widget>[
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: list[index].coverPhoto.urls.regular,
                                height: 138,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                height: 138,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 16),
                                    child: Text(
                                      list[index].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins-Bold',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          letterSpacing: .3),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 16, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Photos:",
                                          style: TextStyles.h4White,
                                        ),
                                        Text(
                                          list[index].totalPhotos.toString(),
                                          style: TextStyles.h4White,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Container(),
          )),
    );
  }
}

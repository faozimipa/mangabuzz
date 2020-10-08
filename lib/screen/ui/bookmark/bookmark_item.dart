import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/util/route_generator.dart';
import 'package:mangabuzz/screen/ui/manga_detail/bloc/manga_detail_screen_bloc.dart';
import 'package:mangabuzz/screen/ui/manga_detail/manga_detail_screen.dart';

import '../../../core/model/bookmark/bookmark_model.dart';
import '../../widget/rating.dart';
import '../../widget/tag.dart';

class BookmarkItem extends StatefulWidget {
  final BookmarkModel bookmarkModel;
  BookmarkItem({@required this.bookmarkModel});

  @override
  _BookmarkItemState createState() => _BookmarkItemState();
}

class _BookmarkItemState extends State<BookmarkItem> {
  _navigate() {
    BlocProvider.of<MangaDetailScreenBloc>(context).add(
        GetMangaDetailScreenData(
            mangaEndpoint: widget.bookmarkModel.mangaEndpoint,
            title: widget.bookmarkModel.title));
    Navigator.pushNamed(context, mangaDetailRoute,
        arguments: MangaDetailPageArguments(
            mangaEndpoint: widget.bookmarkModel.mangaEndpoint,
            title: widget.bookmarkModel.title));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(20))),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 0))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setWidth(20))),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigate();
                      },
                      child: CachedNetworkImage(
                        imageUrl: widget.bookmarkModel.image,
                        width: ScreenUtil().setWidth(280),
                        height: ScreenUtil().setWidth(420),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                        child: TypeTag(
                          type: widget.bookmarkModel.type,
                          fontSize: 11,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.bookmarkModel.title,
                  style: TextStyle(
                      fontFamily: "Poppins-SemiBold",
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  widget.bookmarkModel.author,
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 11,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  widget.bookmarkModel.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rating(
                      rating: widget.bookmarkModel.rating,
                    ),
                    InkWell(
                        onTap: () {
                          _navigate();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    offset: Offset(0, 1),
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.6))
                              ],
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(20))),
                              color: Theme.of(context).primaryColor),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(30),
                                  vertical: ScreenUtil().setWidth(10)),
                              child: Text("Detail",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-SemiBold")),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
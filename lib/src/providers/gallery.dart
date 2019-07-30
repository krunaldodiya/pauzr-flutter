import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/gallery.dart';
import 'package:pauzr/src/resources/api.dart';

class GalleryBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  int lastPage;
  int page = 1;
  bool busy;
  bool loading;
  bool loaded;
  Map error = const {};
  List<Gallery> images = [];

  setState({
    int lastPage,
    int page,
    bool busy,
    bool loading,
    bool loaded,
    Map error,
    List<Gallery> images,
  }) {
    this.lastPage = lastPage ?? this.lastPage;
    this.page = page ?? this.page;
    this.busy = busy ?? this.busy;
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.images = images ?? this.images;

    notifyListeners();
  }

  getUserGallery({reload: false, @required int userId}) async {
    if (busy == true) return false;
    if (reload == true && page == lastPage) return false;

    if (reload == false) {
      setState(loading: true, loaded: false, page: 1, images: []);
    } else {
      setState(busy: true, page: page + 1);
    }

    try {
      final Response response = await _apiProvider.getUserGallery(page, userId);
      final results = response.data;
      final List<Gallery> imageData = Gallery.fromList(
        results['images']['data'],
      );
      final int lastPage = results['images']['last_page'];

      setState(
        images: images..addAll(imageData),
        lastPage: lastPage,
        loading: false,
        loaded: true,
        busy: false,
      );

      return results;
    } catch (error) {
      setState(
        error: error.response.data,
        loading: false,
        loaded: true,
        busy: false,
      );
    }
  }
}

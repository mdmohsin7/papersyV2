import 'package:async_redux/async_redux.dart';
import 'package:equatable/equatable.dart';
import 'package:papersy/business/core/auth/models/auth_state.dart';
import 'package:papersy/business/core/download/models/download_state.dart';
import 'package:papersy/business/core/filter/models/filter_state.dart';
import 'package:papersy/business/core/home/models/home_state.dart';
import 'package:papersy/business/core/preview/models/preview_state.dart';
import 'package:papersy/business/core/theme/models/theme_state.dart';
import 'package:papersy/business/core/upload/models/upload_state.dart';

class AppState extends Equatable {
  final AuthState authState;
  final HomeState homeState;
  final FilterState filterState;
  final UploadState uploadState;
  final DownloadState downloadState;
  final ThemeState themeState;
  final Wait wait;
  final PreviewState previewState;

  AppState(
      {this.previewState,
      this.authState,
      this.homeState,
      this.filterState,
      this.uploadState,
      this.downloadState,
      this.themeState,
      this.wait});

  AppState copy(
      {AuthState authState,
      Wait wait,
      HomeState homeState,
      FilterState filterState,
      UploadState uploadState,
      DownloadState downloadState,
      ThemeState themeState,
      PreviewState previewState}) {
    return AppState(
      authState: authState ?? this.authState,
      homeState: homeState ?? this.homeState,
      filterState: filterState ?? this.filterState,
      uploadState: uploadState ?? this.uploadState,
      downloadState: downloadState ?? this.downloadState,
      themeState: themeState ?? this.themeState,
      wait: wait ?? this.wait,
      previewState: previewState ?? this.previewState,
    );
  }

  static AppState initialState() {
    return AppState(
      authState: AuthState.initialState(),
      homeState: HomeState.initialState(),
      filterState: FilterState.initialState(),
      uploadState: UploadState.initialState(),
      downloadState: DownloadState.initialState(),
      themeState: ThemeState.initialState(),
      previewState: PreviewState.initialState(),
      wait: Wait(),
    );
  }

  @override
  List<Object> get props => [
        authState,
        homeState,
        filterState,
        uploadState,
        downloadState,
        themeState,
        wait,
        previewState,
      ];
}

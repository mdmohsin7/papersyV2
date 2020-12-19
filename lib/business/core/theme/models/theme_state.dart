import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool isDark;

  ThemeState({this.isDark});

  ThemeState copy({bool isDark}) {
    return ThemeState(isDark: isDark ?? this.isDark);
  }
  
  static initialState() => ThemeState(isDark: false);

  static ThemeState fromJson(dynamic json) =>
      ThemeState(isDark: json['isDark']);

  dynamic toJson() => {'isDark': isDark};

  @override
  List<Object> get props => [isDark];
}

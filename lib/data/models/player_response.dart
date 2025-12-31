import 'package:json_annotation/json_annotation.dart';

part 'player_response.g.dart';

@JsonSerializable()
class PlayerResponse {
  final List<PlayerModel> data;
  final MetaModel meta;

  PlayerResponse({required this.data, required this.meta});

  factory PlayerResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerResponseToJson(this);
}

@JsonSerializable()
class PlayerModel {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String position;
  final String height;
  final String weight;
  @JsonKey(name: 'jersey_number')
  final String jerseyNumber;
  final String college;
  final String country;
  @JsonKey(name: 'draft_year')
  final int? draftYear; // Nullable in case data is missing
  final TeamModel team;

  PlayerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.height,
    required this.weight,
    required this.jerseyNumber,
    required this.college,
    required this.country,
    this.draftYear,
    required this.team,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}

@JsonSerializable()
class TeamModel {
  final int id;
  final String conference;
  final String division;
  final String city;
  final String name;
  @JsonKey(name: 'full_name')
  final String fullName;

  TeamModel({
    required this.id,
    required this.conference,
    required this.division,
    required this.city,
    required this.name,
    required this.fullName,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamModelToJson(this);
}

@JsonSerializable()
class MetaModel {
  @JsonKey(name: 'next_cursor')
  final int? nextCursor;
  @JsonKey(name: 'per_page')
  final int perPage;

  MetaModel({this.nextCursor, required this.perPage});

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);
}

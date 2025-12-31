// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerResponse _$PlayerResponseFromJson(Map<String, dynamic> json) =>
    PlayerResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => PlayerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerResponseToJson(PlayerResponse instance) =>
    <String, dynamic>{'data': instance.data, 'meta': instance.meta};

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) => PlayerModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  position: json['position'] as String,
  height: json['height'] as String,
  weight: json['weight'] as String,
  jerseyNumber: json['jersey_number'] as String,
  college: json['college'] as String,
  country: json['country'] as String,
  draftYear: (json['draft_year'] as num?)?.toInt(),
  team: TeamModel.fromJson(json['team'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'position': instance.position,
      'height': instance.height,
      'weight': instance.weight,
      'jersey_number': instance.jerseyNumber,
      'college': instance.college,
      'country': instance.country,
      'draft_year': instance.draftYear,
      'team': instance.team,
    };

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) => TeamModel(
  id: (json['id'] as num).toInt(),
  conference: json['conference'] as String,
  division: json['division'] as String,
  city: json['city'] as String,
  name: json['name'] as String,
  fullName: json['full_name'] as String,
);

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
  'id': instance.id,
  'conference': instance.conference,
  'division': instance.division,
  'city': instance.city,
  'name': instance.name,
  'full_name': instance.fullName,
};

MetaModel _$MetaModelFromJson(Map<String, dynamic> json) => MetaModel(
  nextCursor: (json['next_cursor'] as num?)?.toInt(),
  perPage: (json['per_page'] as num).toInt(),
);

Map<String, dynamic> _$MetaModelToJson(MetaModel instance) => <String, dynamic>{
  'next_cursor': instance.nextCursor,
  'per_page': instance.perPage,
};

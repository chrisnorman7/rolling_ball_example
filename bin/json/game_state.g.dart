// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
      dominantHand:
          _$enumDecodeNullable(_$DominantHandEnumMap, json['dominantHand']) ??
              DominantHand.right,
      playerSpeed: json['playerSpeed'] as int? ?? 500,
    );

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'dominantHand': _$DominantHandEnumMap[instance.dominantHand],
      'playerSpeed': instance.playerSpeed,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$DominantHandEnumMap = {
  DominantHand.left: 'left',
  DominantHand.right: 'right',
};

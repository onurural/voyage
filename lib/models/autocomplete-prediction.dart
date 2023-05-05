class AutocompletePrediction {
  AutocompletePrediction({
    required this.predictions,
    required this.status,
  });
  late final List<Predictions> predictions;
  late final String status;
  
  AutocompletePrediction.fromJson(Map<String, dynamic> json){
    predictions = List.from(json['predictions']).map((e)=>Predictions.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['predictions'] = predictions.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Predictions {
  Predictions({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });
  late final String description;
  late final List<MatchedSubstrings> matchedSubstrings;
  late final String placeId;
  late final String reference;
  late final StructuredFormatting structuredFormatting;
  late final List<Terms> terms;
  late final List<String> types;
  
  Predictions.fromJson(Map<String, dynamic> json){
    description = json['description'];
    matchedSubstrings = List.from(json['matched_substrings']).map((e)=>MatchedSubstrings.fromJson(e)).toList();
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = StructuredFormatting.fromJson(json['structured_formatting']);
    terms = List.from(json['terms']).map((e)=>Terms.fromJson(e)).toList();
    types = List.castFrom<dynamic, String>(json['types']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    _data['matched_substrings'] = matchedSubstrings.map((e)=>e.toJson()).toList();
    _data['place_id'] = placeId;
    _data['reference'] = reference;
    _data['structured_formatting'] = structuredFormatting.toJson();
    _data['terms'] = terms.map((e)=>e.toJson()).toList();
    _data['types'] = types;
    return _data;
  }
}

class MatchedSubstrings {
  MatchedSubstrings({
    required this.length,
    required this.offset,
  });
  late final int length;
  late final int offset;
  
  MatchedSubstrings.fromJson(Map<String, dynamic> json){
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['length'] = length;
    _data['offset'] = offset;
    return _data;
  }
}

class StructuredFormatting {
  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
  });
  late final String mainText;
  late final List<MainTextMatchedSubstrings> mainTextMatchedSubstrings;
  late final String secondaryText;
  
  StructuredFormatting.fromJson(Map<String, dynamic> json){
    mainText = json['main_text'];
    mainTextMatchedSubstrings = List.from(json['main_text_matched_substrings']).map((e)=>MainTextMatchedSubstrings.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['main_text'] = mainText;
    _data['main_text_matched_substrings'] = mainTextMatchedSubstrings.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class MainTextMatchedSubstrings {
  MainTextMatchedSubstrings({
    required this.length,
    required this.offset,
  });
  late final int length;
  late final int offset;
  
  MainTextMatchedSubstrings.fromJson(Map<String, dynamic> json){
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['length'] = length;
    _data['offset'] = offset;
    return _data;
  }
}

class Terms {
  Terms({
    required this.offset,
    required this.value,
  });
  late final int offset;
  late final String value;
  
  Terms.fromJson(Map<String, dynamic> json){
    offset = json['offset'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['offset'] = offset;
    _data['value'] = value;
    return _data;
  }
}
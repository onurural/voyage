class InterestedCity {
  String? clickledUserIdStringValue;
  String? placeNameStringValue;
  int? count;

  InterestedCity(
      {this.clickledUserIdStringValue, this.placeNameStringValue, this.count});

  InterestedCity.fromJson(Map<String, dynamic> json) {
    clickledUserIdStringValue = json['clickled_user_id_string_value'];
    placeNameStringValue = json['place_name_string_value'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clickled_user_id_string_value'] = clickledUserIdStringValue;
    data['place_name_string_value'] = placeNameStringValue;
    data['count'] = count;
    return data;
  }
}

class InterestedCategory {
  String? clickledUserIdStringValue;
  String? placeCategoryStringValue;
  int? count;

  InterestedCategory(
      {this.clickledUserIdStringValue,
      this.placeCategoryStringValue,
      this.count});

  InterestedCategory.fromJson(Map<String, dynamic> json) {
    clickledUserIdStringValue = json['clickled_user_id_string_value'];
    placeCategoryStringValue = json['place_category_string_value'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clickled_user_id_string_value'] = clickledUserIdStringValue;
    data['place_category_string_value'] = placeCategoryStringValue;
    data['count'] = count;
    return data;
  }
}

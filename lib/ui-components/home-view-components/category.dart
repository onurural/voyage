import 'package:flutter/cupertino.dart';
import 'package:voyage/ui-components/home-view-components/category-places-list.dart';


class Category{
  String title;
  CategoryPlacesList cardsList;
  IconData icon;

 Category(this.title, this.cardsList, this.icon);
}
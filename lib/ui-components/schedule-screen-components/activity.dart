// ignore_for_file: prefer_typing_uninitialized_variables

class Activity{
  DateTime beginTime;
  DateTime endTime;
  DateTime day;
  var title;
  var subtitle;
  double rate;
  var description;
  List photos;
  var googleMapsLink;

  Activity(this.title,this.subtitle,this.rate,this.description,this.beginTime,this.endTime,this.day,this.photos,this.googleMapsLink);


}

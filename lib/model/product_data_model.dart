class ProductDataModel {
  String name;
  DateTime launchedDate;
  String launchSite;
  double popularity;
  String id;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.launchedDate,
      required this.launchSite,
      required this.popularity});
}

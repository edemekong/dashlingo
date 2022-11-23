class RouteData {
  final String route;
  final Map<String, String> _queryParameter;
  const RouteData({required this.route, required Map<String, String> queryParams}) : _queryParameter = queryParams;

  operator [](String key) => _queryParameter[key];
}

extension RouteDataStringExtension on String {
  RouteData get getRouteData {
    var uriData = Uri.parse(this);
    return RouteData(queryParams: uriData.queryParameters, route: uriData.path);
  }
}

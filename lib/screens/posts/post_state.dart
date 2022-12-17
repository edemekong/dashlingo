import 'package:flutterfairy/components/base_state.dart';
import 'package:flutterfairy/constants/paths.dart';

Map<String, dynamic> postRouteData = {
  mobileDevPostPath: {
    "title": "Mobile Development",
    "description": "Learn mobile from the world's top cross platform sdk's",
  },
  lifestylePostPath: {
    "title": "Developer's Lifestyle",
    "description": "Learn mobile from the world's top cross platform sdk's",
  },
};

class PostsState extends BaseState {
  final String id;
  PostsState(this.id);
}

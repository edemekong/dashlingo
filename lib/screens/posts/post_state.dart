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
  videoTutorialPath: {
    "title": "Video Tutorials",
    "description":
        "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.",
  },
};

class PostsState extends BaseState {
  final String id;
  PostsState(this.id);
}

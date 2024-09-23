import 'package:social_media_app/models/comments_model.dart';
import 'package:social_media_app/models/posts_model.dart';

class AppData {
  // Step 1: Private constructor banate hain
  AppData._();

  // Step 2: Ek static instance banate hain jo ki wahi ek instance rahega
  static final AppData _appData = AppData._();

  // Step 3: Factory constructor jo hamesha wahi instance return karega
  factory AppData() {
    return _appData;
  }

  // Ek example method jo singleton class ka instance call karne ke baad access ho sakta hai
  List<PostsModel> postsList = [];
  List<CommentsModel> commentsList = [];  
  var userData;  
}





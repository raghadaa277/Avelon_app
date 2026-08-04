import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/archive_post_controller.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/controller/Home/posts/my_posts_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArchivePostController>(() => ArchivePostController());

    Get.lazyPut<EditPostController>(() => EditPostController());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPostsController>(() => MyPostsController());

    Get.lazyPut<ArchivePostController>(() => ArchivePostController());

    Get.lazyPut<EditPostController>(() => EditPostController());
  }
}

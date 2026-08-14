import 'package:get/get.dart';
import 'package:programmers_network_app/core/helper/growth.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_growth_model.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_overview_model.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_overview_post_model.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_post_audience_model.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_post_view_source_model.dart';
import 'package:programmers_network_app/data/services/Home/growth_services.dart';

class GrowthController extends GetxController {
  final GrowthServices _growthServices = GrowthServices();

  bool isLoading = false;
  final RxString errorMessage = ''.obs;

  GrowthData? data;
  GrowthPeriod currentPeriod = GrowthPeriod.thisYear;

  Future<void> getGrowth({GrowthPeriod period = GrowthPeriod.thisYear}) async {
    if (isLoading) return;

    currentPeriod = period;
    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      final result = await _growthServices.getGrowth(period: period);

      if (result.success) {
        data = result.data;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> changePeriod(GrowthPeriod period) => getGrowth(period: period);

  GetOverviewModel? overview;

  String currentType = 'all';

  DateTime? currentStartDate;
  DateTime? currentEndDate;

  Future<void> getOverview({
    String type = 'all',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (isLoading) return;

    if ((startDate == null) != (endDate == null)) {
      errorMessage.value =
          'startDate and endDate must both be provided or both be null';
      update();
      return;
    }

    currentType = type;
    currentStartDate = startDate;
    currentEndDate = endDate;

    isLoading = true;
    errorMessage.value = '';

    update();

    try {
      final result = await _growthServices.getOverview(
        type: type,
        startDate: startDate,
        endDate: endDate,
      );

      if (result.success) {
        overview = result;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getAllOverview() async {
    await getOverview(type: 'all');
  }

  Future<void> getCustomOverview({
    required String type,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await getOverview(type: type, startDate: startDate, endDate: endDate);
  }

  Future<void> refreshOverview() async {
    if (isLoading) return;

    await getOverview(
      type: currentType,
      startDate: currentStartDate,
      endDate: currentEndDate,
    );
  }

  GetOverviewPostModel? overviewPost;

  Future<void> getOverviewPost({required int postId}) async {
    if (isLoading) return;

    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      final result = await _growthServices.getOverviewPost(postId: postId);

      if (result.success) {
        overviewPost = result;
      } else {
        overviewPost = null;
        errorMessage.value = result.message;
      }
    } catch (e) {
      overviewPost = null;
      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> refreshOverviewPost({required int postId}) async {
    if (isLoading) return;

    await getOverviewPost(postId: postId);
  }

  void clearData() {
    overviewPost = null;
    postAudience = null;
    errorMessage.value = '';
    update();
  }

  GetPostAudienceModel? postAudience;

  Future<void> getPostAudience({required int postId}) async {
    if (isLoading) return;

    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      final response = await _growthServices.getPostAudience(postId: postId);

      if (response.success) {
        postAudience = response.data;
      } else {
        postAudience = null;
        errorMessage.value = response.message;
      }
    } catch (e) {
      postAudience = null;
      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> refreshPostAudience({required int postId}) async {
    if (isLoading) return;

    await getPostAudience(postId: postId);
  }

  PostViewsOverviewResponseModel? postViewsOverview;

  Future<void> getPostViewsOverview({required int postId}) async {
    if (isLoading) return;

    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      final response = await _growthServices.getPostViewsOverview(
        postId: postId,
      );

      if (response.success) {
        postViewsOverview = response;
      } else {
        postViewsOverview = null;
        errorMessage.value = response.message;
      }
    } catch (e) {
      postViewsOverview = null;
      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> refreshPostViewsOverview({required int postId}) async {
    if (isLoading) return;

    await getPostViewsOverview(postId: postId);
  }
}

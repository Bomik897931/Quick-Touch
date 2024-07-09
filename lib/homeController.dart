import 'package:get/get.dart';
import 'package:quicktouch/services.dart';


class GiphyController extends GetxController {
  final GiphyService giphyService = GiphyService();
  var gifs = [].obs;
  var isLoading = false.obs;
  var query = 'trending'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGifs();
  }

  Future<void> fetchGifs() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final data = await giphyService.fetchGifs(query.value);
      gifs.addAll(data['data']);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void resetAndFetchGifs(String newQuery) {
    query.value = newQuery;
    giphyService.resetOffset();
    gifs.clear();
    fetchGifs();
  }
}

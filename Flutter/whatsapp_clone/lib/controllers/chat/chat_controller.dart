import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/chat_model.dart';
import '../../services/ApiClient.dart';
import '../../../core/constant/app_route.dart';

class ChatScreenController extends GetxController {
  // Rx list to store chats
  RxList<ChatModel> chats = <ChatModel>[].obs;

  // Rx boolean for loading
  RxBool isLoading = false.obs;

  final ApiClient apiClient = ApiClient();

  // Navigate to chat detail
  void goToDetailScreen(ChatModel chat) {
    Get.toNamed(AppRoute.chatDetail, arguments: {"chat": chat});
  }

  void goToContactScreen() {
    Get.toNamed(AppRoute.contact);
  }

  @override
  void onInit() {
    super.onInit();
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('id');

      if (userId == null) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final response = await apiClient.dio.get('/user/$userId/conversations');
      final List data = response.data;

      chats.value = data.map((json) => ChatModel.fromApi(json, userId)).toList();
    } on DioException catch (e) {
      final msg = e.response?.data?['detail'] ?? "Failed to load chats";
      Get.snackbar("Error", msg);
    } finally {
      isLoading.value = false;
    }
  }
}
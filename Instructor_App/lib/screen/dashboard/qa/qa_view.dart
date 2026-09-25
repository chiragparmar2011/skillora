import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/question_answer_model.dart';
import 'package:instructor_app/screen/dashboard/qa/qa_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:instructor_app/widgets/va_image_asset.dart';
import 'package:instructor_app/widgets/va_no_data_widget.dart';
import 'package:instructor_app/widgets/va_text_form_field.dart';

class QAView extends StatelessWidget {
  QAView({super.key});

  final QAController controller = Get.put(QAController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          translate(context, 'qa.title'),
          style: TextStyles().textStyleRoboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.platinumBorder, height: 1.0),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildTabSelector(context),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                    ),
                  );
                }

                final list = controller.filteredQuestions;
                if (list.isEmpty) {
                  return VANoDataWidget(
                    title: translate(context, 'qa.noQuestions'),
                    icon: Icons.check_circle_outline_rounded,
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => controller.loadQuestions(showLoader: false),
                  color: AppColors.primaryColor,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildQuestionCard(context, list[index]);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector(BuildContext context) {
    return Obx(() {
      return Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            _buildTabChip(
              label: translate(context, 'qa.unanswered'),
              isSelected: controller.selectedTab.value == 'unanswered',
              onTap: () => controller.selectedTab.value = 'unanswered',
            ),
            const SizedBox(width: 8),
            _buildTabChip(
              label: translate(context, 'qa.all'),
              isSelected: controller.selectedTab.value == 'all',
              onTap: () => controller.selectedTab.value = 'all',
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTabChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.secondaryColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyles().textStyleRoboto(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, QuestionItemModel item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: item.isAnswered
              ? AppColors.platinumBorder
              : AppColors.yellowColor.withValues(alpha: 0.6),
          width: item.isAnswered ? 1.0 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: VAImageAsset(
                    image: item.studentAvatar ?? 'assets/images/chat_one.png',
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.studentName,
                      style: TextStyles().textStyleRoboto(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      item.createdAt,
                      style: TextStyles().textStyleRoboto(
                        fontSize: 10,
                        color: AppColors.mentorAbout,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: item.isAnswered
                      ? AppColors.green.withValues(alpha: 0.12)
                      : AppColors.yellowColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.isAnswered ? "ANSWERED" : "NEEDS ANSWER",
                  style: TextStyles().textStyleRoboto(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color:
                        item.isAnswered ? AppColors.green : AppColors.yellowColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.menu_book_rounded,
                  size: 13,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    "${item.courseName}${item.lessonName != null ? ' â€¢ ${item.lessonName}' : ''}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 11,
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.title,
            style: TextStyles().textStyleRoboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            style: TextStyles().textStyleRoboto(
              fontSize: 13,
              color: AppColors.labelColor,
            ),
          ),
          if (item.answers.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...item.answers.map(
              (ans) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primaryColor.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              ans.isInstructor
                                  ? translate(context, 'qa.instructorBadge')
                                  : "Verified Answer",
                              style: TextStyles().textStyleRoboto(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              ans.userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles().textStyleRoboto(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          if (ans.createdAt.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            Text(
                              ans.createdAt,
                              style: TextStyles().textStyleRoboto(
                                fontSize: 10,
                                color: AppColors.mentorAbout,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        ans.answer,
                        style: TextStyles().textStyleRoboto(
                          fontSize: 12,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () => _showAnswerModal(context, item),
              icon: const Icon(Icons.reply_rounded,
                  size: 16, color: AppColors.white),
              label: Text(
                translate(context, 'qa.postAnswer'),
                style: TextStyles().textStyleRoboto(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAnswerModal(BuildContext context, QuestionItemModel item) {
    controller.replyController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reply as Verified Instructor",
                    style: TextStyles().textStyleRoboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        size: 20, color: AppColors.darkGray),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (Navigator.of(ctx).canPop()) {
                        Navigator.of(ctx).pop();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Question: \"${item.title}\"",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles().textStyleRoboto(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: AppColors.mentorAbout,
                ),
              ),
              const SizedBox(height: 16),
              VATextFormField(
                controller: controller.replyController,
                hintText: translate(context, 'qa.replyPlaceholder'),
                maxLines: 4,
              ),
              const SizedBox(height: 18),
              Obx(
                () => VAButton(
                  text: translate(context, 'qa.postAnswer'),
                  isLoading: controller.isInnerLoading.value,
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final nav = Navigator.of(ctx);
                    bool ok = await controller.submitAnswer(item.id);
                    if (ok) {
                      if (ctx.mounted && nav.canPop()) {
                        nav.pop();
                      }
                      controller.showSuccess(
                          "Verified instructor answer posted successfully!");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

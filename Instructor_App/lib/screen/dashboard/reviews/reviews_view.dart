import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/review_item_model.dart';
import 'package:instructor_app/screen/dashboard/reviews/reviews_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:instructor_app/widgets/va_image_asset.dart';
import 'package:instructor_app/widgets/va_no_data_widget.dart';
import 'package:instructor_app/widgets/va_text_form_field.dart';

class ReviewsView extends StatelessWidget {
  ReviewsView({super.key});

  final ReviewsController controller = Get.put(ReviewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          translate(context, 'reviews.title'),
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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            );
          }

          final list = controller.reviews;
          if (list.isEmpty) {
            return VANoDataWidget(
              title: translate(context, 'reviews.noReviews'),
              icon: Icons.star_border_rounded,
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.loadReviews(showLoader: false),
            color: AppColors.primaryColor,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRatingOverview(context),
                  const SizedBox(height: 20),
                  Text(
                    translate(context, 'reviews.reviewsCount'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildReviewCard(context, list[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRatingOverview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                controller.averageRating.toString(),
                style: TextStyles().textStyleRoboto(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(Icons.star_rounded,
                      size: 16, color: AppColors.yellowColor),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${controller.reviews.length} reviews",
                style: TextStyles().textStyleRoboto(
                  fontSize: 11,
                  color: AppColors.mentorAbout,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [5, 4, 3, 2, 1].map((star) {
                double pct = controller.getStarPercentage(star);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text(
                        "$star",
                        style: TextStyles().textStyleRoboto(
                          fontSize: 11,
                          color: AppColors.mentorAbout,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star,
                          size: 11, color: AppColors.yellowColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: pct,
                            minHeight: 6,
                            backgroundColor: AppColors.platinumBorder,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.yellowColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, ReviewItemModel item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child: VAImageAsset(
                    image: item.studentAvatar ?? 'assets/images/chat_one.png',
                    width: 34,
                    height: 34,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
              Row(
                children: [
                  const Icon(Icons.star_rounded,
                      size: 16, color: AppColors.yellowColor),
                  const SizedBox(width: 2),
                  Text(
                    item.rating.toString(),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                    item.courseName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 11,
                      color: AppColors.darkGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.comment,
            style: TextStyles().textStyleRoboto(
              fontSize: 13,
              color: AppColors.black,
            ),
          ),
          if (item.instructorReply != null) ...[
            const SizedBox(height: 10),
            Container(
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
                  Text(
                    "Your Reply â€¢ ${item.replyCreatedAt ?? ''}",
                    style: TextStyles().textStyleRoboto(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.instructorReply!,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (item.instructorReply == null) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _showReplyModal(context, item),
                icon: const Icon(Icons.reply_rounded,
                    size: 16, color: AppColors.primaryColor),
                label: Text(
                  translate(context, 'reviews.reply'),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showReplyModal(BuildContext context, ReviewItemModel item) {
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
                  Expanded(
                    child: Text(
                      "Reply to ${item.studentName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles().textStyleRoboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
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
              const SizedBox(height: 8),
              Text(
                "Review: \"${item.comment}\"",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles().textStyleRoboto(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: AppColors.mentorAbout,
                ),
              ),
              const SizedBox(height: 14),
              VATextFormField(
                controller: controller.replyController,
                hintText: translate(context, 'reviews.replyPlaceholder'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Obx(
                () => VAButton(
                  text: translate(context, 'reviews.sendReply'),
                  isLoading: controller.isInnerLoading.value,
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final nav = Navigator.of(ctx);
                    bool ok = await controller.submitReply(item.id);
                    if (ok) {
                      if (ctx.mounted && nav.canPop()) {
                        nav.pop();
                      }
                      controller.showSuccess("Reply posted successfully!");
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


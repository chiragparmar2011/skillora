import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

class VACommonProfile extends StatelessWidget {
  const VACommonProfile({
    required this.profileImage,
    this.userName,
    this.userEmail,
    this.optionName,
    this.isVisibleEdit = false,
    this.isShowSwitchText = false,
    this.onEditPhoto,
    super.key,
  });

  final RxString profileImage;
  final String? userName;
  final String? userEmail;
  final String? optionName;
  final bool isVisibleEdit;
  final bool isShowSwitchText;
  final Function()? onEditPhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        isVisibleEdit
            ? Stack(
                alignment: Alignment.center,
                children: [
                  _buildCircleImageView(),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (onEditPhoto != null) {
                          onEditPhoto?.call();
                        }
                      },
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : _buildCircleImageView(),
        const SizedBox(height: 10),
        if (userName != null)
          Text(
            userName ?? '',
            style: TextStyles().textStyleRoboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (!isVisibleEdit) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.settingBorderColor),
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.black,
                ),
                child: const Icon(
                  Icons.mail,
                  color: AppColors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 6),
              if (userEmail != null)
                Text(
                  userEmail ?? '',
                  style: TextStyles().textStyleRoboto(
                    fontSize: 14,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        _buildSwitchText(),
        if (optionName != null && optionName!.isNotEmpty)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 14, bottom: 6),
              child: Text(
                optionName!,
                style: TextStyles().textStyleRoboto(
                  fontSize: 14,
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildSwitchText() {
    if (isShowSwitchText) {
      return Column(
        children: [
          const SizedBox(height: 10),
          Text(
            translate(MyGlobals.navKey.currentContext, 'profile.switchView'),
            style: TextStyles().textStyleRoboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildCircleImageView() {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(54),
          child: Obx(
            () => Image.network(
              profileImage.value,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

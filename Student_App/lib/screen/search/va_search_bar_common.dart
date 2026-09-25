import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/search/searchbar_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_dialog.dart';

class VASearchBarCommon extends StatefulWidget {
  const VASearchBarCommon({
    this.hintText,
    required this.controller,
    this.onApply,
    this.globalKey,
    this.showFilter = true,
    super.key,
  });

  final String? hintText;
  final bool showFilter;
  final void Function()? onApply;
  final SearchBarController controller;
  final Key? globalKey;

  @override
  State<VASearchBarCommon> createState() => _VASearchBarCommonState();
}

class _VASearchBarCommonState extends State<VASearchBarCommon> {
  Timer? _debounceTimer;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    widget.controller.searchTextController?.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(covariant VASearchBarCommon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller.searchTextController !=
        widget.controller.searchTextController) {
      oldWidget.controller.searchTextController
          ?.removeListener(_onSearchChanged);
      widget.controller.searchTextController?.addListener(_onSearchChanged);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    widget.controller.searchTextController?.removeListener(_onSearchChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        widget.onApply?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.dropShadow.withValues(alpha: 0.2),
                spreadRadius: 0.5,
                blurRadius: 8,
              ),
            ],
          ),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            clipBehavior: Clip.none,
            child: TextField(
              key: widget.globalKey,
              focusNode: _focusNode,
              textInputAction: TextInputAction.search,
              controller: widget.controller.searchTextController,
              decoration: getInputDecoration(context),
              onSubmitted: (value) {
                _debounceTimer?.cancel();
                widget.onApply?.call();
              },
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration getInputDecoration(BuildContext context) {
    return InputDecoration(
      border: InputBorder.none,
      suffixIcon: widget.showFilter == false
          ? null
          : InkWell(
              onTap: () {
                VADialog.searchDialogPopup(
                  context,
                  widget.controller,
                  widget.onApply,
                );
              },
              child: const Icon(
                Icons.tune_rounded,
                color: AppColors.black,
                size: 22,
              ),
            ),
      prefixIcon: const Icon(
        Icons.search,
        size: 24,
        color: AppColors.searchColor,
      ),
      hintText: widget.hintText ??
          translate(MyGlobals.navKey.currentContext, 'common.search'),
      hintStyle: TextStyles().textStyleRoboto(
        fontSize: 14,
        color: AppColors.searchColor,
      ),
    );
  }
}

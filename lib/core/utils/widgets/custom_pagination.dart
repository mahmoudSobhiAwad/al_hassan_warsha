import 'package:flutter/material.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';

class CustomPaginationWidget extends StatelessWidget {
  const CustomPaginationWidget({
    super.key,
    required this.length,
    required this.currentPage,
    required this.onPageChanged,
  });

  final int length; // Total number of pages
  final int currentPage; // Current page number
  final Function(int) onPageChanged; // Callback for page change

  @override
  Widget build(BuildContext context) {
    // Calculate the range of pages to display
    const int maxVisiblePages = 10;
    int startPage = (currentPage - maxVisiblePages ~/ 2).clamp(1, length);
    int endPage = (startPage + maxVisiblePages - 1).clamp(1, length);

    // Adjust start page if at the end
    startPage = (endPage - maxVisiblePages + 1).clamp(1, length);

    // Generate list of visible pages
    List<int> visiblePages = List.generate(
      endPage - startPage + 1,
      (index) => startPage + index,
    );

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.veryLightGray2,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppColors.blackOpacity20,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Previous page button
          IconButton(
            onPressed:
                currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
              color: currentPage > 1 ? AppColors.blue : AppColors.lightGray1,
            ),
          ),
          // Page numbers
          ...[
            if (startPage > 1)
              InkWell(
                onTap: () => onPageChanged(1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('1',
                      style: AppFontStyles.extraBoldNew18(context)
                          .copyWith(color: AppColors.blue)),
                ),
              ),
            if (startPage > 2)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('...'),
              ),
            for (int page in visiblePages)
              InkWell(
                onTap: () => onPageChanged(page),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: page == currentPage
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$page',
                            style: AppFontStyles.extraBoldNew18(context)
                                .copyWith(color: AppColors.white),
                          ),
                        )
                      : Text(
                          '$page',
                          style: AppFontStyles.extraBoldNew18(context),
                        ),
                ),
              ),
            if (endPage < length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('...'),
              ),
            if (endPage < length)
              InkWell(
                onTap: () => onPageChanged(length),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('$length',
                      style: AppFontStyles.extraBoldNew18(context)
                          .copyWith(color: AppColors.blue)),
                ),
              ),
          ],
          // Next page button
          IconButton(
            onPressed: currentPage < length
                ? () => onPageChanged(currentPage + 1)
                : null,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 30,
              color:
                  currentPage < length ? AppColors.blue : AppColors.lightGray1,
            ),
          ),
        ],
      ),
    );
  }
}

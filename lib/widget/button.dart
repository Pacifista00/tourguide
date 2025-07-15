import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

Row buttonAction(
  BuildContext context,
  Function(BarcodeCapture)? onDetect,
  Function()? onTap,
  String? textAction,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          width: 200.w,
          height: 60.h,

          margin: EdgeInsets.only(bottom: 200.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            color: Colors.blueAccent,
          ),
          child: Center(
            child: Text(
              textAction!,
              style: GoogleFonts.notoSansSamaritan(
                fontSize: 15.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

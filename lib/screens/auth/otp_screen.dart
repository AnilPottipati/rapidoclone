import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rapidoclone/routes/app_pages.dart';
import 'package:rapidoclone/theme/app_colors.dart';
import 'package:rapidoclone/theme/text_styles.dart';
import 'package:rapidoclone/widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _resendLoading = false;
  int _resendTimer = 30;
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
    // Get phone number from arguments
    _phoneNumber = Get.arguments as String;
    _startResendTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() => _resendTimer--);
        _startResendTimer();
      }
    });
  }

  void _verifyOtp() {
    if (_formKey.currentState?.validate() ?? false) {
      final otp = _otpController.text;
      
      // Validate OTP format (6 digits)
      if (otp.length != 6) {
        Get.snackbar(
          'Invalid OTP',
          'Please enter a 6-digit OTP',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // For now, accept any 6-digit number as valid
      // In production, this should be replaced with actual API call
      setState(() => _isLoading = true);
      
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        Get.offAllNamed(Routes.HOME);
      });
    }
  }

  void _resendOtp() {
    if (_resendTimer > 0) return;

    setState(() {
      _resendLoading = true;
      _resendTimer = 30;
    });

    // Simulate resend OTP API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _resendLoading = false);
        _startResendTimer();
        Get.snackbar(
          'OTP Sent',
          'A new OTP has been sent to your mobile number',
          backgroundColor: AppColors.success,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify OTP',
          style: AppTextStyles.heading3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Title
                Center(
                  child: Text(
                    'Enter OTP',
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Center(
                  child: Text(
                    'Please enter the 6-digit OTP sent to your mobile number',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Verification Code Text
                Center(
                  child: Text(
                    'Verification Code',
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Phone Number
                Center(
                  child: Text(
                    'Please enter the 6-digit OTP sent to your mobile number',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // OTP Input Field
                Center(
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 56,
                      fieldWidth: 48,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.divider,
                      selectedColor: AppColors.primary,
                      borderWidth: 1,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (value) {
                      // Auto-submit when OTP is complete
                      _verifyOtp();
                    },
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter OTP';
                      } else if (value.length != 6) {
                        return 'Please enter 6-digit OTP';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Resend OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t receive the code? ',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (_resendTimer > 0) ...[
                      Text(
                        'Resend in $_resendTimer',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ] else ...[
                      GestureDetector(
                        onTap: _resendLoading ? null : _resendOtp,
                        child:
                            _resendLoading
                                ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
                                  ),
                                )
                                : Text(
                                  'Resend OTP',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 32),
                // Verify Button
                CustomButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  child:
                      _isLoading
                          ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text('VERIFY OTP'),
                ),
                const SizedBox(height: 24),
                // Change Number
                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Change Phone Number',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

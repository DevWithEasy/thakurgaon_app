import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> _codeControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;
  bool _isResendLoading = false;
  int _resendCountdown = 30;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
        _startResendCountdown();
      }
    });
  }

  Future<void> _verifyCode() async {
    setState(() => _isLoading = true);
    // Simulate verification
    Navigator.pushNamed(context, '/reset-password');
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    
    // Show success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Verification successful!'),
        backgroundColor: Colors.teal[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<void> _resendCode() async {
    setState(() {
      _isResendLoading = true;
      _resendCountdown = 30;
    });
    
    // Simulate resend
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() => _isResendLoading = false);
    _startResendCountdown();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('New verification code sent!'),
        backgroundColor: Colors.teal[400],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleCodeInput(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    // Auto submit when last digit is entered
    if (index == 5 && value.isNotEmpty) {
      _verifyCode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Header Illustration
            Icon(
              Icons.verified_user,
              size: 100,
              color: Colors.teal[400],
            ),
            const SizedBox(height: 24),
            Text(
              'Enter Verification Code',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We sent a 6-digit code to your email',
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  child: TextFormField(
                    controller: _codeControllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Colors.grey[800]!.withOpacity(0.5)
                          : Colors.grey[100],
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) => _handleCodeInput(value, index),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),

            // Verify Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      )
                    : const Text(
                        'VERIFY',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Resend Code
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive code?",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: _resendCountdown > 0 || _isResendLoading
                      ? null
                      : _resendCode,
                  child: _isResendLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          _resendCountdown > 0
                              ? 'Resend in $_resendCountdown'
                              : 'Resend Code',
                          style: TextStyle(
                            color: _resendCountdown > 0
                                ? Colors.grey
                                : Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
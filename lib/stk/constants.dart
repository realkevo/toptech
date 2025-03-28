class Constants {
  // Replace these with your actual credentials
  static const String consumerKey = '6PJQEIrZhCA3SHEiOG0M3prExeXnWcGmLVFlTa76alZZrjcV';
  static const String consumerSecret = 'Cwjc2yVN6iAQrHyM4hNHEUiTf7fmLGL2CulMv2rVGEjMMwERq4I1zo8MXfHkya7s';
  static const String shortcode = 'N/A'; // You need the correct shortcode from Safaricom

  // MPESA Shortcode
  static const String lipaNaMpesaShortcode = 'YOUR_LIPA_NA_MPESA_SHORTCODE';  // MPESA Shortcode for Lipa na MPESA
  static const String lipaNaMpesaShortcodePassword = 'YOUR_LIPA_NA_MPESA_PASSWORD';  // Password for Lipa na MPESA
  static const String lipaNaMpesaShortcodeSecret = 'YOUR_LIPA_NA_MPESA_SHORTCODE_SECRET';
  static const String lipaNaMpesaShortcodeURL = 'https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
  static const String tokenUrl =
      'https://api.safaricom.co.ke/oauth/v1/generate?grant_'
      'type=client_credentials';
}
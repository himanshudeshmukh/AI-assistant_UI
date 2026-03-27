import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profiler/config/theme/app_colors.dart';
import 'package:profiler/config/theme/app_text_styles.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletpageState();
}

class _WalletpageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet"),centerTitle: true,),
      body: Center(
        child:
            Text("Pavan Please Implement this page", style: AppTextStyles.headingMedium,),

        ),
      );
  }
}

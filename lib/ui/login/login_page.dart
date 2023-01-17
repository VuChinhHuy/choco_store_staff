import 'package:choco_store_staff/ui/base_page.dart';
import 'package:choco_store_staff/ui/login/login_controller.dart';
import 'package:choco_store_staff/utils/dimens.dart';
import 'package:choco_store_staff/utils/logger_debug/flutter_logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends BasePage<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget buildContentView(BuildContext context, LoginController controller) {
    final username = ConstrainedBox(
        constraints: BoxConstraints.tight(Size(360.w, 50.w)),
        child: TextFormField(
          controller: controller.usernameController,
          autofocus: false,
          decoration: InputDecoration(
            icon: const Icon(
              Icons.account_circle,
            ),
            hintText: 'Username',
            // initialValue: 'alucard@gmail.com',
            contentPadding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.w)),
          ),
        ));

    final password = ConstrainedBox(
        constraints: BoxConstraints.tight(Size(360.w, 50.w)),
        child: TextFormField(
          controller: controller.passwordController,
          autofocus: false,
          obscureText: true,
          decoration: InputDecoration(
            icon: const Icon(Icons.key),
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.w)),
          ),
        ));
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.w,
      ),
      child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            controller.login();
          },
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
          color: Colors.lightBlueAccent,
          child: Row(children: [
            const Text('Continue', style: TextStyle(color: Colors.white)),
            SizedBox(
              width: 5.w,
            ),
            const Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            )
          ])),
    );

    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 42.w,
            left: 264.w,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 103, 88, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.add_business,
                size: 46.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            top: 162.w,
            left: 39.w,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 97, 117, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.event_available,
                size: 38.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            top: 141.w,
            left: 310.w,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(219, 233, 236, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.request_quote,
                size: 20.w,
                color: Color.fromARGB(255, 20, 87, 74),
              ),
            )),
        Positioned(
            top: 221.w,
            left: 262.w,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(219, 233, 236, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.shopping_cart_checkout,
                size: 38.w,
                color: Color.fromARGB(255, 20, 87, 74),
              ),
            )),
        Positioned(
            top: 71.w,
            left: 102.w,
            height: 170.w,
            width: 170.w,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(219, 233, 236, 100),
                  borderRadius: BorderRadius.circular(170.w)),
              child: Center(
                  child: Text(
                'CHOCO STORE',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            )),
        Positioned(
          top: 320.w,
          left: 5.w,
          child: Column(
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.w,
              ),
              username,
              SizedBox(
                height: 10.w,
              ),
              password,
              SizedBox(
                height: 10.w,
              ),
              Row(
                children: [
                  Obx(() => Checkbox(
                      value: controller.check.isTrue,
                      onChanged: (value) {
                        controller.check.value = !controller.check.value;
                        Logger.d(controller.check);
                      })), // check box
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Ghi nhớ đăng nhập cho lần sau',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              loginButton,
            ],
          ),
        )
      ],
    ));
  }
}

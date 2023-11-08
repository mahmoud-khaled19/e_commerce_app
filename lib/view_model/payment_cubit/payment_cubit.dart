import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import '../../app_constance/stripe_keys.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController optionalPhoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Position? currentPosition;

  Future getPosition(context) async {
    bool services;
    LocationPermission permission;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      GlobalMethods.showToast(
          context, 'Location Service Not Enabled', Colors.red);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse) {
      getLocation();
    }
    if (permission == LocationPermission.always) {
      getLocation();
    }
  }

  Future<Position?> getLocation() async {
    emit(GetLocationLoadingState());
    currentPosition =
        await Geolocator.getCurrentPosition().then((value) => value);
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      currentPosition!.latitude,
      currentPosition!.longitude,
    );
    locationController.text = '${placeMarks[0].street}';
    emit(GetLocationSuccessState());
    return currentPosition;
  }

  Future<void> makePayment(int amount, String currency) async {
    emit(MakePaymentLoadingState());
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
      emit(MakePaymentSuccessState());
    } catch (error) {
      Exception(error.toString());
      emit(MakePaymentErrorState());
      print(error.toString());
      log(amount);
    }
  }

  Future<String> _getClientSecret(String amount, String currency) async {
    var response = await Dio().post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${StripeKeys.secretKey}',
          'content-type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response.data['client_secret'];
  }

  Future _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Koota',
      ),
    );
  }
}

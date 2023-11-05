import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
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
}

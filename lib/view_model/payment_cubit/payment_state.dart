abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class GetLocationSuccessState extends PaymentState {}
class GetLocationLoadingState extends PaymentState {}
class MakePaymentSuccessState extends PaymentState {}
class MakePaymentLoadingState extends PaymentState {}
class MakePaymentErrorState extends PaymentState {}
class ChangeTestVisaState extends PaymentState {}


abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class GetLocationSuccessState extends PaymentState {}
class GetLocationLoadingState extends PaymentState {}


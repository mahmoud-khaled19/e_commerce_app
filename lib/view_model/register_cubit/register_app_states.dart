abstract class RegisterAppStates {}

class InitialRegisterState extends RegisterAppStates {}

class ChangePassVisibilityForRegister extends RegisterAppStates {}

class RegisterLoadingState extends RegisterAppStates {}

class RegisterSuccessState extends RegisterAppStates {}

class RegisterErrorState extends RegisterAppStates {}

class UploadRegisterImageSuccessState extends RegisterAppStates {}

class UploadRegisterImageErrorState extends RegisterAppStates {}

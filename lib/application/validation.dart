class Validation {
  String? validateTitle(String value) {
    if (value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  String? validateStreetAddress(String value) {
    if (value.isEmpty) {
      return 'Street Address is required';
    }
    return null;
  }

  String? validateCity(String value) {
    if (value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  String? validatePostcode(String value) {
    if (value.isEmpty) {
      return 'Postcode is required';
    } else if (value.length != 4) {
      return 'Postcode is invalid';
    } else if (int.tryParse(value) == null) {
      return 'Postcode is invalid';
    }
    return null;
  }

  String? validatePrimaryContactName(String value) {
    if (value.isEmpty) {
      return 'Primary Contact Name is required';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@')) {
      return 'Email is invalid';
    } else if (!value.contains('.')) {
      return 'Email is invalid';
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'Phone is required';
    } else if (value.length != 10) {
      return 'Phone is invalid';
    } else if (!value.startsWith('0')) {
      return 'Phone is invalid';
    }
    return null;
  }
}

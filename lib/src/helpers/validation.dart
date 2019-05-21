String getErrorText(error, key) {
  return error != null && error[key] != null ? error[key][0] : null;
}

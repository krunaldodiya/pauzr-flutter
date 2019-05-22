String getErrorText(error, key) {
  return hasErrors(error, key) ? error["errors"][key][0] : null;
}

bool hasErrors(error, key) {
  return error != null &&
      error["errors"] != null &&
      error["errors"][key] != null;
}

class Notification {
  String date;
  String message;
  boolean isNotificationSended = false;

  Notification(String date, String mesaj) {
    this.date = date;
    this.message = mesaj;
  }

  boolean checkForDate() {
    return true;
  }
}

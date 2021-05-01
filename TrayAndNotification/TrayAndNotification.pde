

TrayManager tm;

void setup() {
  size(400, 400);

  frameRate(0.5);

  tm = new TrayManager();

  tm.addNotification(new Notification("1.05.2021 14:38", "Quiz"));
  tm.addNotification(new Notification("2.05.2021 14:38", "Quiz"));
}

void draw() {
  tm.checkNotifications();
}

import java.awt.TrayIcon.MessageType; //<>//

class TrayIconDemo {

  SystemTray systemTray;
  JFrame frame;
  TrayIcon trayIcon;

  boolean trayAdded = false;

  TrayIconDemo(SystemTray tray, JFrame frame) {
    this.systemTray = tray;
    this.frame = frame;
    createTray();
  }

  private void createTray() {
    if (!SystemTray.isSupported()) {
      System.out.println("SystemTray is not supported");
      return;
    }

    String path = "bulb.gif";

    final PopupMenu popup = new PopupMenu();
    trayIcon = 
      new TrayIcon(createImage(path, "tray icon"));

    MenuItem exitItem = new MenuItem("Exit");

    popup.add(exitItem);

    trayIcon.setPopupMenu(popup);

    trayIcon.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        surface.setVisible(true);
        frame.setExtendedState(JFrame.NORMAL);
        systemTray.remove(trayIcon);
        trayAdded = false;
      }
    }
    );

    exitItem.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        systemTray.remove(trayIcon);
        System.exit(0);
      }
    }
    );
  }

  void addTray() {
    try {
      if (!trayAdded) {
        systemTray.add(trayIcon);
        trayAdded = true;
      }
    }
    catch (AWTException e) {
      System.out.println("TrayIcon could not be added.");
      trayAdded = false;
      return;
    }
  }

  void removeTray() {
    systemTray.remove(trayIcon);
    trayAdded = false;
  }

  Image createImage(String path, String description) { 
    try {
      URL imageURL = new File(path).toURI().toURL();
      if (imageURL == null) {
        System.err.println("Resource not found: " + path);
        return null;
      } else {  
        return (new ImageIcon(imageURL, description)).getImage();
      }
    } 
    catch (Exception ex) {
      ex.printStackTrace();
    }
    return null;
  }

  public void displayNotification(String message) throws AWTException {
    addTray();
    trayIcon.displayMessage("Hello, World", message, MessageType.INFO);
  }
}

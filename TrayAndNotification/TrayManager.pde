import processing.awt.PSurfaceAWT;
import java.awt.*;
import java.awt.event.*;
import java.net.URL;
import javax.swing.*;

class TrayManager {

  JFrame frame;
  SystemTray systemTray;
  TrayIconDemo notificationTray;

  ArrayList < Notification > notifications;

  TrayManager() {
    frame = getJFrame();
    systemTray = SystemTray.getSystemTray();
    notificationTray = new TrayIconDemo(systemTray, frame);

    notifications = new ArrayList();

    frame.addWindowStateListener(new WindowStateListener() {
      public void windowStateChanged(WindowEvent e) {
        if (e.getNewState() == JFrame.ICONIFIED) {
          try {
            notificationTray.addTray();
            surface.setVisible(false);
          } 
          catch (Exception ex) {
            System.out.println("unable to add to tray");
          }
        }
      }
    }
    );

    frame.addWindowListener(new WindowAdapter() {
      @Override
        public void windowClosing(WindowEvent e) {
        notificationTray.removeTray();
        System.exit(0);
      }
    }
    );

    try {
      UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
    } 
    catch (UnsupportedLookAndFeelException ex) {
      ex.printStackTrace();
    } 
    catch (IllegalAccessException ex) {
      ex.printStackTrace();
    } 
    catch (InstantiationException ex) {
      ex.printStackTrace();
    } 
    catch (ClassNotFoundException ex) {
      ex.printStackTrace();
    }

    UIManager.put("swing.boldMetal", Boolean.FALSE);
  }

  void addNotification(Notification notification) {
    notifications.add(notification);
  }

  void checkNotifications() {
    for (Notification notification : notifications) {
      if (!notification.isNotificationSended && notification.checkForDate()) {
        sendNotification(notification);
      }
    }
  }

  void sendNotification(Notification notification) {
    if (SystemTray.isSupported()) {
      try {    
        notification.isNotificationSended = true;
        notificationTray.displayNotification(notification.message);
      } 
      catch(Exception e) {
        println(e);
        notification.isNotificationSended = false;
      }
    } else {
      System.err.println("System tray not supported!");
    }
  }

  public JFrame getJFrame() {
    PSurfaceAWT surf = (PSurfaceAWT) getSurface();
    PSurfaceAWT.SmoothCanvas canvas = (PSurfaceAWT.SmoothCanvas) surf.getNative();
    return (JFrame) canvas.getFrame();
  }
}

use gtk::{glib, Application, Button, Box, Orientation};
use gtk::{prelude::*, ApplicationWindow};

const APP_ID: &str = "org.RoccoRakete.MonitorHelper";

fn main() -> glib::ExitCode {
    // create an application
    let app = Application::builder().application_id(APP_ID).build();

    // connect to "activate" signal of 'app'
    app.connect_activate(build_ui);

    // run app
    app.run()
}

fn build_ui(app: &Application) {
    // create button1
    let button1 = Button::builder()
        .label("Press1!")
        .margin_top(12)
        .margin_bottom(12)
        .margin_start(12)
        .margin_end(12)
        .build();

    // create button2
    let button2 = Button::builder()
        .label("Press2!")
        .margin_top(12)
        .margin_bottom(12)
        .margin_start(12)
        .margin_end(12)
        .build();

    // connect to 'clicked' signal of button1
    button1.connect_clicked(|button| {
        button.set_label("Hello Button 1!");
    });

    // connect to 'clicked' signal of button2
    button2.connect_clicked(|button| {
        button.set_label("Hello Button 2!");
    });

    // create a box to hold the buttons
    let vbox = Box::new(Orientation::Vertical, 0);
    vbox.append(&button1);
    vbox.append(&button2);

    // create window and set title
    let window = ApplicationWindow::builder()
        .application(app)
        .title("MonitorHelper")
        .child(&vbox)
        .build();

    // present window
    window.present();
}

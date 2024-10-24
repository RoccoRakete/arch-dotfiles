use gtk::builders::ButtonBuilder;
use gtk::{glib, Application, Button};
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
    // create button
    let button1 = Button::builder()
        .label("Press1!")
        .margin_top(12)
        .margin_bottom(12)
        .margin_start(12)
        .margin_end(12)
        .build();

    

    // create window and set title
    let window = ApplicationWindow::builder()
        .application(app)
        .title("MonitorHelper")
        .child(&button1)
        .build();

    // present window
    window.present();
}

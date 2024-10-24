use gtk::builders::ButtonBuilder;
use gtk::{prelude::*, ApplicationWindow};
use gtk::{glib, Application};

const APP_ID: &str = "org.RoccoRakete.MonitorHelper";

fn main() -> glib::ExitCode {
    // create an application
    let app = Application::builder().application_id(APP_ID).build();

    // connect to "activate" signal of 'app'
    app.connect_activate(build_ui);

    // run app
    app.run()
}

fn build_ui (app: &Application) {
    // create button
    let button = Button::builder()
 
    // create window and set title
    let window = ApplicationWindow::builder()
        .application(app)
        .title("MonitorHelper")
        .build();

    // present window
    window.present();
}
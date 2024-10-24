use gtk::prelude::*;
use gtk::{glib, Application};

const APP_ID: &str = "org.RoccoRakete.MonitorHelper";

fn main() -> glib::ExitCode {
    // create an application
    let app = Application::builder().application_id(APP_ID).build();

    // run app
    app.run()
}
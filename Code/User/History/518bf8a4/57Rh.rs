use gtk::prelude::*;
use relm4::prelude::*;

#[derive(Debug)]
enum Msg {
    Button1Clicked,
    Button2Clicked,
}

struct Model;

impl Update for Model {
    type Message = Msg;

    fn update(&mut self, msg: Self::Message) {
        match msg {
            Msg::Button1Clicked => println!("Button 1 clicked!"),
            Msg::Button2Clicked => println!("Button 2 clicked!"),
        }
    }
}

struct App;

impl Widget for App {
    type Model = Model;
    type Message = Msg;

    fn model() -> Self::Model {
        Model
    }

    fn view(&self, model: &Self::Model) -> Element<Self::Message> {
        // Verwende einen vertikalen Container
        column![
            button!("Button 1").on_click(|_| Msg::Button1Clicked),
            button!("Button 2").on_click(|_| Msg::Button2Clicked),
        ]
        .into()
    }
}

fn main() {
    // Starte die Relm4-App
    relm4::run::<App>();
}



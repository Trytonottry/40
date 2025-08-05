use reqwest::{Client, Url};
use crate::collector::Event;

pub async fn send_event(ev: String) {
    let client = Client::new();
    let _ = client
        .post("https://cloud.nanoedr.com/v1/event")
        .json(&Event {
            ts: Utc::now().timestamp(),
            host: hostname::get().unwrap().to_string_lossy().into_owned(),
            pid: 0, ppid: 0, exe: ev, action: "process", extra: serde_json::Value::Null,
        })
        .send()
        .await;
}
use serde::{Deserialize, Serialize};
use chrono::Utc;

#[derive(Serialize)]
pub struct Event {
    pub ts: i64,
    pub host: String,
    pub pid: u32,
    pub ppid: u32,
    pub exe: String,
    pub action: String,
    pub extra: serde_json::Value,
}
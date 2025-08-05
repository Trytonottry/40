use serde::Deserialize;

#[derive(Debug, Deserialize)]
pub struct Config {
    pub tenant_id: String,
    pub api_key: String,
    pub endpoint_url: String,
    pub poll_ms: u64,
}
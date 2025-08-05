#[tokio::main]
async fn main() -> anyhow::Result<()> {
    tracing_subscriber::fmt::init();
    let cfg = config::load()?;

    #[cfg(target_os = "linux")]
    linux::ebpf::spawn().await?;
    #[cfg(target_os = "windows")]
    windows::etw::start_etw()?;

    tokio::signal::ctrl_c().await?;
    Ok(())
}
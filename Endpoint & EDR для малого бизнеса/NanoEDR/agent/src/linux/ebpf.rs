use aya::maps::perf::AsyncPerfEventArray;
use aya::programs::KProbe;
use aya::{Bpf, Btf};
use bytes::BytesMut;

pub async fn spawn() -> anyhow::Result<()> {
    let mut bpf = Bpf::load(include_bytes!("../../probe/nanoedr.bpf.o"))?;
    let btf = Btf::from_sys_fs()?;
    let prog: &mut KProbe = bpf.program_mut("trace_exec").unwrap().try_into()?;
    prog.load("trace_sys_enter_execve", &btf)?;

    let mut buf = AsyncPerfEventArray::try_from(bpf.map_mut("events")?)?;
    for cpu_id in 0..buf.capacity() {
        let mut events = buf.open(cpu_id, None)?;
        tokio::spawn(async move {
            let mut buf = vec![0; 1024];
            while let Some(bytes) = events.read(&mut buf).await {
                let event = String::from_utf8_lossy(&bytes);
                tracing::debug!("eBPF event: {}", event);
                super::uplink::send_event(event.into_owned()).await;
            }
        });
    }
    Ok(())
}
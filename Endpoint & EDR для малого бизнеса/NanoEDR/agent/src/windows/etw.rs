use windows::Win32::System::Diagnostics::Etw::*;
use std::ffi::c_void;

pub fn start_etw() -> anyhow::Result<()> {
    unsafe {
        let session = TRACEHANDLE::default();
        let mut props = EVENT_TRACE_PROPERTIES::default();
        props.Wnode.BufferSize = std::mem::size_of::<EVENT_TRACE_PROPERTIES>() as u32;
        props.Wnode.Flags = WNODE_FLAG_TRACED_GUID;
        props.LogFileMode = EVENT_TRACE_REAL_TIME_MODE;
        props.LoggerNameOffset = std::mem::size_of::<EVENT_TRACE_PROPERTIES>() as u32;
        StartTraceA(&session, "NanoEDR\0".as_ptr() as _, &props)?;
        EnableTraceEx2(session, &ProcessGuid, EVENT_CONTROL_CODE_ENABLE_PROVIDER, 0, 0, 0, 0)?;
    }
    Ok(())
}
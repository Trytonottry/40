def filter_cves(cves, calls, min_severity="moderate"):
    severity_map = {"low": 0, "moderate": 1, "high": 2, "critical": 3}
    min_lvl = severity_map[min_severity]
    filtered = []
    for cve in cves:
        sev = cve.get("severity", "low")
        if severity_map.get(sev, 0) < min_lvl:
            continue
        vuln_func = cve.get("affected_function", "")
        if vuln_func in calls:
            cve["reachable"] = True
            filtered.append(cve)
    return filtered
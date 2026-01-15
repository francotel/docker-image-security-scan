{{- /* Fixed template with proper spacing */ -}}
{{- $total := 0 -}}
{{- $high := 0 -}}
{{- $critical := 0 -}}
{{- range . -}}
  {{- range .Vulnerabilities -}}
    {{- $total = add $total 1 -}}
    {{- if eq .Severity "HIGH" }}{{ $high = add $high 1 }}{{ end -}}
    {{- if eq .Severity "CRITICAL" }}{{ $critical = add $critical 1 }}{{ end -}}
  {{- end -}}
{{- end -}}

# 🔒 Security Scan Results

{{- if gt $total 0 }}

## ⚠️ Vulnerabilities Detected
**Total:** {{ $total }}  
**CRITICAL:** {{ $critical }}  
**HIGH:** {{ $high }}

### 📋 Details
| Severity | Package | Vulnerability | Fixed |
|----------|---------|--------------|-------|
{{- range . -}}
  {{- range .Vulnerabilities -}}
| {{ .Severity }} | {{ .PkgName }} | {{ .VulnerabilityID }} | {{ or .FixedVersion "─" }} |
  {{- end -}}
{{- end -}}

{{- else }}

## ✅ Security Status: PASSED
No HIGH or CRITICAL vulnerabilities found.

{{- end }}
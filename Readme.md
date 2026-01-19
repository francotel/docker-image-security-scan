# 🛡️ Docker Image Security Pipeline 
A GitHub Actions workflow that builds Docker images, runs security scans with Trivy & Checkov, and pushes to AWS ECR only if all security checks pass.  

## 🚀 Quick Start  

### 1. Prerequisites 

```bash  
# macOS setup  
brew install jq docker awscli 
# AWS ECR repository  
aws ecr create-repository --repository-name nginx-base --region us-east-1   
```

### 2\. GitHub Configuration

**Add these Secrets** (Settings → Secrets → Actions):

*   AWS\_ACCESS\_KEY\_ID\_DEV
    
*   AWS\_SECRET\_ACCESS\_KEY\_DEV
    
*   AWS\_REGION
    
*   AWS\_ECR\_REGISTRY\_DEV
    

### 3\. Run the Pipeline

1.  Go to **Actions** tab
    
2.  Select **docker-images-security-pipeline**
    
3.  Click **Run workflow**
    
4.  Choose:
    
    *   **Image**: base or ingress
        
    *   **Environment**: dev
        

📁 Project Structure
--------------------

```text
   .github/workflows/  
   ├── docker-images-security-pipeline.yml    
   # Parent workflow  
   └── template-build-push.yml               
   # Reusable template  
   docker/  
   ├── base/Dockerfile  
```

🔧 How It Works
---------------

### Phase 1: Security Scanning


```yaml
   - Build image locally  
   - Run Trivy (vulnerabilities)  
   - Run Checkov (Dockerfile config)  
   - Generate security report   
```

### Phase 2: Validation Gate

```yaml
- Block if critical/high vulnerabilities  
- Show detailed report in GitHub Summary  
- Provide fix instructions
```

### Phase 3: Push to AWS ECR (Only if secure)

```yaml
- Push with two tags:    
• sha-{commit_hash}    
• {env}-latest  
- Add metadata labels
```

📊 Sample Security Report
-------------------------

```text
   🔍 Trivy Vulnerability Scan Results  
   📈 Security Summary  
   | Severity    | Count |  
   |-------------|-------|  
   | 🔴 CRITICAL | 2     |  
   | 🟠 HIGH     | 9     |  
   | Total       | 11    |  
   
   🏗️ Checkov Configuration Scan  ✅ All checks passed (22 passed, 0 failed)
```

🚨 Blocking Rules
-----------------

*   ❌ **CRITICAL** vulnerabilities → Pipeline fails
    
*   ❌ **HIGH** vulnerabilities → Pipeline fails
    
*   ❌ **Failed Checkov checks** → Pipeline fails
    

🔧 Configuration Files
----------------------

### config/trivy/trivy.yaml

```yaml
format: table  
exit-code: 1  
severity: [CRITICAL, HIGH]  
ignore-unfixed: true  
security-checks: [vuln, secret, config]   
```

### config/checkov/checkov.yaml

```yaml
soft-fail: false  
compact: true  
framework: [dockerfile]
```

### Add New Environment

1.  Add new job in parent workflow
    
2.  Add corresponding GitHub secrets
    

🎯 One-Liner Summary
--------------------

**Build → Scan → Validate → Push (only if secure)**

**Ready to secure your Docker images?**⭐ **Star the repo** | 🐑 **Fork & adapt** | 💬 **Open issues**

**#DevSecOps #GitHubActions #DockerSecurity #AWSECR**
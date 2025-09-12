# SafeMate Environment Documentation

## 🌍 **Environment Overview**

SafeMate uses a multi-environment architecture to support development, testing, and production workflows. Each environment is isolated with its own AWS resources, configurations, and deployment processes.

## 🏗️ **Environment Architecture**

### **📊 Environment Matrix**

| Environment | Purpose | AWS Region | Hedera Network | Debug Mode | Demo Mode | Cost Profile | Status |
|-------------|---------|------------|----------------|------------|-----------|--------------|---------|
| **Development** | Local development & testing | ap-southeast-2 | Testnet | ✅ Enabled | ✅ Enabled | Free Tier ($0.00/month) | ✅ Active |
| **Pre-Production** | Integration testing & staging | ap-southeast-2 | Testnet | ❌ Disabled | ❌ Disabled | Low Cost (~$5-10/month) | 🚀 **Ready to Deploy** |
| **Production** | Live application | ap-southeast-2 | Mainnet | ❌ Disabled | ❌ Disabled | Standard Cost (~$20-50/month) | 📋 Documented Only |

### **🔧 Environment Characteristics**

#### **Development Environment** ✅ **ACTIVE**
- **Purpose**: Local development and testing
- **Access**: Developers only
- **Data**: Test data only
- **Deployment**: Manual via PowerShell scripts
- **Monitoring**: Basic CloudWatch logs
- **Security**: Development-level security
- **URL**: `http://localhost:5173`

#### **Pre-Production Environment** 🚀 **READY TO DEPLOY**
- **Purpose**: Integration testing and staging
- **Access**: Development team and stakeholders
- **Data**: Test data (production-like)
- **Deployment**: Automated via Terraform
- **Monitoring**: Enhanced CloudWatch monitoring
- **Security**: Production-like security
- **URL**: `https://d19a5c2wn4mtdt.cloudfront.net`
- **Deployment Script**: `deploy-preprod-only.ps1`

#### **Production Environment** 📋 **DOCUMENTED ONLY**
- **Purpose**: Live application for end users
- **Access**: Public users
- **Data**: Real production data
- **Deployment**: Automated via Terraform (when ready)
- **Monitoring**: Full production monitoring
- **Security**: Production security standards
- **URL**: `https://prod.safemate.com` (TBD)
- **Status**: Configuration documented, deployment pending

## 📁 **Environment Documentation Structure**

### **📊 Visual Diagrams**
- [Environment Diagrams](diagrams/index.html) - Interactive visual diagrams and architecture overviews
- [Environment Architecture](diagrams/environment-architecture.html) - Complete environment architecture diagrams
- [Quick Reference](diagrams/quick-reference.html) - Quick reference diagrams and tables
- [Network Architecture](diagrams/network-architecture.html) - Network infrastructure and security diagrams

### **🚀 Deployment Guides**
- [Development Environment](development/README.md) - Local development setup and deployment
- [Pre-Production Environment](preprod/README.md) - Staging environment management
- [Production Environment](production/README.md) - Production environment management (documented only)

### **⚙️ Configuration Guides**
- [Environment Configuration](configuration/README.md) - Environment-specific settings
- [Terraform Configuration](terraform/README.md) - Infrastructure as Code setup
- [AWS Resource Management](aws-resources/README.md) - AWS service configuration

### **🔧 Management Guides**
- [Environment Management](management/README.md) - Daily operations and maintenance
- [Monitoring Setup](monitoring/README.md) - Logging and monitoring configuration
- [Security Configuration](security/README.md) - Security and compliance setup

## 🚀 **Quick Start**

### **For Development**
1. Review [Development Setup](development/README.md)
2. Run local development server: `npm run dev`
3. Access at: `http://localhost:5173`

### **For Pre-Production Deployment**
1. Review [Pre-Production Setup](preprod/README.md)
2. Run deployment script: `.\deploy-preprod-only.ps1`
3. Access at: `https://d19a5c2wn4mtdt.cloudfront.net`

### **For Production (Future)**
1. Review [Production Documentation](production/README.md)
2. Update production configuration
3. Deploy when ready for production

## 📋 **Environment Checklist**

### **Development** ✅
- [x] Local development environment configured
- [x] AWS resources deployed
- [x] API endpoints functional
- [x] Authentication working
- [x] Database populated with test data

### **Pre-Production** 🚀
- [x] Environment configuration documented
- [x] Terraform configuration ready
- [x] Deployment script created
- [x] CloudFront URL configured
- [ ] AWS resources deployed
- [ ] API endpoints tested
- [ ] Authentication configured
- [ ] Database migration completed

### **Production** 📋
- [x] Environment configuration documented
- [x] Security requirements defined
- [x] Monitoring strategy planned
- [ ] Domain and SSL configured
- [ ] AWS resources planned
- [ ] Deployment pipeline designed
- [ ] Disaster recovery plan created

## 🔄 **Environment Lifecycle**

### **Development → Pre-Production**
1. Code review and testing completed
2. Pre-production deployment script executed
3. Integration testing performed
4. Stakeholder approval obtained

### **Pre-Production → Production**
1. Pre-production validation completed
2. Production configuration finalized
3. Domain and SSL certificates configured
4. Production deployment executed
5. Monitoring and alerting activated

## 📊 **Environment Metrics**

### **Cost Tracking**
- **Development**: $0.00/month (Free Tier)
- **Pre-Production**: ~$5-10/month (Estimated)
- **Production**: ~$20-50/month (Estimated)

### **Performance Targets**
- **Development**: Basic performance monitoring
- **Pre-Production**: Enhanced monitoring and alerting
- **Production**: Full performance monitoring and optimization

## 🔒 **Security Considerations**

### **Development**
- Basic security measures
- Test data only
- Limited access controls

### **Pre-Production**
- Production-like security
- Enhanced monitoring
- Controlled access

### **Production**
- Full security implementation
- Comprehensive monitoring
- Strict access controls

## 📞 **Support**

### **Environment Issues**
- **Development Issues**: Check [Development Troubleshooting](development/README.md)
- **Pre-Production Issues**: Check [Pre-Production Troubleshooting](preprod/README.md)
- **Production Issues**: Check [Production Troubleshooting](production/README.md)

### **General Support**
- **AWS Issues**: Check [AWS](aws/) documentation
- **Blockchain Issues**: Check [Blockchain](blockchain/) documentation
- **API Issues**: Check [API](api/) documentation
- **Environment Issues**: Check [Environments](environments/) documentation
- **Monitoring Issues**: Check [Monitoring](environments/monitoring/) documentation

---

*Last Updated: 2025-01-26*
*Next Review: 2025-02-26*

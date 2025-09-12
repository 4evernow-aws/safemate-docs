# SafeMate Folder Structure Cleanup Plan

## 🚨 **CRITICAL: Root Directory Clutter Issues**

### **Current Problems:**
1. **100+ files in root directory** - Should be organized into appropriate folders
2. **Duplicate test files** - Multiple similar test scripts scattered
3. **Temporary fix files** - Many one-time fix scripts that should be archived
4. **Large zip files** - Multiple versions of the same service
5. **Inconsistent naming** - Mixed naming conventions

---

## 📋 **CLEANUP CATEGORIES**

### **1. TEST FILES TO ORGANIZE**
**Current Location:** Root directory
**Target Location:** `tests/` directory

#### **Balance Check Tests:**
- `check-hashscan-balance.js` → `tests/hedera/check-hashscan-balance.js`
- `check-operator-balance.js` → `tests/hedera/check-operator-balance.js`
- `check-wallet-balance.js` → `tests/hedera/check-wallet-balance.js`
- `test-balance.js` → `tests/hedera/test-balance.js`

#### **Lambda Test Files:**
- `test-lambda-*.js` → `tests/lambda/`
- `test-lambda-*.ps1` → `tests/lambda/`
- `debug-lambda.js` → `tests/lambda/debug-lambda.js`
- `test-lambda-payload.json` → `tests/lambda/payloads/`
- `test-lambda.json` → `tests/lambda/payloads/`

#### **API Test Files:**
- `test-api-*.ps1` → `tests/api/`
- `test-api-gateway.html` → `tests/api/`
- `test-*-payload.json` → `tests/api/payloads/`

### **2. FIX SCRIPTS TO ARCHIVE**
**Current Location:** Root directory
**Target Location:** `scripts/archive/fixes/`

#### **CORS Fix Scripts:**
- `fix-cors-*.ps1` → `scripts/archive/fixes/cors/`
- `CORS_*.md` → `scripts/archive/fixes/cors/`
- `check-cors-config.ps1` → `scripts/archive/fixes/cors/`

#### **Lambda Fix Scripts:**
- `fix-lambda-*.ps1` → `scripts/archive/fixes/lambda/`
- `LAMBDA_*.md` → `scripts/archive/fixes/lambda/`
- `diagnose-*.ps1` → `scripts/archive/fixes/lambda/`

#### **Authentication Fix Scripts:**
- `fix-401-*.ps1` → `scripts/archive/fixes/auth/`
- `fix-api-gateway-*.ps1` → `scripts/archive/fixes/auth/`
- `401_*.md` → `scripts/archive/fixes/auth/`

### **3. DEPLOYMENT SCRIPTS TO ORGANIZE**
**Current Location:** Root directory
**Target Location:** `scripts/deployment/`

#### **Active Deployment Scripts:**
- `deploy-*.ps1` → `scripts/deployment/`
- `build-*.ps1` → `scripts/deployment/`
- `setup-*.ps1` → `scripts/deployment/`

### **4. CONFIGURATION FILES TO ORGANIZE**
**Current Location:** Root directory
**Target Location:** `config/`

#### **Lambda Configs:**
- `lambda-config-*.json` → `config/lambda/`
- `lambda-env.json` → `config/lambda/`
- `env-vars.json` → `config/lambda/`

#### **AWS Configs:**
- `consolidated-wallet-config.json` → `config/aws/`
- `consolidated-wallet-env.json` → `config/aws/`
- `cors-config-manager.json` → `config/aws/`

### **5. LARGE ZIP FILES TO CLEAN**
**Current Location:** Root directory
**Action:** Keep only the latest version

#### **Ultimate Wallet Service Zips:**
- `ultimate-wallet-service-minimal.zip` → **DELETE** (obsolete)
- `ultimate-wallet-service-fixed.zip` → **DELETE** (obsolete)
- `ultimate-wallet-service-final.zip` → **DELETE** (obsolete)
- `ultimate-wallet-service-clean.zip` → **KEEP** (latest)

### **6. DOCUMENTATION FILES TO ORGANIZE**
**Current Location:** Root directory
**Target Location:** `documentation/archive/`

#### **Fix Summaries:**
- `*_FIX_SUMMARY.md` → `documentation/archive/fixes/`
- `*_RESOLUTION_SUMMARY.md` → `documentation/archive/fixes/`
- `*_STATUS_CHECK.md` → `documentation/archive/status/`

---

## 🎯 **PROPOSED CLEAN STRUCTURE**

```
safemate_v2/
├── apps/                          # Frontend applications
│   └── web/safemate/
├── services/                      # Backend Lambda services
│   ├── ultimate-wallet-service/
│   ├── consolidated-wallet-service/
│   ├── user-onboarding/
│   └── ...
├── documentation/                 # Project documentation
│   ├── archive/                   # Archived documentation
│   │   ├── fixes/                 # Fix summaries
│   │   └── status/                # Status reports
│   └── [current docs]
├── guides/                        # Development guides
├── scripts/                       # Utility scripts
│   ├── deployment/                # Active deployment scripts
│   ├── testing/                   # Test utilities
│   └── archive/                   # Archived fix scripts
│       ├── cors/                  # CORS fixes
│       ├── lambda/                # Lambda fixes
│       └── auth/                  # Auth fixes
├── config/                        # Configuration files
│   ├── lambda/                    # Lambda configs
│   └── aws/                       # AWS configs
├── tests/                         # Test files
│   ├── api/                       # API tests
│   ├── lambda/                    # Lambda tests
│   ├── hedera/                    # Hedera tests
│   └── terraform/                 # Terraform tests
├── terraform/                     # Infrastructure as code
├── lambda-layer/                  # Lambda layers
├── utils/                         # Utility functions
└── [core project files]
    ├── package.json
    ├── README.md
    └── [other essential files]
```

---

## 🚀 **CLEANUP EXECUTION PLAN**

### **Phase 1: Create Directory Structure**
1. Create missing directories
2. Move files to appropriate locations
3. Update any hardcoded paths

### **Phase 2: Archive Fix Scripts**
1. Move all fix scripts to archive
2. Update documentation references
3. Keep only active scripts in root

### **Phase 3: Clean Large Files**
1. Remove obsolete zip files
2. Keep only latest versions
3. Update deployment references

### **Phase 4: Update Documentation**
1. Update all file references
2. Update deployment guides
3. Update README files

---

## ⚠️ **IMPORTANT CONSIDERATIONS**

### **Before Cleanup:**
1. **Backup current state** - Create a backup branch
2. **Test all scripts** - Ensure moved scripts still work
3. **Update hardcoded paths** - Check for absolute paths
4. **Update documentation** - Fix all file references

### **After Cleanup:**
1. **Verify functionality** - Test all moved scripts
2. **Update deployment guides** - Fix path references
3. **Update team documentation** - Inform team of new structure
4. **Commit changes** - Create comprehensive commit

---

## 📝 **CLEANUP CHECKLIST**

### **✅ Pre-Cleanup:**
- [ ] Create backup branch
- [ ] Document current file locations
- [ ] Test all scripts functionality
- [ ] Identify hardcoded paths

### **✅ During Cleanup:**
- [ ] Create new directory structure
- [ ] Move files systematically
- [ ] Update file references
- [ ] Test moved scripts

### **✅ Post-Cleanup:**
- [ ] Update documentation
- [ ] Update deployment guides
- [ ] Test full system
- [ ] Commit changes
- [ ] Update team

---

## 🎯 **EXPECTED OUTCOMES**

### **Before Cleanup:**
- 100+ files in root directory
- Scattered test files
- Multiple duplicate scripts
- Inconsistent organization

### **After Cleanup:**
- ~20 essential files in root
- Organized test structure
- Archived fix scripts
- Clear documentation
- Consistent naming

**This cleanup will significantly improve project maintainability and team productivity.**

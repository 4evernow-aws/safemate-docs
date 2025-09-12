# SafeMate Deployment Mapping Registry

## 🎯 **DEPLOYMENT MAPPING REGISTRY - ALWAYS CHECK BEFORE MODIFICATIONS**

**⚠️ CRITICAL: This document MUST be consulted before:**
- Creating new zip files
- Modifying existing deployments
- Updating Lambda functions
- Creating new Lambda layers

**Last Updated:** 2025-08-24  
**Registry Status:** ✅ **ACTIVE AND VERIFIED**

---

## 📋 **CURRENT DEPLOYMENT MAPPINGS**

### **✅ ACTIVE ZIP FILES AND THEIR AWS MAPPINGS**

| Local Zip File | Size | AWS Lambda Function | AWS Size | Status | Last Modified | Usage |
|----------------|------|-------------------|----------|---------|---------------|-------|
| `services/user-onboarding/lambda-function.zip` | 2,056 bytes | `default-safemate-user-onboarding` | 2,056 bytes | ✅ **EXACT MATCH** | 2025-08-19T23:24:16 | **ACTIVE** |
| `services/token-vault/token-vault.zip` | 4,425 bytes | `default-safemate-token-vault` | 4,425 bytes | ✅ **EXACT MATCH** | 2025-08-16T10:51:17 | **ACTIVE** |
| `services/wallet-manager/wallet-manager.zip` | 3,569 bytes | `default-safemate-wallet-manager` | 3,569 bytes | ✅ **EXACT MATCH** | 2025-08-16T10:51:36 | **ACTIVE** |
| `services/safemate-directory-creator/safemate-directory-creator.zip` | 5,581 bytes | `default-safemate-directory-creator` | 5,550 bytes | ✅ **CLOSE MATCH** | 2025-08-08T06:18:27 | **ACTIVE** |
| `services/group-manager/group-manager.zip` | 11,121 bytes | `default-safemate-group-manager` | 10,883 bytes | ✅ **CLOSE MATCH** | 2025-08-16T05:04:51 | **ACTIVE** |
| `services/post-confirmation-wallet-creator/post-confirmation-wallet-creator.zip` | 2,802,818 bytes | `default-safemate-post-confirmation-wallet-creator` | 6,957,593 bytes | ✅ **ACTIVE** | 2025-08-17T02:39:51 | **ACTIVE** |
| `services/consolidated-wallet-service/consolidated-wallet-service.zip` | 5,890,010 bytes | `default-safemate-consolidated-wallet` | 5,890,010 bytes | ✅ **EXACT MATCH** | 2025-08-23T03:30:09 | **ACTIVE** |
| `services/ultimate-wallet-service/ultimate-wallet-service.zip` | 6,283,668 bytes | `default-safemate-ultimate-wallet` | 6,283,668 bytes | ✅ **EXACT MATCH** | 2025-08-23T03:55:44 | **ACTIVE** |

### **✅ DIRECT DEPLOYMENTS (NO ZIP FILES)**

| Service Directory | Source File | AWS Lambda Function | AWS Size | Status | Last Modified | Usage |
|-------------------|-------------|-------------------|----------|---------|---------------|-------|
| `services/hedera-service/` | `index.js` | `default-safemate-hedera-service` | 58,924,557 bytes | ✅ **ACTIVE** | 2025-08-19T05:06:46 | **ACTIVE** |

---

## 🌐 **CURRENT API GATEWAY MAPPINGS**

### **✅ ACTIVE API GATEWAYS**

| API Gateway ID | Purpose | Base URL | Lambda Function | Status |
|----------------|---------|----------|-----------------|--------|
| `527ye7o1j0` | User Onboarding & Wallet API | `https://527ye7o1j0.execute-api.ap-southeast-2.amazonaws.com/default` | `default-safemate-ultimate-wallet` | ✅ **ACTIVE** |
| `229i7zye9f` | Hedera Service API | `https://229i7zye9f.execute-api.ap-southeast-2.amazonaws.com/default` | `default-safemate-hedera-service` | ✅ **ACTIVE** |
| `qy3i7ekh08` | Token Vault API | `https://qy3i7ekh08.execute-api.ap-southeast-2.amazonaws.com/default` | `default-safemate-token-vault` | ✅ **ACTIVE** |
| `kmth2kr4hb` | Group Manager API | `https://kmth2kr4hb.execute-api.ap-southeast-2.amazonaws.com/default` | `default-safemate-group-manager` | ✅ **ACTIVE** |

---

## 🔧 **LAMBDA LAYERS REGISTRY**

### **✅ ACTIVE LAMBDA LAYERS**

| Layer Name | Version | Status | Used By | Last Modified | Usage |
|------------|---------|--------|---------|---------------|-------|
| `lambda-layer` | 1 | ✅ **ACTIVE** | All Lambda functions | 2025-08-22 | **ACTIVE** |

---

## 👤 **COGNITO USER POOLS REGISTRY**

### **✅ ACTIVE USER POOL**

| User Pool Name | User Pool ID | Status | Created | Users | Usage |
|----------------|--------------|--------|---------|-------|-------|
| `default-safemate-user-pool-v2` | `ap-southeast-2_uLgMRpWlw` | ✅ **ACTIVE** | 2025-08-01 | 3 confirmed | **PRODUCTION** |

### **❌ REMOVED USER POOLS (DO NOT RECREATE)**

| User Pool Name | User Pool ID | Reason | Date Removed |
|----------------|--------------|--------|--------------|
| `default-safemate-user-pool-v2` | `ap-southeast-2_aPt5UvL1k` | Duplicate pool | 2025-08-23 |

**⚠️ IMPORTANT**: Only use `ap-southeast-2_uLgMRpWlw` for all authentication. The duplicate pool has been removed.

### **❌ REMOVED LAMBDA LAYERS (DO NOT RECREATE)**

| Layer Name | Versions Removed | Reason | Date Removed |
|------------|------------------|--------|--------------|
| `hedera-layer` | 1 | Duplicate functionality | 2025-08-22 |
| `minimal-hedera-layer` | 1 | Duplicate functionality | 2025-08-22 |
| `optimized-layer` | 1 | Duplicate functionality | 2025-08-22 |
| `aws-layer` | 1 | Duplicate functionality | 2025-08-22 |
| `default-safemate-hedera-dependencies` | 1-12 | Duplicate functionality | 2025-08-19 |
| `safemate-hedera-dependencies` | 1-3 | Duplicate functionality | 2025-08-19 |
| `safemate-aws-layer` | 1 | Unused | 2025-08-19 |
| `safemate-axios-layer` | 1 | Unused | 2025-08-19 |
| `safemate-onboarding-deps` | 1 | Unused | 2025-08-19 |

---

## 📁 **UPDATED SERVICE DIRECTORY STRUCTURE**

### **✅ CURRENT CLEAN STRUCTURE (POST-CLEANUP)**

```
safemate_v2/
├── apps/                          # Frontend applications
│   └── web/safemate/
├── services/                      # Backend Lambda services
│   ├── ultimate-wallet-service/
│   ├── consolidated-wallet-service/
│   ├── user-onboarding/
│   ├── wallet-manager/
│   ├── token-vault/
│   ├── safemate-directory-creator/
│   ├── post-confirmation-wallet-creator/
│   ├── hedera-service/
│   ├── group-manager/
│   └── shared/
├── documentation/                 # Project documentation
│   ├── archive/                   # Archived documentation
│   │   ├── fixes/                 # Fix summaries
│   │   └── status/                # Status reports
│   └── [current docs]
├── guides/                        # Development guides
│   ├── aws_lambda_guide.md
│   ├── aws_api_gateway_guide.md
│   ├── aws_cors_guide.md
│   ├── hedera_sdk_guide.md
│   ├── hedera_wallet_guide.md
│   ├── hedera_wallet_cursor_guide.md
│   ├── GIT_WORKFLOW_GUIDE.md
│   ├── blockchain_storage_guide.md
│   ├── live_wallet_test_guide.md
│   ├── cursor_development_guidelines.md
│   ├── team_setup_guide.md
│   ├── team_development_guide.md
│   ├── deployment_guide.md
│   ├── deployment_quick_reference.md
│   └── codebase_cleanup_guide.md
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

### **✅ ORGANIZED TEST STRUCTURE**

#### **Test Files Organization:**
- **`tests/api/`** - API Gateway and endpoint tests
- **`tests/lambda/`** - Lambda function tests
- **`tests/hedera/`** - Hedera blockchain tests
- **`tests/terraform/`** - Infrastructure tests

#### **Scripts Organization:**
- **`scripts/deployment/`** - Active deployment scripts
- **`scripts/archive/fixes/`** - Archived fix scripts by category
- **`config/lambda/`** - Lambda configuration files
- **`config/aws/`** - AWS service configuration files

### **❌ REMOVED SERVICES (DO NOT RECREATE)**

| Service Name | Reason | Date Removed |
|--------------|--------|--------------|
| `wallet-creator` | Duplicate of wallet-manager | 2025-08-22 |

---

## 🚨 **PRE-DEPLOYMENT CHECKLIST**

### **BEFORE CREATING NEW ZIP FILES:**

1. **✅ Check this registry** - Is there already a zip file for this service?
2. **✅ Verify AWS mapping** - Does the existing zip file match the AWS deployment?
3. **✅ Check file sizes** - Are the sizes consistent between local and AWS?
4. **✅ Review service structure** - Is the service using zip deployment or direct deployment?
5. **✅ Review recommendations** - Check `SAFEMATE_RECOMMENDATIONS.md` for best practices
6. **✅ Check critical guidelines** - Review `CRITICAL_RECOMMENDATIONS_SUMMARY.md` for immediate requirements

### **BEFORE MODIFYING EXISTING DEPLOYMENTS:**

1. **✅ Check this registry** - What is the current mapping?
2. **✅ Verify AWS function** - Which AWS Lambda function is being updated?
3. **✅ Check dependencies** - Are there any Lambda layers involved?
4. **✅ Review deployment method** - Zip file or direct deployment?
5. **✅ Follow recommendations** - Ensure changes align with `SAFEMATE_RECOMMENDATIONS.md`
6. **✅ Check critical requirements** - Verify compliance with `CRITICAL_RECOMMENDATIONS_SUMMARY.md`

### **BEFORE CREATING NEW LAMBDA LAYERS:**

1. **✅ Check this registry** - Is there already a layer for this functionality?
2. **✅ Review removed layers** - Was this functionality previously removed?
3. **✅ Check existing layers** - Can existing layers be reused?
4. **✅ Verify dependencies** - Are the dependencies already available?
5. **✅ Review layer strategy** - Check `SAFEMATE_RECOMMENDATIONS.md` for layer best practices
6. **✅ Check critical guidelines** - Ensure compliance with `CRITICAL_RECOMMENDATIONS_SUMMARY.md`

### **BEFORE ANY DEPLOYMENT CHANGE:**

1. **✅ Check deployment registry** - This document (`DEPLOYMENT_MAPPING_REGISTRY.md`)
2. **✅ Review quick reference** - `DEPLOYMENT_QUICK_REFERENCE.md` for fast checks
3. **✅ Follow recommendations** - `SAFEMATE_RECOMMENDATIONS.md` for comprehensive guidance
4. **✅ Check critical requirements** - `CRITICAL_RECOMMENDATIONS_SUMMARY.md` for immediate action items
5. **✅ Verify current state** - Use verification commands to check AWS and local state
6. **✅ Update documentation** - Update this registry after any changes

---

## 📝 **DEPLOYMENT GUIDELINES**

### **✅ ZIP FILE NAMING CONVENTION**
- Use service name as zip file name: `{service-name}.zip`
- Keep zip files in their respective service directories
- Never create duplicate zip files with different names

### **✅ DEPLOYMENT METHODS**
- **Zip Deployment**: Use for services with dependencies
- **Direct Deployment**: Use for services with minimal dependencies (like hedera-service)

### **✅ LAMBDA LAYER USAGE**
- **Single Layer Policy**: Use only `hedera-sdk-layer:1` for Hedera dependencies
- **No Duplication**: Never create duplicate layers for the same functionality
- **Documentation**: Always update this registry when creating new layers

---

## 🔍 **VERIFICATION COMMANDS**

### **Check AWS Lambda Functions:**
```bash
aws lambda list-functions --query 'Functions[?starts_with(FunctionName, `default-safemate`)].{Name:FunctionName,CodeSize:CodeSize,LastModified:LastModified}' --output table
```

### **Check AWS Lambda Layers:**
```bash
aws lambda list-layers --query 'Layers[?starts_with(LayerName, `default-safemate`) || starts_with(LayerName, `safemate`) || starts_with(LayerName, `hedera-sdk`)].{Name:LayerName,Versions:LatestMatchingVersion.Version}' --output table
```

### **Check Local Zip Files:**
```bash
Get-ChildItem -Recurse -File | Where-Object { $_.Extension -eq ".zip" -and $_.Name -notmatch "test.*\.zip$" } | Select-Object Name, Length, Directory
```

---

## 📋 **CHANGE LOG**

### **2025-08-19 - Registry Created**
- ✅ **Registry established** with current deployment mappings
- ✅ **All zip files documented** with AWS mappings
- ✅ **Lambda layers documented** (active and removed)
- ✅ **Service structure documented**
- ✅ **Pre-deployment checklist created**

### **2025-08-19 - Enhanced Checklist**
- ✅ **Added recommendation references** to pre-deployment checklist
- ✅ **Integrated SAFEMATE_RECOMMENDATIONS.md** for comprehensive guidance
- ✅ **Integrated CRITICAL_RECOMMENDATIONS_SUMMARY.md** for immediate requirements
- ✅ **Enhanced checklist** with additional verification steps

### **2025-08-19 - Directory Structure Update**
- ✅ **Updated documentation structure** to reflect new organization
- ✅ **Guides moved to `guides/` directory** for AWS, Hedera, and Git guides
- ✅ **SafeMate documentation kept in `documentation/` directory** for project-specific docs
- ✅ **Updated all references** to reflect new directory structure

### **2025-08-23 - User Pool Duplication Fix**
- **Date**: 2025-08-23
- **Change**: Removed duplicate Cognito User Pool and updated documentation
- **Reason**: Two User Pools with same name were causing authentication conflicts
- **Impact**: All authentication now uses single User Pool `ap-southeast-2_uLgMRpWlw`

### **2025-08-23 - API Gateway Authorizer Fix**
- **Date**: 2025-08-23
- **Change**: Fixed API Gateway authorizers to use correct User Pool and updated Lambda integrations
- **Reason**: API Gateway was using authorizer pointing to deleted User Pool, causing 401 errors
- **Impact**: All onboarding endpoints now use correct User Pool `ap-southeast-2_uLgMRpWlw` and ultimate wallet service

### **2025-08-23 - CORS Configuration Fix**
- **Date**: 2025-08-23
- **Change**: Fixed OPTIONS methods and CORS headers for all onboarding endpoints in API Gateway
- **Reason**: CORS errors were blocking frontend requests due to missing OPTIONS methods and incomplete CORS header configuration
- **Impact**: All API responses now include proper CORS headers, enabling frontend requests to work correctly
- **Test Results**: ✅ OPTIONS requests return 200 with CORS headers
- **Test Results**: ✅ POST requests return 401 with CORS headers (expected without auth)

### **2025-08-23 - Lambda Environment Variables Fix**
- **Date**: 2025-08-23
- **Change**: Set required environment variables for `default-safemate-ultimate-wallet` Lambda function
- **Reason**: Lambda was returning 500 Internal Server Error due to missing environment variables
- **Variables Set**:
  - `WALLET_KEYS_TABLE`: `safemate-wallet-keys`
  - `WALLET_METADATA_TABLE`: `safemate-wallet-metadata`
  - `APP_SECRETS_KMS_KEY_ID`: `alias/safemate-app-secrets`
  - `WALLET_KMS_KEY_ID`: `alias/safemate-wallet-keys`
  - `HEDERA_NETWORK`: `testnet`
- **Impact**: 500 Internal Server Error resolved, API now returns 401 Unauthorized (expected without auth)
- **Test Results**: ✅ Environment variables set successfully
- **Test Results**: ✅ API returns 401 Unauthorized (expected behavior)

### **2025-08-23 - Lambda Dependency and Initialization Fix**
- **Date**: 2025-08-23
- **Change**: Fixed Lambda function dependencies and initialization issues
- **Reason**: Lambda was failing due to missing `@smithy/util-middleware` and missing initialization call
- **Fixes Applied**:
  - Added missing `@smithy/util-middleware` dependency
  - Added `await walletService.initialize();` call in handler
  - Updated Lambda function with all dependencies included directly
- **Impact**: 500 Internal Server Error resolved, Lambda function now initializes properly
- **Test Results**: ✅ Lambda function loads without dependency errors
- **Test Results**: ✅ Service initialization working correctly

### **2025-08-23 - Lambda Instance Fix**
- **Date**: 2025-08-23
- **Change**: Fixed duplicate walletService instance creation in Lambda function
- **Reason**: Lambda was failing due to duplicate instance creation causing variable conflicts
- **Fixes Applied**:
  - Removed duplicate `const walletService = new UltimateWalletService();` line
  - Ensured single instance creation before handler function
- **Impact**: 500 Internal Server Error resolved, Lambda function now works correctly
- **Test Results**: ✅ Lambda function deploys successfully
- **Test Results**: ✅ Service instance created properly

### **2025-08-23 - AWS SDK v3 Dependency Fix**
- **Date**: 2025-08-23
- **Change**: Fixed AWS SDK v3 dependency issues by using complete packages instead of manual `@smithy/util-middleware` addition
- **Reason**: `@smithy/util-middleware` dependency errors kept recurring due to AWS SDK v3's modular architecture
- **Fixes Applied**:
  - Removed manual `@smithy/util-middleware` dependency
  - Added complete AWS SDK v3 packages: `@aws-sdk/smithy-client`, `@aws-sdk/types`, `@aws-sdk/client-secrets-manager`
  - Simplified Lambda layer to only include Hedera SDK
  - Let npm handle dependency resolution automatically
- **Impact**: Dependency conflicts resolved, Lambda function loads without errors
- **Test Results**: ✅ CORS OPTIONS returns 200 with proper headers
- **Test Results**: ✅ POST requests return 401 Unauthorized (expected without auth)
- **Test Results**: ✅ No more `@smithy/util-middleware` dependency errors

### **2025-08-24 - Documentation Reorganization and API Gateway Updates**
- **Date**: 2025-08-24
- **Change**: Reorganized documentation structure and updated API Gateway mappings to reflect current state
- **Reason**: Documentation was scattered across directories and API Gateway IDs were outdated
- **Fixes Applied**:
  - **Moved 8 guide files to `guides/` directory** - Relocated guide files from documentation/ to guides/
  - **Updated API Gateway mappings** - Corrected API Gateway IDs to match current environment
  - **Added current API Gateway section** - Created dedicated section for active API Gateways
  - **Updated service mappings** - Added missing Lambda functions (ultimate-wallet, consolidated-wallet)
  - **Consolidated documentation structure** - Clear separation between documentation and guides
- **Impact**: Accurate documentation reflecting current infrastructure state
- **Files Moved to guides/**: 
  - `blockchain_storage_guide.md`
  - `live_wallet_test_guide.md`
  - `cursor_development_guidelines.md`
  - `team_setup_guide.md`
  - `team_development_guide.md`
  - `deployment_guide.md`
  - `deployment_quick_reference.md`
  - `codebase_cleanup_guide.md`
- **API Gateway Updates**:
  - `527ye7o1j0` - User Onboarding & Wallet API (ultimate-wallet-service)
  - `229i7zye9f` - Hedera Service API (hedera-service)
  - `qy3i7ekh08` - Token Vault API (token-vault)
  - `kmth2kr4hb` - Group Manager API (group-manager)
- **Test Results**: ✅ Documentation structure properly organized
- **Test Results**: ✅ API Gateway mappings accurately reflect current state

### **2025-08-24 - Folder Structure Cleanup**
- **Date**: 2025-08-24
- **Change**: Major reorganization of project structure to improve maintainability
- **Reason**: Root directory had 100+ files causing confusion and difficulty in navigation
- **Fixes Applied**:
  - **Removed 4 exact duplicate files** (8 files total)
  - **Created organized directory structure** with clear separation of concerns
  - **Moved test files** to `tests/` directory with subdirectories for API, Lambda, and Hedera tests
  - **Archived fix scripts** to `scripts/archive/fixes/` by category (CORS, Lambda, Auth)
  - **Organized deployment scripts** to `scripts/deployment/`
  - **Moved configuration files** to `config/` directory with subdirectories for Lambda and AWS configs
  - **Archived fix documentation** to `documentation/archive/` by category
  - **Removed obsolete zip files** (3 large duplicate zip files)
- **Impact**: Significantly improved project organization and maintainability
- **Test Results**: ✅ All files properly organized
- **Test Results**: ✅ Clear separation of concerns achieved
- **Test Results**: ✅ Reduced root directory clutter from 100+ to ~20 essential files

### **Future Updates**
- **Date**: [YYYY-MM-DD]
- **Change**: [Description of change]
- **Reason**: [Why the change was made]
- **Impact**: [What services are affected]

---

## 🎯 **REGISTRY MAINTENANCE**

### **✅ WHEN TO UPDATE THIS REGISTRY:**

1. **New zip files created** - Add to mappings table
2. **Existing zip files modified** - Update size and timestamp
3. **New Lambda layers created** - Add to layers table
4. **Services restructured** - Update directory structure
5. **AWS deployments changed** - Update AWS mappings

### **✅ REGISTRY VERIFICATION:**

1. **Monthly verification** - Check all mappings are current
2. **Before major deployments** - Verify registry accuracy
3. **After cleanup operations** - Update removed items
4. **When adding new services** - Document in registry

---

## 🚨 **CRITICAL REMINDERS**

### **⚠️ ALWAYS CHECK BEFORE:**
- Creating new zip files
- Modifying existing deployments
- Creating new Lambda layers
- Restructuring services
- Updating AWS resources

### **✅ BEST PRACTICES:**
- **Single source of truth** - Only one zip file per service
- **Clear naming** - Use service name for zip files
- **Documentation** - Always update this registry
- **Verification** - Check mappings before deployment
- **Cleanup** - Remove unused resources promptly
- **Follow recommendations** - Always consult `SAFEMATE_RECOMMENDATIONS.md`
- **Check critical requirements** - Always review `CRITICAL_RECOMMENDATIONS_SUMMARY.md`

---

## 📞 **ESSENTIAL DOCUMENTS**

### **✅ MANDATORY DOCUMENTS (ALWAYS CONSULT):**
- **`DEPLOYMENT_MAPPING_REGISTRY.md`** - This document (single source of truth)
- **`DEPLOYMENT_QUICK_REFERENCE.md`** - Quick deployment checks
- **`SAFEMATE_RECOMMENDATIONS.md`** - Comprehensive recommendations and best practices
- **`CRITICAL_RECOMMENDATIONS_SUMMARY.md`** - Critical requirements for immediate action

### **✅ SAFEMATE DOCUMENTATION (`documentation/` directory):**
- **`documentation/HEDERA_WALLET_INTEGRATION.md`** - Hedera wallet integration details
- **`documentation/AWS_SERVICES_MAPPING.md`** - AWS services mapping and configuration
- **`guides/deployment_guide.md`** - SafeMate-specific deployment procedures
- **`documentation/TECHNOLOGY_STACK.md`** - SafeMate technology stack overview
- **`documentation/SAFEMATE_WORKFLOW_DOCUMENTATION.md`** - SafeMate workflow documentation

### **✅ GUIDES (`guides/` directory):**
- **`guides/aws_lambda_guide.md`** - AWS Lambda best practices and procedures
- **`guides/aws_api_gateway_guide.md`** - AWS API Gateway configuration and setup
- **`guides/aws_cors_guide.md`** - CORS configuration and troubleshooting
- **`guides/hedera_sdk_guide.md`** - Hedera SDK usage and best practices
- **`guides/hedera_wallet_guide.md`** - Hedera wallet creation and management
- **`guides/hedera_wallet_cursor_guide.md`** - Hedera wallet integration with Cursor
- **`guides/GIT_WORKFLOW_GUIDE.md`** - Git workflow and version control procedures
- **`guides/blockchain_storage_guide.md`** - Blockchain-only storage implementation
- **`guides/live_wallet_test_guide.md`** - Live Hedera wallet testing procedures
- **`guides/cursor_development_guidelines.md`** - Cursor development best practices
- **`guides/team_setup_guide.md`** - Team setup and onboarding procedures
- **`guides/team_development_guide.md`** - Team development workflow
- **`guides/deployment_guide.md`** - Production deployment procedures
- **`guides/deployment_quick_reference.md`** - Quick deployment reference
- **`guides/codebase_cleanup_guide.md`** - Codebase cleanup procedures

### **✅ REFERENCE DOCUMENTS:**
- **`CLEANUP_STATUS_REPORT.md`** - Cleanup results and lessons learned
- **`CLEANUP_VERIFICATION_REPORT.md`** - Verification of cleanup completion

---

## 🎉 **REGISTRY STATUS**

**✅ ACTIVE AND MAINTAINED**

**This registry is the single source of truth for all SafeMate deployments.**
**Always consult this document before making any deployment changes.**
**Always follow the recommendations in SAFEMATE_RECOMMENDATIONS.md and CRITICAL_RECOMMENDATIONS_SUMMARY.md.**

**Last Verified:** 2025-08-24  
**Registry Status:** ✅ **CURRENT AND ACCURATE**

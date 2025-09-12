# 🚀 SafeMate Team Development Guide

## 📋 **IMPORTANT: Always Use the New Modular System**

This guide ensures all team members work with the **new modular dashboard system** and stay synchronized with the latest codebase.

---

## 🎯 **Quick Start for Team Members**

### 1. **Initial Setup (First Time Only)**
```bash
# Clone the repository
git clone <repository-url>
cd safemate_v2

# Switch to the development branch
git checkout team/wallet-widgets

# Install dependencies
cd apps/web/safemate
npm install

# Start development server
npm run dev
```

### 2. **Daily Development Workflow**
```bash
# Always start your day with these commands:
cd D:\cursor_projects\safemate_v2\apps\web\safemate

# Pull latest changes
git pull origin team/wallet-widgets

# Install any new dependencies
npm install

# Start development server
npm run dev
```

---

## 🏗️ **New Modular System Architecture**

### **Core Components**
- **Dashboard**: `/app/dashboard` - Uses the new modular widget system
- **Widget System**: Located in `src/dashboard/` and `src/widgets/`
- **Widget Registry**: Manages widget registration and discovery
- **Widget Error Boundaries**: Handles widget failures gracefully

### **Updated Project Structure** (Post-Cleanup)
The codebase has been optimized for better maintainability:

```
safemate_v2/
├── apps/web/safemate/          # Frontend application
│   ├── src/
│   │   ├── components/         # React components
│   │   ├── services/           # Frontend services
│   │   ├── widgets/            # Modular dashboard widgets
│   │   └── utils/              # Frontend utilities
│   └── public/                 # Static assets
├── services/                   # Backend Lambda functions
│   ├── hedera-service/         # Main blockchain service
│   ├── user-onboarding/        # User onboarding
│   ├── wallet-manager/         # Wallet management
│   ├── token-vault/            # Token vault service
│   ├── safemate-directory-creator/ # Directory creation service
│   ├── group-manager/          # Group management service
│   ├── post-confirmation-wallet-creator/ # Post-confirmation trigger
│   └── shared/                 # Shared utilities
├── utils/                      # Shared utility modules
├── tests/                      # Organized test files
├── lambda-layer/               # Main Lambda layer (Hedera SDK + AWS SDK)
└── terraform/                  # Infrastructure as Code
```

**Recent Improvements**:
- ✅ Eliminated duplicate files and functions
- ✅ Consolidated CORS configuration
- ✅ Organized test files into logical structure
- ✅ Created shared utility modules
- ✅ Reduced layer complexity (single active layer)
- ✅ Removed nested duplicate directories
- ✅ Streamlined service architecture

### **Key Files for Team Members**
```
src/dashboard/
├── core/
│   ├── DashboardProvider.tsx    # Main dashboard context
│   ├── WidgetRegistry.tsx       # Widget registration system
│   ├── WidgetRegistration.tsx   # Widget registration component
│   ├── WidgetErrorBoundary.tsx  # Error handling
│   ├── WidgetDevTools.tsx       # Development tools
│   └── types.ts                 # Shared type definitions
├── layouts/
│   └── DashboardGrid.tsx        # Grid layout system
├── routing/
│   └── DashboardRoutes.tsx      # Dashboard routing
└── Dashboard.tsx                # Main dashboard component

src/widgets/
├── shared/
│   └── BaseWidget.tsx           # Base widget component
├── wallet/
│   ├── WalletOverviewWidget.tsx # Wallet overview widget
│   ├── WalletSendWidget.tsx     # Send funds widget
│   ├── WalletReceiveWidget.tsx  # Receive funds widget
│   └── WalletDetailsWidget.tsx  # Wallet details widget
├── stats/
│   └── StatsOverviewWidget.tsx  # Statistics widget
├── actions/
│   └── QuickActionsWidget.tsx   # Quick actions widget
├── files/
│   └── FilesOverviewWidget.tsx  # Files overview widget
└── dashboard/
    ├── DashboardStatsWidget.tsx # Dashboard statistics
    ├── GroupInvitationsWidget.tsx # Group invitations
    ├── PlatformStatusWidget.tsx # Platform status
    ├── RecentActivityWidget.tsx # Recent activity
    └── AccountStatusWidget.tsx  # Account status
```

---

## 🧭 **Current Navigation Structure**

The main navigation includes these sections:

### **Primary Navigation**
- **Dashboard** (`/app/dashboard`) - **NEW**: Modular widget system
- **My Files** (`/app/files`) - File management interface
- **Upload** (`/app/upload`) - File upload functionality
- **Wallet** (`/app/wallet`) - Blockchain operations
- **Groups** (`/app/shared`) - Group collaboration features

### **Secondary Navigation**
- **Gallery** (`/app/gallery`) - **Coming Soon**: Image and media management
- **Monetise** (`/app/monetise`) - **Coming Soon**: Revenue generation features
- **How to** (`/app/how-to`) - User guide and tutorials
- **Help** (`/app/help`) - FAQ and support documentation
- **Profile** (`/app/profile`) - User settings and preferences

### **Development Notes**
- **Gallery** and **Monetise** are placeholder pages for future development
- **How to** and **Help** provide user guidance and support
- All navigation items are accessible from the sidebar in `AppShell.tsx`

---

## 🔧 **Development Guidelines**

### **Creating New Widgets**
1. **Create widget component** in `src/widgets/[category]/`
2. **Extend BaseWidget** for consistent styling
3. **Register widget** in `src/widgets/index.ts`
4. **Add to AVAILABLE_WIDGETS** array in `src/dashboard/Dashboard.tsx`

### **Example Widget Structure**
```typescript
// src/widgets/example/ExampleWidget.tsx
import React from 'react';
import { BaseWidget } from '../shared/BaseWidget';
import type { WidgetProps } from '../../dashboard/core/types';

const ExampleWidgetComponent: React.FC<WidgetProps> = ({ widgetId, accountType }) => {
  return (
    <BaseWidget
      title="Example Widget"
      widgetId={widgetId}
      accountType={accountType}
    >
      {/* Widget content */}
    </BaseWidget>
  );
};

export const ExampleWidget = {
  id: 'example-widget',
  name: 'Example Widget',
  component: ExampleWidgetComponent,
  category: 'analytics' as const,
  permissions: ['personal', 'family', 'business'] as const,
  gridSize: { cols: 2, rows: 2 },
  priority: 1,
};
```

### **Widget Registration Process**
1. **Create the widget component** following the pattern above
2. **Export the widget object** with proper configuration
3. **Import in `src/widgets/index.ts`** to register with the system
4. **Add to `AVAILABLE_WIDGETS`** in `
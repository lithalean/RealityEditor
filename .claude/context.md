# Claude.ai Development Context
*AI Collaboration State for [PROJECT_NAME]*

> **Location**: `/.claude/context.md` - Main AI collaboration context file

## 🎯 Project DNA
**Type**: Darwin ARM64 [PROJECT_TYPE] Application  
**Architecture**: SwiftUI + @Observable + Document-based  
**Platforms**: iPhone/iPad/Mac Catalyst  
**Design Language**: WWDC25 iPadOS principles  
**Current Phase**: [CURRENT_PHASE]  
**Build Status**: [BUILD_STATUS]  

## 🧠 Core Architecture Decisions Made
```
DECISION_LOG:
[DATE] - Chose @Observable over ObservableObject for iOS 17+ performance
[DATE] - Document-based architecture for native file handling  
[DATE] - JSON storage for git-friendly version control
[DATE] - Mac Catalyst over separate macOS app for code reuse
[DATE] - Canvas API for custom drawing performance
[DATE] - Material Design System following WWDC25 principles
```

## 🏗️ Technical Stack State
```swift
// Current Architecture Pattern
@Observable class [MAIN_MODEL] {
	// State management approach
}

// Document Pattern
struct [PROJECT]Document: ReferenceFileDocument {
	// File handling pattern
}

// View Architecture
ContentView (Adaptive Container)
├── Sidebar/TabBar (Platform Adaptive)
├── [MAIN_VIEW] (Primary Interface)
├── [SECONDARY_VIEW] (Support Interface)
└── DocumentBrowser (File Management)
```

## 🎨 Design System Implemented
- **Materials**: `.ultraThinMaterial` for floating elements
- **Adaptivity**: Sidebar (landscape) + TabBar (portrait)  
- **Spacing**: 16px standard, 8px compact, 20px generous
- **Colors**: System accent + semantic colors
- **Typography**: System fonts with dynamic type
- **Animations**: 0.3s easeInOut standard timing

## 📊 Current Implementation Matrix
```
FEATURE_STATUS_MATRIX:
✅ COMPLETE     🚧 IN_PROGRESS     📋 PLANNED     ❌ BLOCKED

Core Foundation:
✅ SwiftUI Architecture      ✅ Document System       ✅ Cross-Platform
✅ [CORE_FEATURE_1]         ✅ [CORE_FEATURE_2]      🚧 [CORE_FEATURE_3]

Visual Experience:  
✅ Material Design          ✅ Adaptive Layouts      🚧 Advanced Animations
✅ Hover States            📋 Dark Mode            📋 Accessibility

Advanced Features:
🚧 [ADVANCED_FEATURE_1]    📋 [ADVANCED_FEATURE_2]  📋 [ADVANCED_FEATURE_3]
📋 Undo/Redo System       📋 Export System         📋 Search/Filter
```

## 🔧 Known Technical Debt
```
HIGH_PRIORITY:
- [TECHNICAL_DEBT_ITEM_1]: [DESCRIPTION_AND_IMPACT]
- [TECHNICAL_DEBT_ITEM_2]: [DESCRIPTION_AND_IMPACT]

MEDIUM_PRIORITY:  
- [TECHNICAL_DEBT_ITEM_3]: [DESCRIPTION_AND_IMPACT]
- [TECHNICAL_DEBT_ITEM_4]: [DESCRIPTION_AND_IMPACT]

PERFORMANCE_OPTIMIZATION:
- Large dataset handling optimization needed
- Memory management for complex operations
- Animation performance on older devices
```

## 🎯 Next Development Priorities
```
IMMEDIATE (This Week):
1. [IMMEDIATE_TASK_1] - [COMPLEXITY: LOW/MED/HIGH]
2. [IMMEDIATE_TASK_2] - [COMPLEXITY: LOW/MED/HIGH]
3. [IMMEDIATE_TASK_3] - [COMPLEXITY: LOW/MED/HIGH]

SHORT_TERM (This Month):
1. [SHORT_TERM_TASK_1] - [DESCRIPTION]
2. [SHORT_TERM_TASK_2] - [DESCRIPTION]
3. [SHORT_TERM_TASK_3] - [DESCRIPTION]

ARCHITECTURAL_DECISIONS_NEEDED:
- [DECISION_NEEDED_1]: [OPTIONS_AND_TRADEOFFS]
- [DECISION_NEEDED_2]: [OPTIONS_AND_TRADEOFFS]
```

## 🐛 Bug Tracking & Issues
```
CRITICAL:
- [BUG_DESCRIPTION] | [REPRODUCTION_STEPS] | [IMPACT]

HIGH:
- [BUG_DESCRIPTION] | [REPRODUCTION_STEPS] | [IMPACT]

MEDIUM:
- [BUG_DESCRIPTION] | [REPRODUCTION_STEPS] | [IMPACT]

ENHANCEMENT_REQUESTS:
- [ENHANCEMENT_1]: [USER_BENEFIT]
- [ENHANCEMENT_2]: [USER_BENEFIT]
```

## 🧪 Testing Strategy State
```
UNIT_TESTS:
- Model layer: [COVERAGE_PERCENTAGE]%
- Service layer: [COVERAGE_PERCENTAGE]%
- Utility functions: [COVERAGE_PERCENTAGE]%

UI_TESTS:
- Core user flows: [IMPLEMENTED/PLANNED]
- Platform-specific flows: [IMPLEMENTED/PLANNED]
- Accessibility testing: [IMPLEMENTED/PLANNED]

PERFORMANCE_TESTS:
- Large dataset handling: [STATUS]
- Memory usage profiling: [STATUS]  
- Battery usage analysis: [STATUS]
```

## 🚀 Release Planning Context
```
CURRENT_VERSION: [VERSION_NUMBER]
TARGET_VERSION: [TARGET_VERSION]
RELEASE_TIMELINE: [TIMELINE]

FEATURE_COMPLETE_CHECKLIST:
□ All Phase [X] features implemented
□ Cross-platform testing complete
□ Performance optimization complete
□ Documentation updated
□ App Store assets prepared

KNOWN_RISKS:
- [RISK_1]: [MITIGATION_STRATEGY]
- [RISK_2]: [MITIGATION_STRATEGY]
```

## 📚 Key Patterns & Conventions Established
```swift
// File Organization Pattern
[PROJECT_NAME]/
├── Models/           // @Observable classes, data structures
├── Views/            // SwiftUI views, organized by feature
├── Services/         // Business logic, API layers
├── Extensions/       // Swift extensions, utilities
└── Resources/        // Assets, JSON files, etc.

// Naming Conventions
- Views: [Feature]View.swift
- Models: [Entity].swift  
- Services: [Feature]Service.swift
- Extensions: [Type]+[Feature].swift

// State Management Pattern
@StateObject for view-owned state
@Environment for dependency injection
@Observable for shared app state
```

## 🔄 AI Collaboration History
```
LAST_SESSION_FOCUS: [WHAT_WE_WORKED_ON_LAST]
DECISIONS_MADE: [KEY_DECISIONS_FROM_LAST_SESSION]
CODE_GENERATED: [WHAT_CODE_WAS_CREATED/MODIFIED]
NEXT_SESSION_PREP: [WHAT_TO_FOCUS_ON_NEXT]

RECURRING_AI_ASSISTANCE_AREAS:
- Architecture decisions and SwiftUI best practices
- Cross-platform compatibility problem solving  
- Performance optimization strategies
- WWDC25 design principle implementation
- Code review and refactoring suggestions
```

## 🎨 Design Philosophy & Constraints
```
DESIGN_PRINCIPLES:
- Native platform feeling over custom UI
- Progressive disclosure over feature cramming
- Adaptive design over fixed layouts
- Performance over visual complexity
- Accessibility as first-class consideration

TECHNICAL_CONSTRAINTS:
- iOS 18+ minimum for @Observable
- Darwin ARM64 optimization priority
- Mac Catalyst limitations awareness
- SwiftUI-only, no UIKit mixing
- Document-based architecture requirements

USER_EXPERIENCE_PRIORITIES:
1. Fast, responsive interaction
2. Intuitive cross-platform consistency  
3. Professional, clean aesthetic
4. Reliable data persistence
5. Seamless platform-specific behaviors
```

---
*Last Updated: [DATE] | Claude.ai Session: [SESSION_ID]*
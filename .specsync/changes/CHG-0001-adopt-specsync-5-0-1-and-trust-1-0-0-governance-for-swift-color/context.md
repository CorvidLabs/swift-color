---
change: CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-color
artifact: context
---

# Context

Swift Color has nine implementation files / 1,730 LOC and 351 tests in 51 suites. The original governance draft used advisory coverage with no canonical contract. This migration does not alter product semantics, but it now records the complete existing numeric, textual, accessibility, color-space, manipulation, palette, and protocol contract at 100% coverage before composing Trust 1.0.0.

Linux and macOS build/test workflows remain blocking. The push-only DocC Pages workflow remains independent and Trust does not publish documentation or a release.

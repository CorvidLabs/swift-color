---
change: CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-color
artifact: testing
---

# Testing

Run `specsync check --strict --force` at threshold 0, `specsync agents status`, `fledge trust doctor`, and `fledge lanes run verify`. The blocking lane must build the package and pass all 351 tests. Existing Linux and macOS jobs remain independent platform evidence.

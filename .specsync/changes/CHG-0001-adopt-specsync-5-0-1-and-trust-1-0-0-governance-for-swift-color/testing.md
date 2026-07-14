---
change: CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-color
artifact: testing
---

# Testing

- Run released `specsync check --strict --require-coverage 100 --force` and require every parsed export plus 1,730/1,730 LOC.
- Require Claude, Cursor, Codex, and Gemini to report installed.
- Run `fledge lanes run verify`; require the Swift build and all 351 tests in 51 suites.
- Run `fledge trust doctor` and `fledge trust verify` after accepted portable evidence.
- Review the final diff for product changes, incomplete templates, secrets, duplicated gates, and altered release/docs behavior.
- Require exact-head Ubuntu, macOS, Trust, and CodeQL checks before merge.

---
name: test-cases
description: >
  Turns a GitHub issue into a markdown test table with columns "Testcase", "Smoke Test",
  "Feature Test" and "Release Test".
  Use this skill whenever a user provides a GitHub issue ID or link and wants test cases,
  a test table, a testing checklist, a QA table or an acceptance criteria table — e.g.
  "make test cases for #1234", "build a test table for this issue", "Testfälle für Issue X".
  The skill fetches the issue and its linked PRs via the GitHub MCP and derives the rows from
  them. Indentation in the issue's requirements is preserved as hierarchical test cases.
---

# GitHub Issue → Test Table

> When a test case needs to quote a UI label, load **`product-source-lookup`** and take
> the exact string from `~/snapaddy-app/src/assets/i18n/en.json` rather than the issue's
> paraphrase. Watch for `{{...}}` interpolation — a label like `"Hand over to {{userName}}?"`
> cannot be asserted as fixed text.

## Goal
Convert the requirements of a GitHub issue into a ready-to-paste markdown table:

```
| Testcase | Smoke Test | Feature Test | Release Test |
|-|-|-|-|
| ... |  |  |  |
```

## Input
The input is a **GitHub issue ID or link** — nothing else is expected. Everything the table
contains is derived from the issue and its linked PRs. If the user gives only an issue number
without a repo, assume the repo this session is working in (`snapADDY/issue-tracking` unless
context says otherwise) and state which repo you used.

Always do the following via the GitHub MCP tools before building the table:

1. **Fetch the issue** (`get_issue`) — extract requirements and acceptance criteria from the issue body; check comments if the body is thin.
2. **Find linked PRs** — search across the whole GitHub org for PRs that mention the issue number anywhere in their body (e.g. `search_pull_requests` with `org:ORGNAME ISSUE_NUMBER`). This catches PRs in any repo that reference the issue.
3. **Inspect the implementation** — for each linked PR, read the changed files (`get_pull_request_files`, `get_file_contents`) and understand what the diff actually changes in behavior: new validations, changed default values, error handling, edge cases. If a PR covers several issues, or is a large rework that mentions this issue among others, first pin down **which commits/hunks actually address this issue** — read the commit messages (`get_pull_request_commits`) and match them against the build/commit referenced in the issue's Testing section. Only that part of the diff is in scope; the rest belongs to the other issues' tables.
4. **Derive additional test cases** only where the diff created a **probable risk that something broke** (see Risk filter). Append these after the issue-derived rows, under a top-level row `Implementation-based checks (from PR [#<number>](<pr_html_url>))` with `-` in all result columns, each check as a `↳` sub-row. If nothing passes the risk filter, omit that whole block — an issue-derived table alone is a valid result, and for a small fix it is the *expected* result.
5. **Deduplicate across issue-derived and implementation-based rows** — implementation sub-rows often test the exact same behavior as a top-level issue row, just with a more specific value (e.g. "file > 1.4 MB is rejected" at top level vs. "file at 1.41 MB is rejected" as an impl sub-row). If a sub-row tests no distinct behavior beyond what a top-level row already covers, drop it. Only keep impl sub-rows that test something genuinely new: a boundary the issue text didn't pin down, a regression in adjacent code, or a named edge case.

If no PR is linked yet, state that briefly above the code fence and build the table from the issue text alone — never invent implementation details.

## Rules

### Testability filter (most important)
Every row must be a **useful test case**: a behavior or outcome a tester can observe and verify in the product. Issues mix requirements with instructions for the developer — filter accordingly:

- **Developer-directed instructions** ("Please build 4 X nodes", "Implement...", "Add endpoint...", "Refactor...") are NOT test cases. Rephrase them into the observable outcome instead (e.g. "Please build 4 Adito nodes — create/find/update/get by id" → "The 4 Adito nodes (create, find, update, get by id) are available in the workflow editor"). If an instruction has no user-observable outcome at all, drop it.
- **Deduplicate across sections**: GitHub issues often restate the same thing in "User Story", "Use Cases" and "Requirements", and implementation-based rows often repeat what the issue already says with a different specificity. Each distinct behavior gets exactly one row — keep the most concrete phrasing, drop the rest. A more specific value (e.g. "1.41 MB") is not a distinct behavior if the general rule ("> 1.4 MB is rejected") already covers it.
- **A sub-row that only re-verifies its parent is a duplicate.** Persistence checks ("the change is still there after reopening"), inverse restatements ("... and the modal does not close as if it had succeeded" under a row that already asserts the error is shown) and depth variations of the same observation add result cells without adding a check. Fold them into the parent's phrasing.

- **Skip non-requirement sections** of issue bodies: user-story preamble, changelog snippets, wording/i18n links, implementation/PR links, test-environment info. These never become rows.
- Rephrasing is only allowed for this purpose — turning instructions into observable outcomes. Items that already describe observable behavior stay verbatim (see Text cleanup).

### Risk filter (implementation-based rows)
Implementation-based rows are the exception, not the norm. **The default is zero of them.** Only a diff that plausibly *broke* something, or that newly pins down a behavior the issue text leaves open, earns a row here. The default failure mode is enumerating everything the diff *touches* instead of what it plausibly *breaks* — resist it.

For every candidate row, ask: **which changed line would have to be wrong for this test to fail — and does an issue-derived row already fail when it is?** If you cannot name the line, or an issue row already covers it, drop the row.

- **Only the part of the diff that fixes *this* issue counts.** PRs are routinely linked to several issues. Rows derived from the parts belonging to another issue are out of scope, however tempting — they belong to that issue's table.
- **No "still works" rows.** "X still completes successfully", "Y is unaffected", "the main path is unchanged" are smoke tests, not findings. The issue-derived rows already exercise the main path.
- **Prerequisites are not rows.** If a tester must do X in order to execute an issue-derived row, X is already covered — e.g. "SAML login completes" under an issue about SAML sessions being invalidated.
- **Repro steps and comparisons are not requirements.** "For comparison, repeat with an email/password user" in the Steps to Reproduce is a testing hint, not a separate behavior to verify.
- **Check that the tester can actually trigger the failure.** A row about behavior when something fails is worthless if the issue's setup cannot make that path fail. Trace the failing branch's own conditions before writing the row — a validation guarded by `if (dto.hero)` never runs for a request that doesn't send `hero`, so flows that patch other fields (rename, a settings toggle) keep succeeding no matter how broken the card is. If you cannot name the request or action that reaches the failing branch, drop the row.
- **Assert the outcome the code actually produces, not the one the fix intends.** When a change makes an error propagate, read each caller's error handling before claiming user-visible feedback: a caller with a `try/catch` and a toast surfaces the failure, a caller with a bare `await` turns it into an unhandled rejection with nothing for a tester to observe — which fails the Testability filter and drops the row.
- **A code path is not a risk just because it runs through changed code.** Refactors, relocations and signature changes that leave a path's outcome identical earn no row — not one per caller, and not one per layer.
- **Don't invent edge cases the issue and the diff never mention** (empty values, missing fields, fallback branches) unless the diff itself added or changed that branch.
- Don't cover framework or library behavior, existing unit-test territory, or anything a tester can't reach in a real environment.
- **No fixed row count** — a genuinely broad change can justify several rows. But if you cannot state for each row the concrete field or line it traces to, the block is too long. Typical outcome for a small fix: **one row, or none.**

### Indentation handling
Requirements in the issue body usually come as an indented bullet list — keep its structure:

- **Top-level items** (no indent) → standalone rows, text used verbatim (trimmed)
- **Indented sub-items** → each becomes its own row, prefixed with `↳` to show hierarchy
- **Deeply nested items** → prefix with `↳↳`, `↳↳↳`, etc. (one `↳` per indent level beyond top)
- Preserve the logical reading order — never reorder items

### Text cleanup
- Strip leading list markers (`-`, `*`, `•`, numbers like `1.`)
- Stay close to the original wording — only rephrase when necessary, e.g. to turn a developer-directed instruction into an observable outcome (see Testability filter)
- If a line is purely a header/group label with sub-items (e.g. "Right side contains:"), include it as a row with `↳` prefix — and put `-` in all result columns to signal it is not a testable case

### Result columns
The table has three result columns, in this order after `Testcase`:

- **Smoke Test** — the row's result from the smoke test pass
- **Feature Test** — the row's result from the feature test pass
- **Release Test** — the row's result from the release check

- Always leave all three columns **empty** — they're filled in by a human tester
- Non-testable rows (pure header/group labels, the implementation-based block header) get `-` in
  all three columns

### Output
- Wrap the markdown table in a single code fence (` ``` `) so the raw markdown is visible and ready to copy-paste
- No preamble, no explanation outside the code fence
- One row per requirement/sub-requirement

### Always open the table in an editor before patching the issue
After printing the table, **always** write it to a file and open it so the user can edit the rows
before anything is written to GitHub:

1. Write the raw table (no code fence, no surrounding prose) to
   `<scratchpad>/issue-<number>-testing.md`. A feature test later fills its Feature Test column
   in this same file, so there is one file per issue.
2. Open it with the system's default application for `.md` files — no specific editor:
   - macOS: `open "<file>"`
   - Windows: `start "" "<file>"`
   - Linux: `xdg-open "<file>"`

   The command launches detached and prints nothing on success. 
3. Tell the user it opened — print exactly `The testing-table has been opened in the default .md editor.`,
   followed by the full absolute path as plain text (never a markdown link)
4. **Stop there.** Do not patch the issue. Wait for the user to edit the file and give an explicit
   go-ahead ("patch it", "update the issue", "übernehmen").
5. When the go-ahead comes, re-read the file from disk — the user's edits are the source of truth,
   not the table you printed earlier.
   - **Built for a feature test:** the go-ahead approves the plan. Don't patch the empty table
     (see `feature-testing` step 2).
   - **Requested on its own:** PATCH via `github-issue-management`, including the diff preview.

## Example

Requirements section of the issue:
```
- A separate "Workflow Library" page exists in the DataAgents navigation
- The page shows relevant use cases and workflows
- Each use case has a detail view
  - Right side contains:
    - A description of the use case and examples
    - The category of the workflow
  - Left side contains:
    - Preview of workflow (condensed version)
- Users can contact sales for more information
```

Output:
```
| Testcase | Smoke Test | Feature Test | Release Test |
|-|-|-|-|
| A separate "Workflow Library" page exists in the DataAgents navigation |  |  |  |
| The page shows relevant use cases and workflows |  |  |  |
| Each use case has a detail view |  |  |  |
| ↳ Right side contains: | - | - | - |
| ↳↳ A description of the use case and examples |  |  |  |
| ↳↳ The category of the workflow |  |  |  |
| ↳ Left side contains: | - | - | - |
| ↳↳ Preview of workflow (condensed version) |  |  |  |
| Users can contact sales for more information |  |  |  |
```

## Notes
- Mixed indentation (spaces vs tabs) is common in GitHub issues — normalize by treating any consistent deeper indent as one level
- If indent width is inconsistent, use relative depth (deeper = more `↳`)
- If the issue's requirements have no indentation at all, every item becomes a plain top-level row

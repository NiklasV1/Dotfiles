---
name: handoff-plan
description: Use when the user asks for a handoff plan, handover plan, prepare handoff, write a plan for the next agent, continue in another session, or context handoff.
---

# Handoff Plan

Create a self-contained markdown handoff file for another agent to continue the work. Once this skill is invoked, stop implementation work except for creating and verifying the handoff file.

## Workflow

1. Confirm there is an agreed plan or enough settled context to hand off. If there is no agreed plan, ask clarifying questions before writing the file.
2. Inspect relevant workspace state before writing. Use read-only checks such as `git status`, relevant diffs, and targeted file reads/searches as needed.
3. Ignore unrelated dirty worktree changes. Do not summarize or list unrelated paths unless they directly affect the handoff.
4. Create `/tmp/opencode/handoffs` if it does not exist, after verifying `/tmp/opencode` exists.
5. Write the handoff file to `/tmp/opencode/handoffs/YYYYMMDD-HHMMSS-<short-topic>-handoff.md`, where `<short-topic>` is a 2-5 word kebab-case label inferred from the task.
6. Verify the generated file exists, has all required sections, contains no obvious secrets, and has no accidental unresolved placeholders.
7. Respond with only the absolute file path and a 1-2 sentence summary of what the handoff contains.

## Content Rules

- Write for an agent that has the repository and the markdown file, but no prior conversation.
- Include all agreed decisions and material facts needed to continue.
- Use curated essentials only. Do not dump the transcript.
- Keep assumptions separate from agreed decisions.
- Redact secrets and sensitive values. Do not copy tokens, API keys, credential contents, private URLs, or environment values. Use placeholders and file references when appropriate.
- Include exact commands already run and exact recommended commands still to run, but summarize command results instead of pasting full output.
- Reference paths, functions, components, symbols, or modules. Do not include full code snippets or diffs unless a tiny excerpt is required to disambiguate the next edit.
- Include only constraints relevant to continuing the task.
- Include rejected approaches or prohibitions only when the next agent is likely to reconsider them.
- Use a narrative summary plus an ordered implementation checklist.
- Do not require runtime todos; the markdown checklist is the source of truth.

## Template

Use this exact section order:

```markdown
# Handoff: <topic>

## Metadata

- Created: <local timestamp>
- Workspace: <absolute workspace path>
- Branch: <current git branch, if available>
- Handoff file: <absolute path to this file>

## Goal

<Self-contained summary of the user's goal and desired outcome.>

## Current State

<What has already been done, what files or areas are relevant, and where the work currently stands.>

## Agreed Decisions

- <Decision and rationale, only if settled.>

## Relevant Context

- <Important repo behavior, architecture notes, file paths, functions, components, symbols, or constraints needed to proceed.>

## Implementation Plan

<Short narrative summary of the intended approach.>

1. <Concrete next step.>
2. <Concrete next step.>
3. <Concrete next step.>

## Verification

Commands run:

- `<command>`: <summarized result>

Recommended verification:

- `<command>`: <why to run it or what it validates>

## Constraints

- <Relevant user, repo, tool, safety, or process constraint.>

## Do Not Do

- <Explicit prohibition or rejected approach likely to be reconsidered.>

## Open Questions / Assumptions

- <Unresolved item, assumption, or blocker. If none, write "None known.">

## Next Agent Prompt

Continue the work using the handoff at `<absolute path to this file>`. Read it first, then inspect the referenced files and proceed with the implementation plan while respecting the listed constraints.
```

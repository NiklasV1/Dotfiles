---
name: explain-code-unit
description: Explain a component, service, controller, class, module, hook, function, or other code unit. Use when the user asks how a specific unit works, where it is used, what it depends on, or what to know before changing it.
---

# Explain Code Unit

Explain one identifiable unit of code to an experienced developer who is new to the codebase. Provide a quick orientation first, then enough evidence-backed detail to understand the unit in context.

This is a read-only task. Do not edit code, configuration, tests, or documentation while using this skill. A code change requires a separate explicit request.

## Resolve The Target

Accept a file path, symbol, line range, editor selection, or pasted code.

- If the request identifies a specific unit, begin researching it without asking for confirmation.
- If a file contains several plausible units and the intended unit is unclear, briefly list them and ask the user to choose one before doing deep research.
- If pasted code cannot be located in the repository, explain the snippet itself and state that repository usages and wiring could not be verified.
- Keep the report focused on one unit. Discuss adjacent units only when they clarify its behavior or role.

## Research The Unit

Read the implementation before explaining it. Then trace enough repository evidence to understand its actual role:

1. Identify its public contract: inputs, outputs, exported API, events, side effects, and failure behavior.
2. Follow its main execution paths from entry to result.
3. Inspect types, helpers, dependencies, and configuration that materially affect behavior.
4. Find representative production usages, callers, routes, registrations, or dependency-injection wiring.
5. Inspect relevant tests and extract the behavioral guarantees and important edge cases they demonstrate.
6. Check downstream effects when they are necessary to explain what the unit accomplishes.

Prefer repository evidence. Consult authoritative external documentation only when library or framework semantics materially affect the explanation and cannot be established locally. Inspect focused Git history only when an important design choice remains unclear from current code, tests, and documentation.

Do not confuse textual references with runtime usage. Account for generated code, reflection, framework registration, dependency injection, dynamic imports, and convention-based wiring where relevant. If static analysis cannot establish something, say so rather than guessing.

Search broadly enough to establish context, but do not dump every reference. Group usages by role or execution path and cite only representative examples.

## Adapt To The Unit

Apply the common report structure below, while emphasizing concerns appropriate to the target:

- **Component:** props, state, derived values, rendering decisions, events, effects, composition, and user interaction.
- **Service:** responsibility boundary, operations, dependencies, I/O, persistence, side effects, transactions, and failure handling.
- **Controller:** routes or entry points, request parsing, validation, authorization, orchestration, status codes, responses, and error mapping.
- **Hook:** inputs, returned API, state, effects, lifecycle, cleanup, and usage constraints.
- **Function:** preconditions, transformations, branches, side effects, result, and callers.
- **Class or module:** public surface, owned state, lifecycle, invariants, collaborators, and consumers.

For other unit types, infer the equivalent architectural concerns instead of forcing an unsuitable template.

## Write The Report

Keep the detail proportional to the unit's complexity. Use concise prose and bullets, not a line-by-line paraphrase. Explain project-specific behavior and framework conventions; skip basic programming syntax unless it is essential to a subtle point.

Use these core sections in this order:

### Summary

In a short opening, state:

- What the unit is responsible for.
- Why it exists in this system.
- Where it sits in the larger execution or data flow.

### Contract

Describe the externally meaningful interface: inputs, outputs, events, side effects, assumptions, and failure behavior. Distinguish the intended public surface from internal implementation details.

### How It Works

Trace the main runtime path in execution order, from input or trigger through important decisions and side effects to the result. Explain supporting helpers after the path in which they matter. Cover significant alternate and failure paths without cataloguing trivial branches.

### Dependencies

Identify only meaningful collaborators. For each, explain what role it serves and how it affects the unit, rather than merely listing imports.

### Where It's Used

Show representative production usages grouped by role or execution path. Explain how each caller or consumer uses the unit and why that usage matters. Include tests here only if they are themselves the clearest usage example; otherwise cover them under behavioral guarantees.

Add these sections only when relevant:

- **State And Data:** ownership, transformations, persistence, caching, synchronization, or lifecycle.
- **Errors And Edge Cases:** validation failures, exceptional paths, fallbacks, and notable boundary behavior.
- **Behavioral Guarantees:** what tests establish, including important edge cases and significant behavior that appears untested.
- **Change Cautions:** concrete coupling, surprising behavior, invariants, or downstream effects to understand before modification. Keep this descriptive; do not turn the report into a general code review.

When control flow or dependencies are genuinely difficult to hold in working memory, include one compact Mermaid diagram. Do not add a diagram when prose is clearer.

End with two or three specific, useful drill-down options based on the unit, such as tracing one call path, explaining a collaborator, or examining a state transition. Do not use generic prompts.

## Evidence Rules

- Cite key claims with repository-relative `path/to/file.ext:line` references.
- Place citations close to the claims they support.
- Clearly label interpretations as inferences.
- Explicitly state important missing evidence and relevant search limitations.
- Never invent behavior, intent, usage, or guarantees from naming alone.
- If implementation and tests disagree, describe the discrepancy rather than choosing one silently.
- Separate current behavior from historical rationale and proposed behavior.

The finished report should let the user quickly answer: what is this unit for, how does it execute, what does it depend on, where does it participate in the system, what behavior is verified, and what should be understood before changing it?

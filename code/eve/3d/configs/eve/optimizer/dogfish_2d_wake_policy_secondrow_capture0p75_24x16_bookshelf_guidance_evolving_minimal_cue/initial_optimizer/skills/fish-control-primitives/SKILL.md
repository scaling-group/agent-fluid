---
name: fish-control-primitives
description: "Cross-domain shelf for transferring explanatory swimming, wake-interaction, and robotic-fish control mechanisms into the L64 dogfish policy."
---

# Fish Control Primitives

This shelf collects mechanisms discovered in biological swimming, robotic
fish, reduced-order theory, CFD, and wake-control studies. The source problem
does not need to use this fish, geometry, or objective. The useful object is an
explanatory invariant that can be translated into this lane's observations,
two-joint actuation, and physical constraints.

Read current keyframes and metrics before using the shelf. Then read
`references/primitives.md`; read `references/sources.md` when a source family
informs an edit. Treat the references as hypotheses, not commands. Published
gains, dimensional frequencies, species-specific envelopes, world-frame
routes, and exact vortex phases are not transferable answers.

Keep the lane contract:

- Edit only `candidate_target_policy.jl`.
- Use normalized body-frame observations and state feedback.
- Do not add explicit time, step count, random numbers, file I/O, mutable
  global state, fixed cylinder coordinates, case identity, or a memorized
  route.
- Prefer one compact mechanism or one small compatible combination so the next
  rollout can test what the transfer contributed.
- A shelf citation never overrides contradictory rollout evidence.

The worker entrypoint specifies how much consultation and bookkeeping is
required for the current experiment variant.

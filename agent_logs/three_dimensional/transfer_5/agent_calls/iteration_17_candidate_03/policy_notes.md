# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned parent guidance, all four sampled solver results, and the
  inherited optimizer notes through the two step-16 descendants were read
  before choosing a mechanism. Every inspected evaluation used direct uniform
  still water at `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite,
  and terminated in capture.
- The combined sheets for the strongest sampled run
  (`solver_dbb24e880a8c`, the v33 anterior half-cycle controller) and the most
  informative underperforming inherited run (`solver_f2c603b1a6ec`, the v34
  mean course-curvature transfer) were inspected from release to capture. In
  both, the initially empty top-down field develops a coherent alternating
  vortex street and the oblique row develops compact paired Lambda2 structures
  behind a fish that translates along the same broad target-directed arc. The
  fish is self-propelled, neither wake breaks up, and the small terminal
  differences are below the sheet's visual resolution.
- The duplicate v33 samples capture at `23.8425T` with the best sampled score,
  mean distance, and final distance (`-0.535091`, `2.433543L`, `0.746165L`).
  Inside `3L`, their mean/peak absolute yaw is `1.6800/3.1848 rad/T`, mean
  body-lateral speed is `0.2522U`, and mean absolute lateral force/moment is
  `0.011756/0.006382`. Posterior amplitude and lag remain intact, the joint
  angle stays below `35.27 deg`, and projected acceleration stays below
  `31.386 rad/T^2`, although the posterior joint still touches its velocity
  envelope.
- The inherited v34 controller continuously transfers `25%` of the signed
  terminal course-curvature target from the posterior mean tangent to the
  anterior oscillator center. It retains capture and the coherent wake and
  improves inside-`3L` mean/peak yaw to `1.6440/3.1207 rad/T`, body-lateral
  speed to `0.2463U`, lateral force to `0.011561`, and mean/peak moment to
  `0.006271/0.013582`. But it arrives later at `23.8480T`, worsens mean/final
  distance to `2.434212/0.747022L`, and scores `-0.535920`. Moving the entire
  route-scale course share on every beat phase is therefore a useful
  stability/progress tradeoff, not an improvement over v33.
- Earlier posterior amplitude relief, moment/route admission, equal
  redistribution, and counter-tangent descendants show that repeatedly
  editing posterior cycle-scale authority either discards useful impulse or
  restores v24-scale yaw. The evidence instead supports retaining the v33
  posterior carrier and testing whether v34's stabilizing allocation can be
  confined to the observed half-cycle that reinforces excess yaw.

## Policy hypothesis recorded before policy edit

Use evaluated v33 as the behavioral base. Preserve its state-feedback
traveling-wave carrier, response-released C-bend, continuous normalized
body-frame course bend, phase-selected anterior excess-yaw residual, posterior
amplitude and lag, and component-wise smooth command projection. Add one small
allocation mechanism: move the same bounded share of continuous terminal
course curvature from posterior mean tangent to the anterior oscillator only
on the observed posterior half-cycle that supports carrier-rejected excess yaw.
On the opposite half-cycle the evaluated v33 course allocation is unchanged.

This is a phase-selective actuator allocation, not scalar-only gain tuning. It
tests whether v34's yaw/lateral-load cleanup can be retained without paying the
progress cost of moving useful posterior course authority throughout the
cycle. Falsify it if capture or coherent wake formation regresses; if capture
time or the distance integral is worse than v34; if terminal yaw/lateral/load
histories fail to improve materially over v33; or if joint-angle, joint-speed,
or projected-command exposure grows.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and robotic-fish half-cycle asymmetric turning control
source_mechanism: preserve posterior traveling-wave authority for thrust while reallocating a bounded corrective bend anteriorly only on the observed beat side that reinforces unwanted yaw
transferable_invariant: separate the propulsive carrier from corrective curvature and apply the smallest state-selected anterior correction without suppressing the useful posterior half-cycle
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame course feedback supplies the signed terminal bend; carrier-rejected yaw supplies correction demand; observed q1+q2 supplies beat side; their bounded product gates a curvature-preserving posterior-to-anterior transfer without clock or memory
falsification: reject if capture or alternating-wake coherence regresses, v34-scale progress is not recovered, v33 terminal yaw/lateral/load does not improve, or actuator-limit exposure grows
```

The current candidate has no same-worker CFD evidence. Its post-worker rollout
is evidence for a later generation, not support for the hypothesis above.

## Non-CFD validation boundary

- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account and failed before inspecting the workspace.
  Its exact guidance and solver-boundary commands were run directly and pass.
- No Julia executable or installed launcher is available, so the lightweight
  Julia smoke command cannot start. A deterministic static schema audit found
  all 69 direct `params.FIELD` references among the 71 fields returned by
  `target_policy_params()`; only metadata fields `version` and
  `control_period` are unreferenced. Static inspection finds exactly one
  nonempty `candidate_target_policy.jl` under `solver/`.
- An `8,120,601`-state algebraic grid over bounded yaw demand, observed tail
  side, and signed course bend limits the new transfer to `2.5 deg`, makes it
  identically zero on the opposite half-cycle, and preserves the signed
  head-plus-tail course target to `2.78e-17 rad`. The candidate differs from
  the evaluated v34 policy only by this state-derived phase gate and metadata/
  comments; no formal CFD was run.

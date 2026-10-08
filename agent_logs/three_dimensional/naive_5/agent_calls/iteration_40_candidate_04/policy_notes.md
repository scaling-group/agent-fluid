# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four current samples satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and inertial moving-window transport. All capture and
  remain below the angle, rate, and applied-acceleration limits. Three samples
  byte-match one another in policy, trajectory, and combined visual sheet, so
  they are deterministic replication rather than three independent controller
  mechanisms or evidence of held-out robustness.
- I inspected the distinct combined keyframe sheets for the assigned parent
  (`solver_edce799cc5f9`) and the replicated finite comparator
  (`solver_b3cc38ade37a`) from release through capture. Their top-down rows show
  genuine self-propulsion and an organized alternating wake; their oblique
  body/Lambda2 rows show compact three-dimensional structures that remain
  coherent through the target-side hook. Neither sheet shows passive
  advection, wake breakup, a boundary precursor, numerical instability, or
  window-induced body rotation. No non-capture visual is present in the
  current sample, so the inherited failed both-joint response-yield rollout is
  used only as a logged negative boundary, not as an unseen visual claim.
- The assigned parent differs from the replicated comparator by replacing a
  phase-confounded sideslip target shift and instantaneous force residual with
  a phase-rejected target-normal response estimate and a posterior reaction
  half-cycle. The parent is identical through `18T`, then reaches
  `3.654917/2.549768/1.449166L` at `20/22/24T` versus
  `3.655057/2.556333/1.474760L`. It captures `0.1595T` earlier at
  `25.3495T`, lowers mean distance from `2.457773L` to `2.456908L`, and
  improves score from `-0.556475` to `-0.555926`, while retaining the same
  sampled peak planar force/yaw moment (`0.02063/0.01065`) and zero actuator
  contacts. This is a reproducible finite timing/progress improvement, but the
  two visual routes remain in one coherent family and the capture crossing is
  still shallow (`0.748585L`), so it is not evidence for scalar-strengthening
  the reaction term.
- A reconstruction of the parent's normalized middle-corridor signals shows
  why the phase allocation is physically interpretable. The posterior
  reaction gate becomes active only after the fish is inside `4.5L`, peaks
  near `0.77`, and selects the half-cycle whose velocity-normal force rotates
  course toward the target in about `95%` of active rows. During the
  complementary inactive phase, force has the adverse course-rotation sign in
  about `79%` of rows. The inherited response-yield failure scaled both joint
  commands from instantaneous force and captured later (`25.9160T` versus
  `25.8115T` for its parent), so force must not choose direction and the
  anterior traveling-bend carrier must not be globally weakened.

## One-candidate policy hypothesis

Preserve the assigned state-feedback carrier, upstream anterior duty steering,
posterior lag/vectoring, response-released redirect, target-line residual,
phase-rejected favorable posterior reaction, terminal capture modulation,
coupled command projection, and viability guards. Add one compatible part to
the existing middle-corridor reaction allocation: when the same normalized
phase-rejected target-normal deficit persists but joint 2 is moving on the
complementary course-adverse half-cycle, apply a smooth opposing posterior
brake. The entire anterior control law, low-response states, far and terminal
states, and the favorable reaction half-cycle pass through structurally
unchanged. The brake reuses the favorable reaction term's existing bounded
effort rather than adding a gain. This is posterior phase-selective reaction
yielding, not a static bend, an oscillator-gain increase, or force-selected
commutation.

The falsifiable expectation is to retain the coherent carrier and the parent's
upstream path while reducing `20--24T` target-normal course error enough to
capture earlier or with lower mean distance, without exceeding the sampled
`0.02063/0.01065` load regime or restoring any actuator contact. Reject the
mechanism if it slows approach, weakens the wake or posterior propulsion,
repeats the inherited both-joint response-yield regression, changes only the
milliscale crossing tie-break, or loses capture. A later worker should compare
full-beat course response and not infer success from lower command effort.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric CPG steering and elongated-body reactive propulsion
source_mechanism: reshape only one state-derived half-cycle while preserving posterior phase lag and the anterior rhythmic carrier
transferable_invariant: persistent target-owned course error can allocate posterior effort away from an adverse reaction phase without prescribing clock phase, global direction, or a route
nontransferable_details: published gains, dimensional frequencies, linkage geometry, species-specific envelopes, exact vortex phase, and task-specific trajectories
policy_translation: normalized body-frame target/course geometry and phase-rejected target-normal velocity retain route authority; joint-2 rate identifies the complementary phase and a bounded posterior brake opposes only its course-worsening motion
falsification: reject on slower or lost capture, unchanged full-beat course response, loss of coherent three-dimensional propulsion, any actuator contact, higher sampled loads, or reproduction of the inherited global response-yield regression
```

## Non-CFD audit after the policy edit

- An initial removal-only implementation exposed that the parent already
  commands restoring acceleration through nearly all of the adverse posterior
  stroke: it changed only `144/4609` reconstructed parent states, with maximum
  command difference `0.026842 rad/T^2`. That was controller redundancy, not a
  useful test. The final bounded opposing-brake form changes `516/4609`
  reconstructed states only from `18.5185--23.4795T` and
  `4.4987--1.7522L`; its maximum and mean changed-command differences are
  `0.234727` and `0.024597 rad/T^2`. The audit establishes nontrivial scope and
  intended scheduling, not a CFD performance claim.
- The final candidate SHA-256 is
  `ebb9938e3a126d83da31df027daf6fad52e142b06fd69f1a2dd245048810caa2`.
  All 65 direct `params.FIELD` references are owned by the 65-field object from
  `target_policy_params()`. The prescribed public-contract state returns two
  finite accelerations. A deterministic audit of 80,000 paired states spanning
  reflected target geometry, joint states beyond the physical envelope,
  closing and receding motion, and far/middle/near distances remains finite
  and bounded by `30 rad/T^2`, with zero reflection-command error.
- Guidance materiality, the lightweight Julia contract, and the solver
  editable-boundary checks pass. The guidance check initially found the same
  assigned parent marked twice in the rendered workspace `README.md`; removing
  only the duplicate restored an unambiguous parent. The required independent
  check-runner was invoked, but its pinned `gpt-5.4-mini` model is unavailable
  on this account, so its exact three checks were run directly and passed. No
  formal CFD was run; the candidate's outcome remains evidence for a later
  worker.

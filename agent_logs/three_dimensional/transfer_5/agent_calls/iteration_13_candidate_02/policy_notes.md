# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- All four sampled runs satisfy the frozen experiment contract: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no cylinders or prewarm,
  stable dynamics, and capture. In the combined sheets, the empty release field
  develops into a coherent alternating mid-plane vortex street and compact
  oblique Lambda2 pairs. The fish self-propels through the broad target-directed
  turn and remains driven during the curved terminal approach; the controller
  differences do not visibly change that useful topology.
- The evaluated v24 continuous-course baseline captures at `23.8315T` with mean
  distance `2.434073L`. Inside `3L`, its mean/peak absolute yaw is
  `1.6839/3.2076 rad/T`, mean target-transverse speed is `0.2393U`, mean absolute
  lateral force is `0.011795`, and mean/peak absolute moment is
  `0.006402/0.014062`.
- Hard direction consensus is a negative result: it arrives later at `23.8590T`
  and leaves terminal yaw, cross-track motion, and mean load essentially
  unchanged. The load-selective posterior counter-tangent has the best sampled
  score and mean distance (`-0.535298`, `2.433642L`) while retaining v24's
  arrival, but it increases mean cross-track speed to `0.2449U`, peak yaw to
  `3.2645 rad/T`, and peak moment to `0.014385`; another counter-tangent is not a
  clean load remedy.
- Posterior half-cycle amplitude relief is the clearest useful tradeoff. It
  retains capture and the same alternating wake while lowering inside-`3L`
  mean/peak yaw to `1.6060/3.0632 rad/T`, cross-track speed to `0.2335U`, mean
  lateral force to `0.011351`, and mean moment to `0.006137`. Its cost is later
  capture at `23.8755T` and mean distance `2.433993L`. The intervention therefore
  identifies amplitude relief as the effective yaw/load actuator, but suggests
  it is authorized more often than progress requires.

## Candidate hypothesis

Use evaluated v24 as the sole base and preserve its state-feedback oscillator,
posterior lag, response-released C-bend, continuous target-course terminal bend,
and smooth command projection. Add one bounded residual inside the existing
`3L` gate: carrier-rejected excess yaw selects the posterior half-cycle, while
normalized yaw moment admits amplitude relief only when the hydrodynamic load
reinforces that yaw. Naturally opposing load leaves both strokes untouched.

This combines the effective actuator from the amplitude-relief result with the
useful selectivity principle from the load-gated result. It should recover some
of the unconditional relief candidate's arrival loss while retaining measurable
yaw/load cleanup. Falsify it if capture or wake coherence is lost; arrival or
mean distance is worse than the unconditional relief result; terminal yaw,
cross-track speed, lateral force, and mean moment do not improve materially over
v24; or joint-speed/command-limit exposure worsens.

```text
bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish asymmetric flapping
source_mechanism: preserve slow target-derived mean curvature while applying a bounded state-selected posterior half-cycle residual only during reinforcing hydrodynamic load
transferable_invariant: separate route control from fast disturbance response and reshape only the posterior stroke that supports unwanted yaw
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: keep normalized body-frame course feedback; use carrier-rejected yaw for half-cycle direction, observed two-joint tail tangent for beat side, and normalized yaw moment as a smooth admission gate on posterior amplitude relief
falsification: reject if capture or the coherent alternating wake regresses, or if v24-scale progress is not retained while terminal yaw, cross-track motion, and load improve without added limit exposure
```

## Non-CFD validation

- The configured check-runner was invoked, but its fixed `gpt-5.4-mini` model
  is unavailable for this account. Its exact checks were therefore run directly.
- The material-guidance check and solver boundary check pass. The boundary check
  confirms that only `candidate_target_policy.jl` changes inside `solver/`.
- The Julia smoke command could not start because no Julia executable exists in
  the shell or installed toolchain paths. A deterministic schema audit found all
  69 direct `params.FIELD` references in the returned parameter object; only
  metadata fields `version` and `control_period` are intentionally unreferenced.
  Static guards found no clock, step counter, random source, file I/O, or mutable
  global state. By construction, signed relief and observed tail side are each
  bounded to unit magnitude, so `terminal_tail_wave_gain` remains in
  `[1 - 0.18, 1] = [0.82, 1]` before the inherited smooth command projection.

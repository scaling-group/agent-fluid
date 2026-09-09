# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The common prewarm sheet places the held fish above and downstream of four
  fully developed, overlapping vortex streets. This is shared initial-state
  evidence, not a controller effect. Every released sample remains to the
  right of the useful wake and target corridor, so this candidate addresses
  far-field propulsion and course recovery rather than claiming wake capture.
- The unguarded positive-bearing angle-only policy is the informative unstable
  contrast. Its sheet shows coherent leftward propulsion through the first four
  frames, then a folded-body terminal event. Metrics agree: head displacement
  is `(-3.59,+0.15)L`, mean velocity x is `-0.149` versus local-flow x
  `-0.0774`, and progress is `0.259`; both acceleration caps are reached while
  RMS force/moment jump to `20024/314391` before instability at `33.06` time.
  The gait supplies real upstream motion, but its unguarded terminal state is
  not reusable control.
- The strongest finite sample retains that `0.75`-period angle-only gait and
  adds `12 deg` bearing steering, `0.04` recent-turn damping, localized joint
  guards, and a smooth acceleration bound. Its keyframes show a clean leftward
  leg, a `6.71L` closest approach, and then a broad upper U-turn outside the
  wake. It remains finite for `65.47` time with head displacement
  `(-4.08,+1.80)L` and RMS force/moment `66.5/958`, but range rebounds to
  `9.73L` before the top exit. This is the finite propulsion anchor.
- The current prefilled distance-gated `0.04` to `0.06` continuation repeats
  the same visual upper curl and top exit while regressing to `-2.48L` head x
  and `8.59L` minimum range. The gate changes the controller before its nominal
  `8L` threshold and the rollout never reaches that threshold. A `14 deg`
  ceiling similarly retains the upper-exit topology with only `-2.46L` head x
  and `8.85L` minimum range. Neither changes lateral oscillation into useful
  wake entry.
- Assigned-parent logs make the local tuning failure concrete. Reducing
  bearing gain to `0.45` loses approach (`-0.73L` head x, `9.90L` minimum),
  uniform turn damping `0.045` nearly eliminates upstream travel (`-0.15L`),
  and `0.05` crosses to a long lower/downstream exit (`+0.33,-13.31)L` despite
  a `6.83L` transient minimum. Together with the sampled `10/12/14 deg`
  ceiling results, this is not a smooth scalar response worth interpolating.
- The task-native observation contract explains a missing capability shared by
  those policies: `state.bearing` is computed with `abs(forward_distance)`, so
  it preserves lateral sign but folds target-ahead and target-behind geometry
  together. In the finite sheets the target is visibly aft/down-left once the
  fish pitches upward, yet the controller still receives a folded acute
  bearing. Gain, ceiling, range gating, and recent-turn damping cannot restore
  the missing fore/aft distinction.

## One candidate hypothesis

Restore the complete strongest finite controller, removing the unsuccessful
distance gate and retaining its `0.75` period, `22 deg` amplitude, posterior
lag, `0.60` gain, `0.04` recent-turn damping, `12 deg` ceiling, joint guards,
and smooth `1600 deg/time^2` bound. Change only the course observation: compute
the signed full target direction as
`atan(state.target_body_L[2], -state.target_body_L[1])` instead of using the
fore/aft-folded `state.bearing`.

This body-frame, normalized direction is identical to the task bearing on the
sampled far-forward approach (where longitudinal separation exceeds the
task's `0.25L` bearing floor), so the demonstrated early propulsion and
steering law are preserved. Once the target moves aft, it supplies the missing
large course error while the existing `12 deg` saturation bounds the
intervention. It adds no derivative, load feedback, route, coordinates, target
identity, clock,
prescribed inflow, remote probe, or omitted research shelf. All active gains,
limits, gait constants, and safety thresholds remain owned by
`target_policy_params`.

The next CFD rollout supports the hypothesis only if it retains negative head
and relative-flow x through the productive leg, then turns the aft/down-left
target back toward the forward body half-plane without the repeated upper
exit, while remaining finite and low-load. It is falsified if full-direction
saturation disrupts the initial upstream gait, causes a new tight loop or
folded-body event, or repeats the same upper/downstream topology. No outcome
for this unevaluated candidate is claimed here.

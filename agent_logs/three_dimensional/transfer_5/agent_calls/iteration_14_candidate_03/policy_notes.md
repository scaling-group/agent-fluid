# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned parent guidance, four sampled solver evaluations, and inherited
  v31 optimizer evidence were read before proposing the controller change. All
  five evaluated runs used direct uniform still water at `U_infinity=(0,0,0)`,
  with no cylinders or prewarm, and terminated in capture.
- The combined sheets were inspected in both views. The v30 load-selective
  counter-tangent (best sampled score) and v30 posterior-amplitude relief
  (clearest stabilizing tradeoff) both start from an empty field, self-propel
  through the broad target-directed turn, form a coherent alternating
  top-down vortex street and compact oblique Lambda2 pairs by `12T`, and retain
  that wake through the curved capture. The inherited v31 sheet has the same
  useful topology. Differences below therefore concern terminal regulation,
  not wake creation or background advection.
- The v24 continuous-course baseline captures at `23.8315T`; inside `3L` its
  mean/peak absolute yaw is `1.6839/3.2076 rad/T`, target-transverse speed is
  `0.2393U`, and mean absolute lateral force/moment are
  `0.011795/0.006402`. A load-selective counter-tangent retains the arrival and
  has the best sampled score (`-0.535298`), but worsens cross-track speed to
  `0.2449U`, peak yaw to `3.2645 rad/T`, and peak moment to `0.014385`.
- Unconditional posterior half-cycle amplitude relief preserves capture and
  the coherent wake while reducing near-target mean/peak yaw to
  `1.6060/3.0632 rad/T`, cross-track speed to `0.2335U`, lateral force to
  `0.011351`, and moment to `0.006137`; its arrival is later at `23.8755T`.
  Thus amplitude, rather than another tangent offset, is the evidenced
  posterior stabilizing coordinate.
- The inherited v31 result falsifies reinforcing-moment admission as the way to
  recover that arrival cost. It also captures at `23.8755T`, but worsens score
  and final distance to `-0.537144` and `0.748217L`; its near-target yaw is
  `1.6345 rad/T`, weaker cleanup than unconditional relief's `1.6060`, despite
  reducing target-transverse speed further to `0.2299U`. Later workers should
  not assume a hydrodynamic-load gate makes amplitude relief more selective in
  the progress sense.

## Candidate hypothesis recorded before policy edit

Use evaluated v24 as the sole base. Preserve its state-feedback traveling-wave
carrier, posterior lag, response-released target C-bend, continuous terminal
course curvature, and smooth component-wise command projection. Add one
bounded terminal mechanism: use the already carrier-rejected, target-relative
course residual to select and scale posterior amplitude relief on only the
half-cycle whose observed tail side supports lateral motion across the target
line. Unlike v31, fluid moment does not arbitrate the residual; unlike the
unconditional relief candidate, excess yaw alone cannot authorize it when the
route-scale course residual is small.

The expected result is to retain the amplitude-relief candidate's yaw/load
cleanup while leaving more of the posterior wave intact when yaw is merely the
fast propulsive carrier. Falsify this mechanism if capture or alternating-wake
coherence is lost; if arrival/final distance regress to or beyond v31; if
near-target cross-track, yaw, or load fails to improve materially over v24; or
if joint-speed and command-limit exposure worsen.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and terminal fish capture control
source_mechanism: retain a propulsive traveling bend and continuously reshape only the posterior half-cycle associated with an observed route-scale lateral error
transferable_invariant: separate mean target-course curvature from beat-side amplitude modulation, and authorize the modulation from normalized target-relative motion rather than a clock or prescribed phase
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific kinematics and envelopes, exact vortex phases, and task-specific routes
policy_translation: preserve v24 body-frame steering; use the normalized body-frame target-vector/velocity cross product after carrier rejection to select and scale relief of the observed q1+q2 posterior side inside the existing approach gate
falsification: reject if capture or coherent alternating propulsion regresses, or if v24-scale progress is not retained while terminal cross-track motion, yaw, and load improve without added actuator-limit exposure
```

## Non-CFD validation

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account. Its exact checks were run directly.
- The material-guidance check passes after removing a duplicate assigned-parent
  marker from the rendered workspace `README.md`. The solver boundary check
  passes and confirms that `candidate_target_policy.jl` is the only solver
  difference from the baseline.
- The deterministic schema audit found all 68 direct `params.FIELD` references
  among the 70 returned fields; only metadata fields `version` and
  `control_period` are intentionally unreferenced. Exactly one nonempty
  candidate exists under `solver/`, and static guards found no time/step state,
  randomness, file I/O, fixed coordinates, or mutable globals. By construction,
  the new posterior wave gain remains in `[0.82,1]` before inherited smooth
  command projection.
- The configured Julia smoke command could not start because no Julia
  executable is installed. No formal CFD was run.

# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- Every sampled rollout and the assigned-parent rollout satisfies the frozen
  evidence contract: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture.
  In both visual rows the initially empty field develops a coherent alternating
  top-down vorticity street and paired oblique Lambda2 structures behind a fish
  that translates toward the target. The policies are self-propelled rather
  than advected, retain the same broad target-directed arc, and show no visible
  wake breakup before capture. Their useful differences are smaller than the
  keyframe resolution and must be resolved from trajectory, load, joint, and
  score histories.
- The strongest sampled finite run is the load-selective posterior counter-
  tangent: score `-0.535298`, scoring mean distance `2.433642L`, and capture at
  `23.8315T`. Against the v24 continuous-course baseline (`-0.535794`,
  `2.434073L`, `23.8315T`), however, it barely changes inside-`3L` mean absolute
  filtered yaw (`1.6816` versus `1.6839 rad/T`) or body-lateral speed (`0.2544`
  versus `0.2535U`) and raises peak yaw from `3.2076` to `3.2645 rad/T`. It is
  evidence for preserving progress, not for another counter-tangent as a yaw
  remedy.
- Ungated posterior half-cycle amplitude relief is the physically useful
  counterexample. It retains the coherent wake and capture while reducing
  inside-`3L` mean/peak yaw to `1.6060/3.0632 rad/T`, mean body-lateral speed to
  `0.2414U`, and mean absolute body-lateral force to `0.01135`, compared with
  the v24 baseline's `1.6839/3.2076`, `0.2535U`, and `0.01179`. Peak joint angle,
  joint speed, and projected acceleration remain respectively `0.616 rad`,
  `4.538 rad/T`, and `31.379 rad/T^2`. Its cost is capture at `23.8755T` and
  mean distance `2.433993L`, consistent with discarding some useful posterior
  impulse rather than losing wake coherence or command feasibility.
- The assigned parent's load-gated version of that relief is a concrete
  negative result. It still captures at `23.8755T`, but worsens score to
  `-0.537144`, mean/final distance to `2.435252/0.748217L`, terminal mean yaw to
  `1.6345 rad/T`, body-lateral speed to `0.2443U`, lateral force to `0.01151`,
  and mean moment to `0.006215`, relative to ungated relief. On its realized
  terminal trace the reinforcing-moment factor is nonzero for about `76%` of
  states and multiplication reduces the mean tail-side relief weight from
  about `0.251` to `0.207`; this merely weakens the useful relief and does not
  recover arrival. Later workers should not reuse instantaneous reinforcing
  yaw moment as a multiplicative authorization gate for this half-cycle
  amplitude actuator without a different, evidenced phase or impulse model.

## Policy hypothesis

Retain the v24 state-feedback oscillator, response-released C-bend redirect,
continuous body-frame target-course terminal bend, and component-wise smooth
acceleration projection. Replace dissipative amplitude removal with one compact
posterior stroke-redistribution mechanism. Carrier-rejected excess yaw chooses
the unwanted turn direction and observed `phi1+phi2` identifies the current
tail side. Inside the same target-relative terminal gate, reduce the oscillatory
tail target on the yaw-supporting half-cycle and increase it by the same bounded
fraction on the yaw-opposing half-cycle. This changes waveform asymmetry while
leaving its cycle-scale authority and the mean course bend intact.

The equal transfer uses the already evaluated relief fraction rather than a new
gain search. It should retain the relief child's yaw, lateral-speed, and load
cleanup while restoring enough posterior impulse to match or beat v24's
`23.8315T` arrival and `2.434073L` scoring mean distance. Falsify it if capture
or coherent wake formation is lost; if arrival and distance integral do not
recover relative to ungated relief; if terminal yaw/lateral/load metrics return
to the v24 or counter-tangent range; or if joint-angle, joint-speed, or projected
command exposure worsens materially.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric CPG turning and elongated-body posterior reactive thrust
source_mechanism: turn by redistributing posterior half-cycle amplitude while a slower target-derived bias preserves route curvature and the traveling carrier
transferable_invariant: preserve the propulsive traveling bend and cycle-scale posterior authority while shifting a bounded amount of stroke authority from the half-cycle reinforcing unwanted yaw to the opposing half-cycle
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: normalized body-frame target geometry retains the continuous course bend; carrier-rejected yaw selects correction sign, observed two-joint tail tangent selects the half-cycle, and a proximity/speed gate applies equal bounded posterior wave relief and boost without clock or memory
falsification: reject if capture/wake coherence regresses, if approach time and distance integral fail to recover over amplitude removal, if yaw/lateral/load cleanup is lost, or if joint and projected-command exposure worsens
```

## Non-CFD validation

- The configured check-runner was invoked, but its fixed `gpt-5.4-mini` model
  is unavailable for this account and failed before inspecting the workspace.
  Its three prescribed checks were therefore run directly: the material-
  guidance check, lightweight Julia policy contract, and solver boundary check
  pass. No CFD was run.
- Every direct `params.FIELD` reference is present in
  `target_policy_params()`. A `32,805`-state grid spanning distance, body-frame
  target side, velocity, yaw, joint angle, and joint velocity returned finite
  commands within `31.416 rad/T^2`; redistribution was active in `10,368`
  states. Matched supporting/opposing tail-side probes produced symmetric
  waveform gains of `0.8942` and `1.1058`. All `19,683` grid states at or beyond
  the `3L` terminal boundary were bitwise identical to v24, and non-finite
  observation probes still returned finite commands.

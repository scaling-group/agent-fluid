# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- All four sampled rollouts are valid direct-uniform still-water evaluations:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and 269--271 moving-window
  shifts. All capture from `12.3277L`; the three plain/recession-release
  policies have byte-identical visual sheets and capture at `25.2615T`.
- I inspected the combined and view-specific top-down vorticity and oblique
  body/Lambda2 sheets for the best sampled capture, `solver_d5c9dea468e1`, and
  the informative approach-control failure, inherited
  `solver_e7a7bd0d3fe2`. The best capture is visibly self-propelled: it forms a
  coherent alternating posterior wake through a compact target-directed arc,
  then smoothly straightens into the capture circle at `25.1130T`; its oblique
  row shows finite three-dimensional wake structures and no instability. The
  approach-hold counterexample preserves an early wake but turns past the
  target into a broad orbit visible in both views and captures only at
  `51.6450T` (score `-1.19739`). Broad near-target drive relief is therefore
  not a safe substitute for curvature allocation.
- The closure-previewed terminal reallocation in `solver_d5c9dea468e1` is a
  small, consistent improvement over the plain/recession-release result. It
  advances capture by `0.1485T`, improves mean distance from `2.431797L` to
  `2.430636L` and score from `-0.530646` to `-0.530060`, removes the remaining
  inside-`4L` acceleration-cap incidence (`0.292%/0%` to `0%/0%`), and lowers
  inside-band force/yaw-moment coefficient maxima from about
  `0.01593/0.00834` to `0.01547/0.00800`. Its far motion is unchanged through
  `4.3L`; the first material effect is the intended transition preview.
- The sampled intercept-corridor carrier release is a concrete negative
  result. It retains capture at `25.2615T`, but score falls to `-0.531485` and
  mean distance rises to `2.432459L`. Together with two earlier
  velocity-course residual regressions, this rules out restoring carrier or
  adding course steering merely because a straight-line intercept looks safe.
- At the plain policy's `4L` crossing, joint 1 is already at `-0.751 rad` and
  its command is capped while its velocity continues away from the terminal
  curvature equilibrium. Preview reduces that command to `29.60 rad/T^2` and
  subsequently settles both joints without the slow orbit. This localizes the
  remaining test to how the partial blend treats a destructive carrier
  half-cycle, not to more range preview, curvature gain, or global drive
  relief.

## Policy hypothesis

Start from the evaluated closure-previewed policy exactly. During only the
partial terminal carrier-to-curvature transition, measure whether either
joint is moving away from its already target-signed curvature equilibrium via
the normalized positive quantity `(q-q_target)*q_dot`. Increase reallocation
smoothly on that destructive half-cycle and leave the return half-cycle at the
validated previewed blend. Multiplying the addition by `gate*(1-gate)` makes
the mechanism exactly inactive both before the terminal transition and after
full curvature allocation; closure and body-frame target geometry retain all
authority over entry, release, and turn sign.

Expected evidence is byte-equivalent far-field commands, the same coherent
outer wake, less joint excursion and command clipping during the `4L` blend,
and capture no later than `25.1130T` without the broad orbit or increased
terminal load. Reject the mechanism if it changes commands while the terminal
gate is zero or one, delays/loses capture, raises inside-band force or moment,
or recreates low-drive loitering.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: state-feedback half-cycle asymmetry that preserves the useful bend phase while weakening the phase opposed to the requested turn
transferable_invariant: when rhythmic propulsion and target-directed curvature share limited joints, observed joint phase can reallocate only the half-cycle that is moving away from the desired bend while preserving the returning half-cycle
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific kinematics, exact vortex phases, full-body waveforms, and prescribed routes
policy_translation: normalize positive curvature-error growth `(q-q_target)*q_dot` by the state-feedback carrier scale and use it only to boost the existing bounded terminal blend during its partial transition; body-frame geometry still selects the two joint targets
falsification: reject if outer commands change, transition clipping or loads do not fall, capture is delayed or lost, or the phase-selective blend behaves like broad drive relief and produces a loop

The new CFD result is intentionally not claimed here; it becomes evidence for
a later worker.

## Non-CFD implementation audit

The deterministic schema audit finds every direct `params.FIELD` reference in
the returned 69-field parameter object. Synthetic states with the same joint
motion and target geometry confirm exact command equality with the evaluated
closure-previewed parent when the terminal gate is zero and when it is one.
At a partial gate of `0.645`, positive equilibrium-departure pressure raises
the effective gate to `0.783`; the two finite commands remain inside the
declared acceleration cap. This verifies bounded activation and endpoint
noninterference only, not a coupled-flow improvement.

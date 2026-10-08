# Band-pass crossflow-confidence pose candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite captures from direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  The
  three policy-equivalent geometry-released examples reproduce capture at
  `18.403006 T`, score `-0.140449`, total/observed distance integrals
  `2.027810/1.418099 L`, maximum speed `0.94760 L/T`, acceleration-limit
  residence `42.14%`, and peak normalized force/moment `0.03068/0.01587`.
- I inspected the combined geometry-only and assigned-parent sheets from
  release through capture, including both their top-down mid-plane vorticity
  and oblique body/Lambda2 rows.  The fish self-propel from quiescent water on
  a smooth target-signed arc; compact startup structures become a coherent
  alternating posterior wake in both views.  There is no passive advection,
  collision, wake collapse, domain exit, or visible instability.
- The sampled v38 crossflow-confidence rollout has a valid top-down row showing
  the same productive alternating wake and target-directed arc, but its
  oblique sheet is entirely black.  That is a multimodal evidence-contract
  failure, so no v38-specific oblique-wake claim is made.  The controller is
  selected from its completed trajectory and load evidence, not scalar score
  alone; the new evaluation must restore a readable oblique row.
- Relative to the reproduced geometry-only controller, v38 captures at
  `18.232491 T` (`0.170515 T` earlier), improves total/observed integrals to
  `2.012983/1.399804 L`, and is closer by
  `0.0039/0.0241/0.0630/0.1060/0.1437/0.1434/0.1405/0.1415/0.1273 L` at
  `2/4/6/8/10/12/14/16/18 T`.  Maximum speed rises only to `0.95195 L/T`,
  acceleration-limit residence falls to `41.54%`, peak force is unchanged at
  `0.03068`, and peak moment falls slightly to `0.01579`.
- The assigned parent supplies the mechanism comparator.  Its monotone
  crossflow magnitude weighting captures at `18.325987 T` but trails the base
  through the high-crossflow middle route and raises maximum speed/saturation
  to `0.96311 L/T` and `43.55%`.  V38's confidence peaks at moderate normalized
  crossflow and yields at large values; it is ahead of that parent at every
  sampled checkpoint, improves observed integral by `0.018186 L`, and reduces
  both speed and saturation.  A late distance gate preserves the base middle
  route but reaches only `18.386505 T`, so elapsed-route scheduling is not
  retained.
- No current sampled rollout changes termination.  The inherited whole-wave
  route-rate projection remains the informative failure boundary: an organized
  wake accompanied a wrong-sign upward turn, `left_domain` at `8.4755 T`, only
  `12.2107 L` minimum distance, and roughly tenfold force/moment peaks.  Wake
  organization or frozen-trace correlation alone is not causal evidence for
  adding the flow cue to route rates or direct actuation.

## One-candidate policy hypothesis

Materialize the completed v38 controller as the single candidate.  Preserve
the state-feedback traveling wave, posterior lag, raw large-error redirect,
geometry-released bearing-divergence recovery, mean-preserving whole-wave pose
projection, head-only route-rate correction, raw half-cycle steering,
response-released cadence, approach scheduling, carrier-first rejected-head-
steering spillover, and componentwise acceleration bounds.  Relative to the
prefilled geometry-only policy, add only the evaluated multisensory pose law:
normalize absolute local body-frame crossflow, pass it through a smooth
band-pass confidence that vanishes at zero flow and yields for large
disturbance-like flow, multiply it by de-meaned observed anterior-joint phase,
and add the bounded odd term only to proportional gait-pose rejection.

The new rollout should reproduce capture no later than `18.24 T`, observed
distance integral no greater than `1.400 L`, the checkpoint-wide closure lead,
and the `0.952/41.6%/0.03068/0.01579` speed/saturation/force/moment envelope,
while producing readable top-down and oblique evidence.  Falsify the transfer
if capture or broad-route closure regresses toward the `18.403 T` base, the
flow term introduces one-sided route bias or wake degradation, or the physical
envelope materially worsens.  Formal CFD occurs only after worker exit; no
same-worker outcome is claimed.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: separate persistent target geometry from fast local crossflow and admit only the smallest flow feedback coherent with observed locomotor phase
transferable_invariant: normalized body-frame flow can refine gait-pose sensing when confidence is bounded, phase-odd, and decreases once the signal becomes disturbance-like
nontransferable_details: published gains, species kinematics, clocked CPG phase, dimensional flow scales, exact vortex phase, cylinder-wake synchronization, full-body envelopes, and prescribed routes
policy_translation: apply a smooth band-pass to absolute local body-frame crossflow, multiply it by de-meaned anterior-joint phase, and add the bounded odd term only to proportional whole-wave pose rejection in the two-joint state-feedback contract
falsification: reject if the earlier capture and checkpoint-wide closure lead do not reproduce, if readable two-view evidence shows wake degradation, or if speed, saturation, normalized force, or yaw moment materially exceeds the completed envelope

## Evidence boundary

All numerical and visual outcome claims above come from completed sampled CFD,
the assigned parent, and inherited logs.  The candidate copied into `solver/`
will be formally reevaluated after this worker exits.

## No-CFD implementation audit

- The candidate SHA-256 is
  `bbe6ffbb32f9b95da3e575b44339c76746fcfd3d6d1420e7e7abed5983317d2a`
  and is byte-identical to the completed sampled v38 policy.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its exact three commands were then run
  locally and separately: the material-guidance check, lightweight Julia
  policy contract, and solver editable-boundary check all pass.
- No formal CFD was run in this workspace.

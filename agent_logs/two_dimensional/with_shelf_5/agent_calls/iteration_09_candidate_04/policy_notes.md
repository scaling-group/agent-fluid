# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the common held fish above and downstream of
four mature, interacting cylinder wakes.  It is fixed initial-condition
evidence, not a policy difference.  The released sheets for the three
byte-identical incumbent samples show an immediate correct-sign redirect, a
coherent posterior traveling wake, and a compact upstream-left diagonal into
the target.  Each reaches the `0.75L` boundary after `43.9505`, with `2.1391L`
mean distance.  Mean fish velocity `(-0.2471,-0.1020)` versus mean local flow
`(-0.1342,-0.1556)` confirms that upstream closure includes substantial
self-propulsion rather than passive advection.

No current sampled solver is a semantic failure.  The informative
non-improving sample keeps the same direct topology but releases part of the
posterior steering boost inside a small, converging-bearing window.  It reaches
only `0.055` time earlier while mean distance worsens to `2.1406L`, mean command
rises from `1207.8` to `1216.2`, RMS relative crossflow rises from `0.2111` to
`0.2166`, and RMS force/moment rise from `49.44/701.26` to `55.12/764.85`.
Both the incumbent and this release touch both joint-rate and acceleration
caps.  The visually stronger late body/wake excursion therefore agrees with
the load evidence; the tiny arrival change is not a useful improvement.

The inherited optimizer logs strengthen that boundary.  A broader
response-conditioned release reduces RMS force/moment to `36.25/587.15` but
delays capture to `46.6730`; a posterior rate guard reaches in `44.2420` with
`43.46/649.26` loads and still retains cap contact.  Two nested completed
step-8 rollouts add decisive evidence.  Adding a `0.35` normalized anterior-rate
lead to the half-cycle gate retains the direct visual topology but delays
capture to `43.9780`, worsens mean distance and score, raises mean command to
`1209.5`, and raises force/moment to `53.18/736.58`, with all four rate and
acceleration caps unchanged.  An alignment-gated posterior rate guard lowers
force/moment to `44.86/663.89`, but still touches every cap and delays capture
to `44.0220`.  These results rule out both another terminal/rate threshold and
another gain on anterior position-plus-rate phase.

The inherited right-domain and naive-seed exits remain the available semantic
failure contrasts: excessive static curvature suppressed the traveling bend
and exited in `16.7914`, while the target-blind seed was largely advected into
the lower boundary after `50.127`.  The new edit must therefore preserve both
cycle-average curvature and the incumbent carrier rather than increase either
scalar authority.

## Policy hypothesis before the edit

Keep the incumbent anterior oscillator, bounded body-frame bearing command,
posterior boost magnitude, posterior lag, and approach taper.  Change exactly
one mechanism: close the half-cycle allocation around observed posterior
motion instead of advancing a schedule derived from the anterior joint.  The
gate uses negative frequency-normalized posterior rate, so for either turn sign
the unchanged posterior bias is applied while the tail is moving away from the
requested curvature and therefore resists the unfavorable half-cycle.  It is
withdrawn while the tail moves into the favored bend.  A symmetric posterior
rate oscillation retains a `0.5` duty fraction and the incumbent's approximate
cycle-average curvature.  No threshold, steering gain, carrier gain, clock, or
wake phase is added.

Expected evidence is retention of the incumbent's direct diagonal and target
success with lower command effort or force/moment than the incumbent and the
failed anterior phase lead, without the arrival loss caused by removing
steering authority.  Reject the mechanism if capture is delayed or lost, the
broad dogleg or an inherited boundary-exit topology returns, force/moment or
cap contact grows without improved progress, or the result is indistinguishable
from the position-only gate.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish asymmetric turning and elongated-body reactive propulsion
source_mechanism: allocate a bounded turning bias by the observed direction of posterior motion within a traveling bend
transferable_invariant: use actual posterior motion to resist the target-opposed half-cycle while preserving the propulsive carrier, steering sign, and cycle-average curvature
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact duty ratios, vortex phases, cylinder coordinates, and task-specific routes
policy_translation: replace the anterior-angle half-cycle gate with a smooth sign-symmetric gate driven by bounded body-frame turn request times negative frequency-normalized posterior joint rate under the two-joint state-feedback contract
falsification: reject if the direct capture is delayed or lost, effort and load do not improve, or force, moment, and saturation increase without better target progress

## Pre-evaluation verification

The required guidance-semantic and solver-boundary checks pass.  Static schema
inspection resolves all `12` direct `params.FIELD` references to the `12`
fields returned by `target_policy_params()`.  A no-CFD sweep over `55,125`
combinations of distance, both bearing signs, joint angles, and joint rates
returns finite actions; the anterior action remains parent-identical, zero
bearing remains parent-identical, the zero equilibrium remains zero, and the
posterior-motion gate both selects the target-opposed rate direction and keeps
a `0.5` harmonic duty with parent-equal peak sharpness.  The prescribed Julia
include/assertion could not start because the cluster's `juliaup` launcher and
a direct pinned-runtime download were both reset by the Julia S3 endpoint; this
is an environment limitation rather than a detected policy failure.  No formal
CFD was run, so the candidate's performance remains a hypothesis for the
post-worker evaluation.

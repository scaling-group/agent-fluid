# Multi-wake target-policy candidate notes

## Inherited and sampled evidence

- The assigned parent established a direct target-bearing carrier and records
  three excluded refinement families: terminal localization made a useful
  rate projection inert, beat-phase selectors were dominated, and the
  inherited alignment-conditioned amplitude reduction worsened arrival and
  loads. The latter still captured, but moved arrival from `43.9505` to
  `44.8525`, mean distance from `2.1391L` to `2.1708L`, and RMS force/moment
  from `49.44/701.26` to `69.92/948.62` while both actuator caps remained
  active. A nominal amplitude reduction is therefore not a load-control
  mechanism on this saturated nonlinear carrier.
- Two sampled policies reproduce the unguarded carrier exactly: capture at
  `43.9505`, mean distance `2.1391L`, RMS relative crossflow `0.2111`, RMS
  force/moment `49.44/701.26`, command energy `53082.6`, and power proxy
  `3944.0`. Their active upstream component is evidenced by mean velocity
  `(-0.2471,-0.1020)` versus mean local flow `(-0.1342,-0.1556)`.
- The assigned prefill's circular half-history bearing filter is a semantic
  route improvement rather than a load improvement. It reaches at `41.5030`
  with mean distance `2.0216L`, but raises RMS crossflow to `0.2246`, RMS
  force/moment to `61.80/862.48`, command energy to `53802.7`, power proxy to
  `4074.6`, and maximum joint excursions from `0.525/0.452` to
  `0.579/0.527` rad. Both joint-rate and acceleration caps remain reached.
- The distinct sampled directional rate guard supplies compatible positive
  evidence on the unfiltered carrier. It preserves the exact `43.9505`
  capture, while reducing RMS crossflow to `0.2093`, force/moment to
  `44.47/657.47`, command energy to `52868.1`, and power proxy to `3889.8`.
  It projects away only near-cap acceleration that drives a joint farther
  outward after alignment; every rate reversal remains unchanged. Its
  compatibility with the faster history-filtered route is not yet evaluated.

## Evidence-first visual diagnosis

The common held-fish sheet shows the fish above and downstream of four mature,
interacting cylinder streets; it is shared initial-condition evidence only.
All current released sheets show a decisive downward-left redirect followed by
a compact upstream-left transit through the wake corridor and first crossing
without collision, domain exit, or repeated route-scale yaw reversal. The
history-filtered prefill retains that useful topology and visibly develops a
strong alternating body wake; its earlier arrival agrees with the distance and
velocity diagnostics, while the larger force, moment, crossflow, and joint
excursions show that the speedup did not reject the fast wake response. The
directional guard's sheet is visually indistinguishable from the carrier at
six-frame resolution, so its unchanged arrival and lower integrated load
metrics are the decisive evidence. No sampled solver is a semantic failure;
the inherited amplitude-transition rollout is the most informative
mechanism-level negative comparison and likewise agrees between its larger
terminal excursion and worsened diagnostics.

## Policy hypothesis before the edit

Keep the prefill's faster circular-history target signal, target-bearing mean
curvature, target-favored joint-state half-cycle, lagged posterior target,
approach taper, and oscillator unchanged. Add the sampled alignment-gated
directional rate projection after both raw joint accelerations are formed.
Use the filtered body-frame turn request for the alignment gate, and use only
observed joint-rate magnitude and direction for the response gate. This is one
small compatible combination: route geometry remains owned by the history
filter, while the guard acts only when an aligned joint is near its physical
rate envelope and the requested acceleration would push it farther outward.

Expected evidence is retention of the prefill's direct topology and
`41.5`-class capture with lower crossflow, force, moment, effort, joint
excursion, or cap-contact evidence. Falsify the combination if capture is lost
or materially delayed, the redirect/trajectory topology changes, reversals are
clipped, or the load and saturation evidence fails to improve. In that case,
do not tune the history blend, rate threshold, or alignment threshold; the
completed evidence would show that the two individually useful mechanisms do
not compose on this carrier.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake-interaction studies
source_mechanism: preserve a useful rhythmic carrier and apply the smallest response-conditioned intervention instead of cancelling all lateral wake motion
transferable_invariant: distinguish persistent body-frame route control from fast actuator response, and suppress only action that deepens an observed envelope excursion while preserving reversals
nontransferable_details: published gains, robot or species kinematics, clock phase, exact vortex phase, cylinder coordinates, history length, and task-specific routes
policy_translation: retain the circular-history bearing route command, then gate a directional outward-acceleration projection by filtered alignment and normalized joint-rate proximity to the owned envelope
falsification: reject if direct capture degrades, reversal action changes, or force, moment, effort, excursion, and cap evidence do not improve over the history-filtered prefill

## Pre-evaluation verification

The required guidance semantic check and solver boundary check pass. Static
schema comparison found all `16` direct `params.FIELD` references among the
`16` fields returned by `target_policy_params()`, with no unused field and no
policy-owned time, step, random, case, cylinder, world-route, or remote-flow
observation. An algebraic sweep of `70000` states spanning approach range,
wrapped and empty bearing histories, both bearing signs, both joint limits,
and both rate limits returned finite actions with all smooth gates in `[0,1]`.
All `95064` reversal cases were exactly unchanged, as were both raw joint
actions in all `90000` large-error action cases. The prescribed Julia
include/assertion was attempted independently by the check runner but could
not start because this workspace has no `julia` executable. No formal CFD was
run; the proposed composition remains a hypothesis for post-worker evaluation.

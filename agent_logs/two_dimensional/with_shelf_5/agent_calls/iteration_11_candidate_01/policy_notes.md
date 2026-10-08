# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the common held fish above the fully developed,
  interacting four-cylinder streets; it is an initial condition, not evidence
  for one controller.
- Three byte-identical incumbent policies and released keyframe sheets show the
  same useful topology: a strong correct-sign redirect immediately after
  release, followed by a direct diagonal approach through the wake and capture
  at `43.9505`. Their common `2.1391L` mean distance and
  `0.2111/49.44/701.26` RMS crossflow/force/moment make this the carrier to
  preserve.
- The sampled velocity-led half-cycle gate retains the route and capture at
  `43.9780`, but increases RMS crossflow/force/moment to
  `0.2136/53.18/736.58`; its late sheet also shows a somewhat stronger
  tail-wake disturbance. The phase lead is therefore a concrete degraded
  comparison, not a reason to shift the joint-angle half-cycle gate.
- Both sampled policies reach the `260 deg/time` joint-rate and
  `1800 deg/time^2` acceleration envelopes. In inherited optimizer logs, the
  direction-aware posterior rate projection instead repeats capture at
  `44.0220` and `2.1418L` mean distance while reducing RMS force/moment to
  `44.86/663.89`. Multiple inherited artifacts reproduce those metrics.
- No sampled solver example in this workspace has a failure keyframe. The
  assigned-parent seed failure remains the failure-class comparison: it was
  advected through the lower boundary without a recovery turn. The present
  direct carrier has already removed that topology, so a new route or stronger
  redirect is not indicated.

## Candidate hypothesis

Keep the incumbent oscillator, body-frame bearing command, joint-angle
half-cycle asymmetry, and terminal envelope unchanged. Add only a smooth,
direction-aware projection on posterior acceleration: once absolute posterior
rate approaches its owned envelope and body-frame bearing is small, remove the
fraction of acceleration that pushes the rate farther outward. Reversal
acceleration and all large-bearing redirect authority remain untouched.

This is a controller mechanism rather than a gain sweep. It should preserve
the direct capture topology and nearly unchanged arrival while reproducing the
inherited distributed load reduction. It does not claim to prevent peak caps.
Reject the mechanism if evaluation loses direct capture, materially delays
arrival, weakens a reversal, or fails to lower force/moment loads.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and adaptive wake swimming
source_mechanism: bounded state-feedback modulation around a rhythmic carrier while preserving rather than cancelling useful wake motion
transferable_invariant: retain the proven traveling-bend carrier and intervene only where an observed state identifies unnecessary outward actuation
nontransferable_details: published gains, species-specific kinematics, dimensional frequencies, exact vortex phases, and source-task routes
policy_translation: smoothly project only outward posterior acceleration using observed joint rate and normalized body-frame bearing; preserve reversals and large-error steering
falsification: reject if direct capture is lost or delayed materially, reversal is weakened, or RMS load reduction does not reproduce

## Pre-evaluation verification

The guidance semantic/provenance check and solver editable-boundary check pass.
Static schema inspection found all `15` direct `params.FIELD` references among
the `15` fields returned by `target_policy_params()`, with no missing or unused
declaration. The candidate SHA-256 is byte-identical to the same rate-projection
implementation in evaluated artifacts from three sampled optimizer branches.
The configured Julia include/assertion could not run because this environment
has no `julia` executable; this is a verification limitation, not a passed
runtime assertion. No formal CFD was run.

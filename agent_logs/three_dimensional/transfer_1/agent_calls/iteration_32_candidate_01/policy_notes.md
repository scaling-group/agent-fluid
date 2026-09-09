# Step 32 target-policy diagnosis

## Evidence read before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and capture at
  `0.7466--0.7494L` after `18.199--18.749T`. Their combined sheets show
  released-swimmer advance, an organized alternating top-down vorticity
  street, bilateral oblique Lambda2 structures, and an active beat at capture.
  The useful mechanism is the posteriorly lagged traveling bend; none of the
  captures is advection or terminal coasting.
- The two exact sampled speed-reserve rollouts capture at `18.320T` and
  `18.601T`, with head/tail action clipping near `68.5--68.7%/70.6--70.7%`,
  speed-limit residence near `10.4--10.6%/11.3--11.6%`, and peak normalized
  force/moment magnitudes near `0.031/0.016`. Inherited evidence adds one more
  capture and two lower exits, so these bytes are useful but only `3/5`, not a
  robust terminal solution.
- The sampled posterior wave-shape pulse captures at `0.7480L` and `18.199T`,
  but inherited exact-policy evidence records a later lower exit at `1.2589L`;
  its `2/3` record and unchanged actuator/load envelope do not support keeping
  that extra terminal phase mechanism.
- The assigned parent is the required exact repeat of the previously
  successful burden-conditioned allocator. Both visual rows retain the active
  alternating wake and the fish remains self-propelled, but it joins the lower
  branch, reaches only `1.8544L`, and exits at `31.3665T` with final distance
  `10.1364L`. Its action clipping (`70.2%/72.2%`) is higher than the sampled
  speed-reserve captures. Combined with the inherited `0.7474L` allocator
  capture, the mechanism is now `1/2` and fails its own repeat criterion.

## Candidate hypothesis

Restore the exact intercept-guarded speed-reserve candidate represented by
both sampled baseline files. Remove the prefilled posterior wave-shape pulse
and do not retain the parent's actuator-burden steering transfer. This is a
mechanism rollback, not scalar gain tuning: it preserves the demonstrated
traveling carrier, raw achieved-course servo, intercept veto, additive steering
allocation, and sparse outward-carrier relief while removing two terminal
mechanisms that failed exact repeats.

Expected result: return to the repeat-backed capture envelope without weakening
either wake view or increasing the sampled load/actuator envelope. The current
candidate is still falsified by a lower exit, a closest pass outside `0.75L`,
loss of the active terminal beat, or materially worse clipping, speed-limit
residence, force, or moment. A capture would restore the evaluated baseline but
would not by itself establish robustness beyond the inherited `3/5` record.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and sensor-modulated robotic-fish control
source_mechanism: retain a posteriorly lagged traveling bend and accept feedback additions only when observed response improves the task
transferable_invariant: preserve the active posterior propulsive wave while removing terminal residuals that fail repeat evidence
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waves, exact vortex phases, and task-specific routes
policy_translation: restore the normalized body-frame achieved-course and intercept controller with its state-conditioned carrier reserve, without the failed phase pulse or actuator-burden allocation
falsification: reject as robust if another exact rollout misses, follows the lower branch, weakens either coherent wake, or leaves the sampled load and actuator envelope

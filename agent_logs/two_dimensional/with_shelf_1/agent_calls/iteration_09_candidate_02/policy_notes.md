# Wake Policy Candidate Notes

## Visual and metric diagnosis before editing

The shared prewarm sheet shows the fish held above and downstream of four
fully developed, interacting vortex streets.  The wake phase and layout are
common to all candidates, so only released motion distinguishes policies.
Every current sampled released sheet reaches the target.  The fish makes a
sharp clockwise redirect, then actively propels leftward through the merged
wake with a coherent posterior vortex trail; its roughly `(-10.91,-4.2)L`
head displacement and mean upstream velocity near `-0.298` are inconsistent
with passive advection.  No sampled sheet supplies a collision or domain-exit
contrast.

The assigned parent is the distance-scheduled half-cycle policy evaluated as
`solver_2b2a5132e4fe`.  Compared with three deterministic evaluations of the
constant-asymmetry sibling, its route sheet is visually indistinguishable and
its metric changes are very small: arrival `36.4705 -> 36.4540`, total command
energy `48700.1 -> 48678.8`, RMS force `63.586 -> 63.254`, and RMS moment
`953.415 -> 950.583`, while mean distance slightly regresses
`1.68603L -> 1.68617L`.  A distance gate that begins at `2.25L` therefore has
little time to act before first crossing of the `0.75L` capture radius.  The
stronger durable result remains the half-cycle mechanism itself: relative to
the course-slip/raw-bearing allocator, it improved arrival
`45.727 -> 36.471` and mean distance `2.0543L -> 1.6860L`, at the cost of
higher mean effort and RMS force/moment.  Both joints touch the `4.5379`
speed and `30.0` acceleration limits.

The inherited failures constrain the next change.  A recent-bearing-trend
residual failed to establish upstream propulsion and exited right after
`18.304` with negative progress.  A direct relative-crossflow residual still
captured, but regressed arrival and mean distance and increased force/moment
relative to its decoupled parent.  Those results do not support another signed
wake or error-derivative term.  The validated carrier, mean steering sign,
course-slip role, raw-bearing reserve, and acceleration envelope remain
unchanged.

## Candidate hypothesis

Retain the parent's complete route controller and add one response-gating
mechanism only to the extra half-cycle asymmetry.  Normalize each observed
joint speed by the carrier's own `omega * amplitude` velocity scale.  As a
joint consumes that response scale, smoothly release part of the extra
half-cycle bias while leaving the propulsive carrier, mean steering, and raw
bearing-owned reserve active.  This targets the observed speed-limit contact
without suppressing the target-directed route or adding a clock, fixed
coordinate, exact vortex phase, or another signed disturbance residual.

Expected test: retain target capture and the coherent redirect/upstream
traverse while improving at least one of the parent's `1335.35` mean command
energy or `63.25/950.58` RMS force/moment, without regressing arrival beyond
the `45.727` pre-half-cycle baseline.  Reject the mechanism if capture is
lost, the initial redirect or posterior wake collapses, arrival gives back the
half-cycle advantage, or response gating provides no effort/load benefit.
The candidate receives CFD evaluation only after this worker exits, so no
same-worker outcome is claimed.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish closed-loop CPG asymmetric turning
source_mechanism: release bounded asymmetric turning authority when measured joint response appears while preserving the rhythmic carrier and persistent route request
transferable_invariant: observed response may gate only the extra steering burst; persistent body-frame target geometry must retain mean authority and the traveling bend must remain active
nontransferable_details: published gains, dimensional joint speeds, robot hardware, species kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: normalize each joint velocity by the candidate-owned oscillator velocity scale and smoothly reduce only its additional half-cycle asymmetry as normalized response becomes large
falsification: reject if capture or coherent upstream propulsion is lost, arrival exceeds the pre-half-cycle baseline, or neither mean effort nor force/moment improves over the evaluated parent

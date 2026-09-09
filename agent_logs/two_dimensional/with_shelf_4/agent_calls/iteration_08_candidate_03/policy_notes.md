# Multi-wake candidate diagnosis

## Evidence read before the edit

- The sampled held-fish sheet shows the common developed initial condition:
  four interacting vortex streets already occupy the target corridor while the
  fish remains upstream/right of the cylinder array.  It is not evidence for
  a candidate-specific phase choice.
- The two `-2.241758` samples are duplicate evaluations of the same strongest
  finite policy, and the two `-2.408379` samples are duplicate evaluations of
  the slower prefill policy.  Both released sheets show a self-propelled,
  alternating traveling bend and a broad targetward route through the wakes;
  neither shows collision, domain exit, loss of the alternating wave, or a
  last-frame near miss.
- Qualifying bearing-window-rate feedback by positive closing progress is the
  only code difference between those policy pairs.  It shortens capture from
  `149.61` to `137.36`, improves mean distance from `4.358L` to `4.184L`, and
  lowers RMS force/moment from `15.49/308.48` to `14.75/303.02`.  It raises
  mean command energy slightly (`647.93` to `656.89`), so the supported claim
  is a more useful route response, not free efficiency.  Its maximum anterior
  acceleration is already `30.85 rad/time^2` against a `31.42` limit.
- The assigned parent's inherited step-7 sibling still captures, but later at
  `149.85`, with worse mean distance (`4.423L`), mean command energy (`671.58`),
  and RMS force/moment (`15.58/312.62`) than the strongest sample.  Together
  with the parent lesson, this is a boundary against treating extra heading or
  moment gating as an improvement merely because success survives.
- No failed rollout keyframe folder is present in the sampled solver set.  The
  quantified seed/static-bias failure topology is therefore used only from the
  inherited parent guidance: it motivates preserving half-cycle steering, but
  it is not claimed as a newly inspected visual comparison.

## Candidate hypothesis

Start from the strongest sampled closing-progress-qualified controller.  Add
one weak, bounded route observation before the existing half-cycle steering:
the normalized body-frame lateral target displacement.  Bearing supplies the
directional error, while absolute lateral displacement distinguishes the same
bearing far from the target from the same bearing near capture.  The residual
should strengthen correction of the visible broad far-field zigzags and fade
continuously on approach, without changing oscillator period, propulsive
amplitude, posterior lag, the direct moment residual, or the zero-mean
half-cycle mechanism.  This is an observation/feedback-structure test, not a
scalar-only gain change.

The candidate is falsified if it loses target capture or upstream translation,
does not improve the `137.36` arrival / `4.184L` mean-distance route, worsens
the `14.75/303.02` load pair, increases already near-cap anterior acceleration,
or merely reproduces the same broad zigzag topology.  Because its CFD result
will be available only to a later worker, no improvement is claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: bounded sensory modulation of rhythmic left/right flapping asymmetry
transferable_invariant: a slow body-frame target-vector error can modulate beat asymmetry while the zero-mean propulsive rhythm and posterior lag remain intact
nontransferable_details: published gains, robot geometry, clock phase, species kinematics, exact vortex phase, and any task-specific route
policy_translation: add a softly saturated normalized lateral-target residual to the progress-qualified bearing request, then use the existing joint-state half-cycle asymmetry
falsification: reject if capture, upstream displacement, alternating bends, distance/load gains, or acceleration margin are lost

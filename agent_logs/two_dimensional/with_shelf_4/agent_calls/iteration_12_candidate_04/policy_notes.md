# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting cylinder wakes. This is a common release
  condition, not a transferable vortex phase or a reason to encode a route.
- All four sampled solvers reproduce one semantic policy and one released
  keyframe sheet (the two source hashes differ only in comments). The fish
  actively redirects, retains an alternating posterior-lagged bend, crosses
  the mixed wake from the right, and captures after `137.357` released units.
  The matching metrics are `4.18356L` mean distance, `-10.9139L` upstream head
  displacement, `90228.38` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/force/moment. Mean body speed
  in x (`-0.0791`) exceeds the magnitude of mean local-flow x (`-0.0542`), so
  this is self-propelled progress rather than passive advection. Joint-1
  acceleration already reaches `30.846 rad/time^2` against the `31.416` cap;
  more anterior authority or scalar gait gain is unsupported.
- Inherited one-change results show that removing authority from this scaffold
  is fragile. Gating the direct moment residual by growing absolute bearing
  retains capture but delays it to `149.490`, raises mean distance to
  `4.428L`, energy to `97418`, and RMS force/moment to `16.38/318.46`.
  Relieving the bearing-owned turn by at most `30%` during a closing near
  approach reaches `1.796L` but then folds away and exits the top boundary at
  `243.447`, with `161191` energy and joint-1 acceleration at its cap. Thus
  neither temporarily improving bearing nor proximity plus closure is evidence
  that the established route or load loop can be suppressed.
- The most relevant actuator-coordination failure multiplies the complete
  posterior traveling-wave target in the same half-cycle direction as the
  anterior steering envelope. Its keyframes show repeated large loops above
  and below the useful wake corridor; capture is delayed to `279.439`, mean
  distance rises to `6.982L`, energy doubles to `182836`, mean upstream body
  speed falls to `-0.0389`, and joint-2 extrema rise to `0.387 rad` and
  `28.29 rad/time^2`. Spare posterior headroom therefore does not justify
  same-sign posterior amplification.
- The successful sheet still shows course kinks, while the failed posterior
  multiplier identifies a sign/topology issue rather than insufficient total
  actuation. This supports testing curvature redistribution across the two
  joints, not another observation residual, steering relief, or gain increase.

## Policy hypothesis

Make exactly one mechanism change from the reproduced scaffold: add a small
opposite posterior half-cycle modulation. When target and wake feedback make
the active anterior half-cycle stronger, slightly reduce the magnitude of the
oppositely directed lagged posterior target; on the other half-cycle the
posterior magnitude increases by the same bounded amount. This should increase
the requested distributed curvature without adding a static bend or scaling
both joint waves together. The multiplier stays positive, returns to one when
either turn request or joint-state beat side vanishes, and preserves the base
posterior phase lag and zero-mean alternating propulsion.

Keep instantaneous body-frame bearing as route owner, progress-qualified
bearing-rate damping, the continuously active normalized moment residual, the
anterior oscillator and its evidenced half-cycle asymmetry, and all base gait
parameters unchanged. The formal test is retained capture and upstream
translation with fewer route folds, earlier arrival or lower mean distance,
and no increase in effort, load, or cap contact. Falsify the candidate if the
opposite posterior modulation delays or loses capture, creates a loop or
boundary exit, weakens the alternating traveling bend, reduces upstream
speed, or worsens distance, energy, crossflow, force, moment, or saturation
against the reproduced `137.357` baseline. CFD runs only after this worker
exits, so these are expectations rather than same-worker evidence.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and elongated-body distributed-curvature propulsion
source_mechanism: create target-directed turning through bounded asymmetry across a traveling bend while retaining posterior lag and alternating propulsion
transferable_invariant: steering authority depends on the relative curvature distribution across the two joints, so a useful anterior half-cycle need not be amplified in the same direction at the oppositely phased posterior joint
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve normalized body-frame route and moment feedback plus the state-inferred anterior half-cycle oscillator, and apply a small positive multiplier `1 - posterior_countersteer_gain * turn_request * beat_side` only to the existing lagged joint-2 target
falsification: reject if capture, upstream translation, or the alternating wave is lost, if the route develops the inherited same-sign loops, or if arrival, distance, effort, loads, or actuator-cap contact fail to improve together over the reproduced baseline

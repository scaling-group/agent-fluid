# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
  instability. Their combined sheets show self-propulsion, an alternating
  top-down caudal wake, and compact three-dimensional Lambda2 structures. The
  failure is route control rather than passive advection or loss of drive.
- The four candidates retain the inherited long southwest trajectory and
  terminate at the lower virtual boundary. Symmetric large-bearing tail relief
  reaches `4.233L`; adding a strong anterior phase-selective redirect reaches
  `4.018L`; redistributing posterior carrier authority by observed half-stroke
  reaches the best closest approach, `3.909L`, and the longest episode,
  `32.64T`. The prefilled anterior redirect without tail relief regresses to
  `4.859L` and exits at `28.74T`. None changes the termination class.
- The closest sample preserves the staggered wake and reduces distance until
  `19.94T`, so its anterior center, zero-static-mean lagged tail, bearing-gated
  carrier relief, and joint-rate half-stroke discriminator are the strongest
  available gait scaffold. Its improvement is narrow: pooled rate-cap and
  acceleration-command-limit occupancy remain substantial, and the same
  lower-exit topology survives.
- Every sampled controller uses `state.bearing`, whose adapter computes
  `atan(target_body_y, max(abs(target_body_x), 0.25L))`. That acute-angle fold
  is faithful only while the target remains in front of the head (negative
  body x). In the three tail-relief descendants, the target crosses to positive
  body x just after closest approach; the folded bearing then falls from about
  `1.5 rad` to `0.11--0.20 rad` by exit even though the full head-relative
  angular error `atan(target_body_y, -target_body_x)` has grown to about
  `2.9 rad`. Thus the controller interprets a passed, rearward target as
  renewed alignment, releases posterior relief, and cannot express a recovery
  turn. The prefilled trace has the same semantic mismatch (`0.98 rad` folded
  versus about `2.16 rad` full at exit).
- Inherited logs establish the boundary for this edit: global shared or
  tail-biased curvature centers regressed badly, response-unloading could
  quench the autonomous oscillator, and scalar changes to tail relief or
  phase-selective forcing repeatedly preserved the lower exit. The new test
  therefore changes the target-error semantics, not another gain or static
  joint equilibrium.

## One candidate hypothesis

Start from the `3.909L` posterior half-stroke-redistribution policy and make
one semantic change: derive steering and relief from the full signed
head-relative angle
`atan(state.target_body_L[2], -state.target_body_L[1])`. The negative body-x
axis is the head direction for this model. Before the target passes abeam this
equals the prior bearing, so the evidenced early wake, approach, and
closest-approach behavior should be preserved. After a miss it continues to
represent the target behind the head, keeping the bounded anterior center and
posterior relief/asymmetry active until genuine alignment rather than releasing
them because of the axial fold.

The falsifiable semantic expectation is a trajectory recovery after the first
pass: the fish should retain the coherent early wake and roughly the `3.909L`
approach, then avoid or materially delay the repeated lower-boundary exit while
the full angular error decreases. Reject the mechanism if wake coherence or
the early approach degrades, saturation or loads worsen materially, the policy
still exits low without reducing full target error, or the `atan` branch near
an exactly rearward target causes unstable turn-direction chatter.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and biological burst redirection
source_mechanism: use full target-relative heading error to sustain a bounded redirect until observed alignment releases it back toward cruise
transferable_invariant: target-feedback modulation must distinguish a target ahead from one passed abeam or behind, and release redirect authority only on true body-frame alignment
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, prescribed C-start timing, exact vortex phase, and task-specific routes
policy_translation: compute the signed angle from normalized body-frame target components with the model head on negative body x, then use it in the existing slip-aware curvature and posterior half-stroke-relief scaffold
falsification: reject if early wake/progress is lost, actuator or load behavior worsens, rear-target error fails to decrease, the lower exit persists unchanged, or the rear-axis angle branch causes chatter

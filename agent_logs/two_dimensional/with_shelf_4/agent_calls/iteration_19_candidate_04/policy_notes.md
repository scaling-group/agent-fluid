# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting cylinder wakes.  The merged streets already occupy
  the target corridor at release, so their exact phase is common initial-
  condition evidence rather than a transferable timing or route signal.
- All four sampled solver directories are deterministic copies of the same
  finite success.  Their released sheets are byte-identical and show active
  upstream swimming through a broad targetward arc, an alternating posterior-
  lagged bend, and a sharp final correction inside the merged wake before
  capture.  The matching metrics are `123.018` released units, `3.5936L` mean
  distance, `95084` command energy, and `0.1429/17.03/334.45` RMS relative
  crossflow/force/moment.  The `-11.041L` streamwise head displacement against
  only `-0.0630` mean local streamwise flow confirms self-propulsion rather
  than passive advection.
- The sampled source files have three hashes only because comments and blank
  lines differ; their policy equations, keyframes, and metrics are identical.
  They are one signed-power-guard observation, not independent evidence.
  Diagnostics show that it lowers both-joint peaks relative to the inherited
  unguarded response, but anterior acceleration still touches the
  `31.416 rad/time^2` cap.
- No sampled semantic failure is available.  The most informative inherited
  mechanism failure is the completed course-alignment stack: it preserves
  capture and the alternating bend but visibly prolongs midcourse reversals,
  delaying arrival from its `135.019` parent to `162.222`, worsening mean
  distance from `3.685L` to `4.433L`, and raising energy from `110448` to
  `136964`.  This rejects another route residual or scalar rescue on the
  current action-response scaffold.

## Policy hypothesis

Preserve the replicated body-frame bearing route loop, closing-qualified
bearing-rate damping, direct moment residual, state-inferred half-cycle
steering, posterior lag, and signed-power-guarded two-joint action response.
Add one continuous approach-envelope mechanism: reduce the oscillator's
reference amplitude modestly only when normalized target distance is small and
positive windowed closing speed confirms useful approach.  Far from the target
or whenever approach stalls, the proven cruise amplitude returns continuously;
relative half-cycle steering remains intact and no clock, stage, wake phase,
or fixed success radius is introduced.

This should preserve the sampled early redirect and upstream route while
reducing late command effort, anterior cap contact, and the sharp terminal
correction visible in the strongest sheet.  Falsify it if capture, roughly
`-11L` upstream translation, or the alternating posterior wave is lost; if
arrival or mean distance regresses beyond `123.018/3.594L`; if the fish coasts
or stalls outside capture; or if effort, load, and acceleration-cap contact do
not improve jointly.  Formal CFD occurs after this worker exits, so this is an
unevaluated mechanism test rather than a claimed result.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive wake swimming
source_mechanism: sensory feedback continuously modulates rhythmic propulsion between cruise and approach while retaining the coupled propulsive wave
transferable_invariant: propulsion relief should be earned from normalized target proximity and measured positive closure, and should vanish when targetward translation stalls
nontransferable_details: published gains, servo constants, species-specific envelopes, dimensional distances and beat settings, exact vortex phases, cylinder layout, success radius, and task-specific routes
policy_translation: multiply the two-joint oscillator reference amplitude by a bounded body-frame-distance and closing-progress envelope while preserving bearing steering, posterior lag, and the signed-power action guard
falsification: reject if capture, upstream translation, or alternating propulsion is lost, if approach stalls or distance and arrival regress, or if effort, loads, and anterior cap contact fail to improve together

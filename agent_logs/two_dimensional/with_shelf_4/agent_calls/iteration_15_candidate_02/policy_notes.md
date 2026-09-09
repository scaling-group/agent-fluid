# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The common prewarm sheet shows the fish held in the upper-right while four
  developed staggered-cylinder streets merge around and downstream of the
  target. This fixes the release flow but does not provide a transferable
  vortex phase, cylinder route, or candidate-specific advantage.
- All four sampled solvers are deterministic copies of one finite success.
  Their released sheet shows active upstream swimming, a persistent
  posterior-lagged alternating bend, a broad lower-midcourse wake crossing,
  and entry into the capture circle from the right after `137.357` released
  units. The matching metrics are `4.18356L` mean distance, `-10.9139L`
  upstream head displacement, `90228.38` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/lateral force/yaw moment.
  Mean local streamwise flow is only `-0.0542`, so the upstream displacement
  and completed diagonal route are not passive downstream advection.
- The released sheet still shows several large course reversals between the
  initial redirect and the final wake-corridor entry. The assigned-parent
  step-11 through step-13 keyframes and metrics are the informative negative
  contrast absent from the sampled set: bearing-divergence gating of moment
  rejection, posterior route half-cycle sharing, and yaw-power gating all
  retain capture but deepen or prolong the midcourse detour. Arrival regresses
  to `149.490`, `196.317`, and `205.519` units, mean distance to `4.428L`,
  `5.718L`, and `6.209L`, and energy to `97418`, `131294`, and `134893`.
  RMS force/moment also exceed the direct-residual baseline in every case.
- Other inherited one-change tests show why actual target-relative motion must
  be separated from raw disturbance measurements. An unconditioned opposing
  relative-crossflow residual delays capture to `154.110` units while barely
  changing RMS crossflow, and a lateral-target residual delays it to
  `159.302`. Circular bearing smoothing and large-bearing tail-lag relief also
  worsen the successful route. The baseline anterior acceleration already
  reaches `30.846 rad/time^2` against the `31.416` cap, so another scalar gait
  increase, unconditioned turn residual, moment gate, or posterior edit is not
  supported.

## Policy hypothesis

Make one feedback-topology change to the replicated `137.357`-unit scaffold.
Preserve instantaneous body-frame bearing as route owner, its
closing-progress-qualified rate damping, the direct normalized moment
residual, state-inferred anterior half-cycle steering, oscillator regulation,
and the unmodified posterior traveling wave. Add a small course-alignment
correction derived from the signed angle between body-frame bearing and the
observed body-velocity direction, but let it act only in proportion to the
existing positive closing-progress gate. This distinguishes target-relative
translation from body rotation and from raw wake crossflow: when the fish is
not closing, bearing retains sole route authority; while it is closing, the
velocity-direction error can reduce the large lateral course folds without
adding a world-frame route or a wake-phase estimate.

The formal expectation is preserved target capture, upstream translation, and
alternating propulsion with fewer midcourse course reversals, earlier arrival
or lower mean distance, and no increase in effort, load, or actuator-cap
contact. Falsify the mechanism if capture is lost or delayed beyond `137.357`,
the lower excursion widens, upstream translation or the posterior wave
weakens, the anterior cap is contacted more often, or distance, energy,
crossflow, force, and moment do not improve together. CFD evaluation occurs
only after this worker exits, so these are expectations rather than claims
about the new candidate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and adaptive wake swimming
source_mechanism: use measured target-relative translational response to modulate a low-dimensional rhythmic steering command while preserving the propulsive wave
transferable_invariant: body-frame heading alignment and targetward trajectory alignment are distinct, so a bounded course correction should earn authority only when measured motion is already closing target distance
nontransferable_details: published gains, robot linkage geometry, dimensional beat settings, species-specific kinematics, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: preserve the two-joint state-feedback half-cycle traveling bend and direct moment residual, then add a small normalized bearing-minus-velocity-direction correction inside the route loop, qualified by positive normalized window closing speed
falsification: reject if course qualification loses or slows capture, weakens upstream translation or alternating propulsion, enlarges the lower excursion, or raises distance integral, effort, loads, or actuator-cap contact relative to the replicated baseline

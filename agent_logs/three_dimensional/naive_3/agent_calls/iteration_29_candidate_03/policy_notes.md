# Wake-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled evaluations use direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), run stably to the `100T` horizon, and show a
  self-propelled fish with a coherent alternating mid-plane wake and coherent
  three-dimensional Lambda2 structures. The late motion is therefore powered
  navigation, not imposed-flow advection or an initialization artifact.
- The inherited response-reserve parent (`solver_951085a20092`) repeatedly
  orbits without capture: minimum/mean/final distance is
  `1.314/4.056/3.077L`. The narrow ahead-side bridge
  (`solver_dc43a1dc563c`) retains the same visible powered loop and reaches
  `1.282/4.119/2.862L`. The terminal course hold
  (`solver_6eb170b0d70a`) is the strongest finite trajectory at
  `1.241/4.158/2.082L`; its top-down and oblique rows retain a coherent wake
  through repeated returns. The anterior burst failure
  (`solver_123b18cedff4`) visibly enlarges and regularizes the orbit and
  regresses to `2.125/3.901/3.601L`, despite remaining stable.
- At the terminal hold's best point (`t=97.092T`, `d=1.241L`), the normalized
  target direction is fully behind and lateral (`forward=-0.855`,
  `lateral=+0.518`), translational course is slightly nonclosing
  (`course_dot=-0.121`), inertial target-ray rate is about `-0.535 rad/T`, and
  measured yaw rate is only `-0.129 rad/T`. The coherent carrier remains fast
  enough to sustain an oversized orbit; the immediate deficit is turn response
  relative to target-ray motion, not absent propulsion.
- The assigned-parent guidance records that three terminal dynamic residuals
  changed the ahead-side first recovery and lost the terminal hold's closest
  and final-distance gains even though frozen replay predicted locality. This
  closes residuals active on both sides of the target crossing and requires an
  effectively zero ahead-side gate for any new dynamic authority. The newest
  inherited optimizer score log likewise remains uncaptured at the horizon
  (`score=-4.481`, minimum/final distance `1.732/2.093L`); because that inherited
  log has no trajectory or wake sheet, it is evidence against a new success,
  not evidence for a more specific control diagnosis.

## Policy hypothesis

Use the sampled terminal course hold as the scaffold. Add one bounded
target-ray-rate versus yaw-rate curvature reserve to both joint equilibria,
scheduled only at near range and only when the normalized target projection is
fully behind. Raising the existing behind weight to the fourth power makes the
new reserve negligible at the evidenced ahead-side first recovery while
retaining it at the late `1.241L` miss. Keeping the state-feedback oscillator,
posterior lag, and existing course hold unchanged should preserve the coherent
propulsive wake; matching the measured clockwise ray rate should tighten the
late return instead of adding another unconditional static bend.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering and biological terminal maneuvering
source_mechanism: sensor-conditioned approach hold that adds bounded turn authority only while measured directional response is deficient
transferable_invariant: preserve the propulsive traveling-wave carrier, condition a compact steering residual on body-relative geometry and measured response, and release it continuously when response matches demand
nontransferable_details: published robot gains, oscillator clocks, species-specific C-start kinematics, exact maneuver phases, and task-specific routes
policy_translation: derive inertial target-ray rate from normalized body-frame target and velocity observations, compare it with measured yaw rate, and add a bounded two-joint equilibrium curvature only for a near target fully behind the body
falsification: reject if the ahead-side first recovery near 2.4L changes materially, minimum distance exceeds 1.241L, the late orbit does not contract toward 0.75L, wake coherence degrades, or command/clamp residence rises materially

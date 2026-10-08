# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- All four sampled solver examples contain the same policy and byte-identical
  trajectory. Each captures from direct uniform still water at `24.310009T`,
  with `0.749162L` crossing distance, `2.223959L` mean distance, 4,420 steps,
  and 282 lossless moving-window shifts. This is deterministic fixed-pose
  repetition, not held-out robustness.
- The complete combined sheet in `solver_43e27134a723` shows a self-propelled
  curved route, a persistent alternating mid-plane wake, and discrete oblique
  Lambda2 structures through capture. Its numerical trace has peak normalized
  planar force/moment `0.031649/0.016385`, anterior/posterior rate-cap
  occupancy about `14.05/6.92%`, and mean action norm about `43.000` inside
  `1.5L`. The other three combined sheets reproduce the top-down row but have
  blank oblique rows; those are render failures, not independent 3D-wake
  confirmation.
- No sampled solver is a policy failure, so a visual strong-versus-failed
  policy comparison is unavailable in this workspace. The inherited numerical
  failure comparison remains informative: direct recent-yaw unloading let the
  gait and wake decay into a coast, while same-sign posterior curvature made
  yaw turn the wrong way. The successful opposite-sign reactive rudder and
  anterior-stroke closing-response relief must therefore remain intact.
- At the successful crossing the target is still strongly lateral in the body
  frame (full error about `1.32 rad`), while the body carries appreciable
  lateral slip and oscillatory yaw. Inside `1.5L`, measured hydrodynamic moment
  is target-turn-aiding on about `47.8%` of samples, with mean aiding magnitude
  about `0.00550`; peak moment remains `0.016385`. That supplies an observed,
  normalized signal for testing allocation rather than another distance or
  closing-speed threshold.
- The assigned-parent inherited score-only completion
  `solver_8a3735997526` also captures but scores `-0.325183807` with a
  `0.749193L` crossing, slightly behind the sampled `-0.325171575` baseline.
  Because that inherited log contains neither the candidate nor multimodal or
  trajectory evidence, it cannot support a causal mechanism claim.

## Policy hypothesis

Keep the full-angle carrier, anterior redirect, posterior reactive-rudder
sign, and the reproduced target-side anterior-stroke closing-response relief.
Add one small reflection-equivariant hydrodynamic allocation mechanism: form
the product of requested turn sign and normalized measured yaw moment, and on
the existing useful anterior stroke relieve posterior rudder only when that
moment already aids the requested yaw. Do not boost rudder when the moment
opposes the turn and do not unload the traveling carrier. This should avoid
spending posterior mean load against helpful fluid torque while leaving the
pre-rudder route and return-stroke authority unchanged.

The candidate is falsified if it fails to capture by `24.310009T`, exceeds
`2.223959L` mean distance, changes the route before the existing proximity
gate, or worsens the alternating wake, `14.05/6.92%` rate-cap occupancy,
near-target effort, or `0.031649/0.016385` force/moment envelope. A numerically
neutral result also falsifies the measured-moment residual as useful on this
fixed approach; later workers should then preserve the baseline rather than
tune the residual's scale or ceiling.

bookshelf_consulted: true
source_domain: wake interaction and closed-loop robotic-fish rhythm modulation
source_mechanism: retain a propulsive carrier while using measured fluid load to avoid cancelling helpful wake-induced motion
transferable_invariant: allocate only the smallest bounded residual needed around an intact traveling carrier, and preserve measured target-aiding fluid response
nontransferable_details: organized Karman-street phase, species kinematics, published CPG gains, dimensional frequencies, and source-task routes
policy_translation: use the reflection-invariant product of normalized body-frame target-turn sign and `moment_z_L2` to relieve only redundant posterior rudder on the observed useful anterior stroke
falsification: reject if capture is later than 24.310009T, mean distance exceeds 2.223959L, or preterminal route, wake, saturation, effort, force, or moment worsens

# Rearward-response burst-redirect candidate

## Evidence diagnosis before the edit

All sampled evaluations and inherited completed rollouts use the required
direct-uniform still-water initialization with `U_infinity=[0,0,0]`, no
cylinders, and no prewarm. Inspection of the combined sheets shows that the
sampled best-score rollout (`solver_4482d3d05d9c`) and the informative
closure-relief failure (`solver_37a652a3989e`) are self-propelled: both form an
organized alternating top-down vortex street and retain tail-connected
three-dimensional Lambda2 structures. The closer closure-relief path reaches
`4.162L` at `17.506T`, then curves upward and recedes to `6.363L`; the
best-score path reaches only `5.126L` and ends at `5.885L`. Their common upper
exit is therefore a route failure, not wake collapse or passive advection.

The assigned parent's inherited bearing-response release is now a completed
negative result. It keeps the same coherent two-view wake but reaches only
`4.867L`, recedes to `6.013L`, and exits high. Reducing the posterior route
bias while short-window bearing is moving toward center did not recover the
earlier full-wave approach (`3.135L`) and did not change the termination class.
Together with the sampled half-cycle descendants (`4.743--5.000L` minima),
this rules out another release-gate or half-cycle scheduling edit as the next
mechanism.

The inherited actuator-calibrated yaw-response rollout
(`solver_e28fd0b0b625`) contains a stronger semantic result hidden by its
`-9.366` scalar score. Relative to its course-gated precursor's `5.000L`
minimum, mapping posterior curvature to opposite-sign physical yaw reaches
`2.299L` at `18.409T`. The combined sheet retains the alternating planar wake
and three-dimensional tail structures through approach, and the trajectory's
near-soft-limit residence is about `55.0%`, below the sampled `62.1--70.3%`
range. It nevertheless passes the target, recedes to `8.092L`, and exits high
at `28.408T`. At closest approach the target is still forward in body
coordinates (`target_body_L[1]` about `-1L`) and center translation remains
targetward; shortly afterward `target_body_L[1]` becomes positive and the
body-frame radial velocity becomes negative. The existing bearing deliberately
uses `abs(target_body_L[1])`, so it cannot distinguish a target ahead from a
target behind and supplies no separate missed-pass recovery mode.

## Single policy hypothesis

Use the actuator-calibrated yaw-response policy as the evidenced carrier,
including its posterior lag, bounded course redistribution, crossflow
residual, and phase-compatible half-cycle modulation. Add one compact
burst-redirect mechanism to the anterior equilibrium: smoothly activate extra
curvature only when the normalized target vector is in the aft body half-plane
and target-projected translational velocity says the fish is no longer
closing. Derive redirect sign from the full body-frame target angle and map it
through the empirically observed opposite curvature-to-physical-yaw
convention. Keep the posterior endpoint mean unchanged, so the new term
redistributes curvature forward during a missed-pass recovery rather than
replacing the traveling wave or increasing its amplitude.

This state conjunction makes the new mechanism negligible throughout the
evidenced `2.299L` approach and releases it continuously when either target
closure resumes or the target returns to the forward half-plane. The expected
semantic change is a sharper post-pass turn before the prior upper recession,
with preserved transit and wake formation. Falsify it if the gate materially
activates before the closest-approach interval, worsens the `2.299L` minimum,
repeats the high exit without reducing `8.092L` recession, collapses carrier
speed or wake organization, or raises peak planar force, moment, joint-limit
residence, or acceleration-limit residence beyond the inherited yaw branch's
approximately `0.0341`, `0.0175`, `4.538 rad/T`, and `55.0%` levels.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG turning
source_mechanism: retain rhythmic propulsion, apply a strong bounded curvature redirect for a large observed directional error, and release it when directional response recovers
transferable_invariant: a missed-pass redirect should be gated by body-frame target topology and measured radial response, preserve the propulsive rhythm, and disappear when the target is forward or closure resumes
nontransferable_details: published gains, maneuver duration, dimensional beat frequency, species or robot curvature, clocked phase, exact vortex phase, and task-specific routes
policy_translation: preserve the two-joint state-feedback carrier and add bounded anterior curvature only when normalized target-body x is aft and target-projected body velocity is non-closing; use the full target angle only for redirect sign and retain the evidenced curvature-to-yaw sign map
falsification: reject if the redirect perturbs the successful forward approach, destroys the alternating wake, causes the known persistent-anterior-bend speed collapse, increases loads or saturation, or fails to reduce post-pass recession and the upper exit

## Evaluation boundary

The inherited results establish the diagnosis but not the new controller's CFD
outcome. The post-worker evaluation must compare capture and minimum distance
first, then activation timing, post-minimum recession, exit topology, two-view
wake continuity, speed, force and moment peaks, and actuator residence.

## Non-CFD gate audit after the edit

Replaying only the new gate algebra on the completed actuator-calibrated yaw
history gives a maximum gate of `0.0152` before its `18.409T` minimum, equal to
less than `0.12 deg` of added anterior center. The gate first exceeds `0.1` at
`18.574T` and `0.5` at `19.283T`; during clearly aft, receding motion it
requests approximately `7--8 deg` without changing posterior-wave amplitude.
Across the four sampled histories it likewise becomes material only around or
after closest approach; their counterfactual gate values do not claim a new
trajectory. This audit establishes boundedness and localization only. The
formal post-worker CFD rollout must determine hydrodynamic response.

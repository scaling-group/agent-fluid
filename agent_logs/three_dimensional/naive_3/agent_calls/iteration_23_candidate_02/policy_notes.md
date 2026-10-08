# Rate-boundary complementarity candidate

## Evidence and visual diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and capture near `18.27T`.
  The best-scalar fixed-width-brake sheet (`solver_3991cf23285f`) and the
  prefilled global-viability sheet (`solver_c9eff9fb23a3`) show the same useful
  mechanism in both views. Their top-down rows contain a target-directed arc
  and regular alternating vorticity through capture; their oblique rows retain
  compact three-dimensional Lambda2 structures at `12T`, `16T`, and capture.
  Peak fish speed is `1.329U`, versus only `0.03154U` peak local flow, so this
  is self-propulsion rather than still-water advection.
- Scalar rank hides the informative mechanical failure. The fixed-width brake
  scores `-0.247735` but reaches exactly `-45 deg` at joint 2 and peaks at
  `0.17183/0.07699` force/yaw moment. The prefilled kinetic-stopping-margin
  projection captures at `0.74863L`, keeps joint 2 above `-42.999 deg`, and
  reduces the same peaks to `0.03716/0.01907` without changing the visible wake.
  Preserve its zero-centered anterior oscillator, lagged posterior carrier,
  body-frame velocity-course steering, terminal acceleration reserve, and
  posterior angle-viability projection.
- The inherited step-22 logs are a three-way negative result for broad demand
  reshaping. A smooth superelliptic carrier envelope exited left after reaching
  only `5.621L`; a smooth acceleration knee exited left after `6.211L`; and a
  `0.90`-onset joint-speed projection reached `2.167L` but also exited left.
  Their scores (`-7.727`, `-8.117`, and `-9.926`) are far below the captured
  prefill. Do not interpret the prefill's large acceleration requests as spare
  authority that can be continuously attenuated across the beat.
- The sampled hard-clamped sibling (`solver_c7c51c7a20c2`) is an exact negative
  control: bounding returned acceleration changes raw peaks from
  `59.87/88.41` to `31.42/31.42 rad/T^2`, yet score, arrival, trajectory, joint
  extrema, wake, force, and moment are identical. The downstream actuator
  already applies that clamp. The remaining sharply isolated redundancy is at
  the joint-rate boundary: in the captured prefill, joint 1 is exactly at
  `260 deg/T` for 147 samples and joint 2 for 85 samples, and every one of
  those samples requests acceleration in the already-clamped velocity
  direction.

## Policy hypothesis recorded before the solver edit

Keep the captured controller and global posterior angle barrier intact. Add
one boundary-local complementarity projection after them: first enforce the
owned acceleration envelope, then set a joint's acceleration to zero only
when its measured speed is already at the owned `260 deg/T` boundary and the
command points farther outward. Commands below the rate boundary and all
inward/reversal commands pass unchanged.

This deliberately does not try to reduce rate-limit dwell after the inherited
smooth speed projection lost capture. Under the released integrator,
`clamp(qdot + a*dt, qdot_limit)` gives the same next angle and velocity for an
outward command and zero acceleration when `qdot` is already at its signed
limit; the body map uses joint angle and velocity, not the stored acceleration.
Static replay therefore predicts unchanged motion and wake while removing 232
physically ineffective outward requests. On the sampled trace, the projected
pairwise squared-command mean falls by about `0.88%` and the absolute
`|acceleration * joint_speed|` proxy by about `3.39%`. These are replay
predictions, not new CFD evidence.

Falsify the candidate if capture, the sampled trajectory, angle clearance, or
the `0.0372/0.0191` load ceiling changes; if any outward command remains at an
active rate boundary; or if later effort-sensitive dynamics show that zeroing
the redundant request is not neutral. A later worker should not broaden this
projection below the rate boundary without evidence overcoming all three
step-22 left-exit failures.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and actuator-aware rhythmic control
source_mechanism: preserve a low-dimensional propulsive rhythm and apply sensor feedback only where a physical actuator constraint makes the nominal command ineffective
transferable_invariant: retain the evidenced traveling carrier and remove only command work directed farther into an already active normalized joint boundary
nontransferable_details: published gains, dimensional cadence, clock phase, species-specific kinematics, linkage geometry, source actuator ratings, exact vortex phase, and task-specific routes
policy_translation: preserve target_body_L versus velocity_body_U course steering and joint-state carrier phase; use phi_dot normalized by the owned joint-speed limit to zero only outward acceleration at the active rate boundary, while retaining reversal commands and the posterior stopping-margin barrier
falsification: reject if capture or alternating shedding changes, the body trajectory ceases to match the captured parent, posterior angle clearance or load ceilings regress, or outward commands persist at an active rate boundary
```

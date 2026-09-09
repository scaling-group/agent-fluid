# Final-command posterior velocity barrier candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts and the assigned parent's completed rollout use
  direct uniform `U_infinity=(0,0,0)` initialization without cylinders or a
  prewarm snapshot. All remain finite and capture at `18.6560--18.8100T`, so
  this workspace has no failed termination sheet; the informative negative
  comparison is the slower actuator-state allocator against the best finite
  capture.
- I inspected the combined top-down and oblique sheets for the best sampled
  capture (`solver_0288c0d51d57`), the phase-demodulated sample
  (`solver_e85ca9b86253`), and the assigned parent's velocity-headroom result
  (`solver_58f74e0c2457`). From release to termination, their top-down rows
  show body-led translation and coherent alternating caudal vorticity, while
  the oblique Lambda2 rows show compact three-dimensional structures shed
  behind the swimmer. The tracks bend smoothly toward capture without passive
  advection, growing wasteful sway, wake collapse, collision, or a boundary
  precursor. The similar local-flow RMS (`0.01808--0.01823U`) and net distance
  progress to capture agree with that visual diagnosis.
- The prefilled helpful-moment amplitude relief is the best current sample at
  `18.6560T`, mean scored distance `2.02115L`, action RMS
  `24.710/28.766 rad/T^2`, posterior `99%` acceleration-limit occupancy
  `75.97%`, force/moment RMS `0.013277/0.006912`, and posterior velocity above
  `95%` of its limit in `12.32%` of rows. Its small lead remains inside the
  inherited identical-hash timing spread, so it is a useful route baseline,
  not evidence for further raw-moment tuning.
- Carrier-demodulated moment allocation preserves capture but trades route
  speed for load relief: the sampled result arrives at `18.7165T`, lowers
  posterior action RMS/occupancy/load to `28.558`, `74.41%`, and
  `0.013093/0.006816`, yet raises posterior high-velocity occupancy to
  `12.70%`. The assigned parent's phase-increment headroom gate is a concrete
  negative result: it slows capture further to `18.8100T`, raises mean
  distance to `2.03220L`, high-velocity occupancy to `13.04%`, and outward
  acceleration while already above `95%` velocity to `9.68%`. With the same
  coherent wake, this falsifies withdrawing phase authority as a way to create
  velocity headroom; the altered phase target leaves the final command free to
  continue driving outward.

## Policy hypothesis recorded before editing

Preserve the prefilled normalized body-frame bearing/LOS-rate route,
recoil-conditioned yaw response, continuous anterior/posterior C-bend,
state-feedback traveling carrier, response-reversing half-cycle steering,
persistent same-side phase gate, and helpful-moment residual relief. Add one
bounded actuator-state mechanism only at the final posterior command: when
measured posterior velocity is within the last five percent of its physical
limit and the requested acceleration points farther outward, continuously
withdraw that outward acceleration. Leave inward/braking acceleration and all
commands below the headroom boundary unchanged. The product of posterior
velocity and acceleration is reflection-even, so this barrier does not encode
a turn side, time, range stage, world direction, or memorized route.

Support requires capture with both wake views coherent, arrival inside the
replicated `18.656--19.008T` band, posterior high-velocity occupancy below
`12.0%`, outward-at-high-velocity rows below `8.5%`, and no increase over the
prefill's `0.01328/0.00692` force/moment RMS. Falsify the mechanism if capture
or wake coherence is lost, arrival leaves the band, either velocity statistic
does not improve, or lower outward command merely reduces propulsion without
reducing physical velocity occupancy. The current candidate's CFD outcome is
not claimed here; it becomes evidence only after this worker exits.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and residual path-following control
source_mechanism: sensor feedback preserves the rhythmic locomotion scaffold while continuously limiting only a residual command that violates measured actuator headroom
transferable_invariant: retain the productive traveling wave and route loop, but withdraw only command authority that drives a measured actuator farther into a physical constraint while preserving restoring authority
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized posterior joint velocity and its reflection-even alignment with the final posterior acceleration to gate only outward near-limit command within the two-joint state-feedback contract
falsification: reject if capture leaves 18.656--19.008T, posterior velocity occupancy or outward-at-high-speed rows do not fall, loads exceed 0.01328/0.00692, or either wake view degrades

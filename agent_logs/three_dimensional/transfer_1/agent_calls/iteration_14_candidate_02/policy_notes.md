# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled runs and the inherited terminal-governor run use direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders,
  and no prewarm. Both visual rows therefore show self-propulsion rather than
  advection. The sampled captures retain a coherent alternating top-down wake
  and compact paired oblique Lambda2 structures from release through capture.
- Three sampled policies are byte-identical to the assigned parent's
  `dogfish3d_intercept_guarded_speed_reserve_v1` (`567de354...`), and all three
  captured: `0.74796L` at `18.2050T`, `0.74664L` at `18.3205T`, and `0.74939L`
  at `18.6010T`. This clears the parent's explicit exact-repeat boundary for
  testing a new terminal mechanism while supporting preservation of its
  traveling bend, achieved-course route, intercept guard, and sparse
  outward-carrier reserve.
- The three identical-policy captures span meaningfully different terminal
  approaches while retaining the same success class. Near `1L`, their
  projected miss distances are about `0.143L`, `0.685L`, and `0.905L`; the
  corresponding route requests retain the correct sign but range from about
  `0.42` to saturated `1.0`. Thus absolute projected miss is already a useful
  release veto, but the signed miss remains unused as a continuous terminal
  steering error. Body-bearing/course error becomes range-sensitive on the
  last body length, whereas signed projected miss directly describes which
  side of the capture disk the achieved velocity will pass.
- The sampled policies still clamp returned acceleration on about
  `68.5--68.7%` of head rows and `70.6--71.0%` of tail rows, with exact
  joint-speed-limit residence near `10.4--11.6%`. The inherited total-command
  speed governor reduced speed-limit residence to about `6.9/7.2%`, but it
  missed below at `1.3877L`, exited the domain, and retained about
  `69.8/70.9%` action clamping. Its combined sheet shows that the alternating
  wake persists through the miss and subsequent turn. Reversing outward total
  commands changed the useful trajectory without curing clipping; it is not a
  safe next extension of the repeatable capture controller.

## Candidate mechanism and falsification

Preserve the evaluated speed-reserve controller outside `2L` and preserve its
carrier, cadence, response/LOS release, projected-intercept guard, steering
shares, and reserve logic everywhere. Add one continuous terminal interception
command: retain the sign of `target_body x velocity_body`, divide by achieved
speed to obtain normalized signed projected miss, map it through a bounded
odd function, and smoothly blend from the existing course request inside
`2L`. The blend reaches full authority only inside `0.9L`, so broad route
acquisition and nearly all approach remain byte-equivalent in structure. This
changes the steering error, not steering gain or actuator limits. It should
keep strong correction when a projected pass lies outside the capture disk
while relaxing range-amplified course steering when the projected pass is
already centered.

Expected test: retain the coherent alternating wake and capture class across
the evidenced trajectory variability, with no change before `2L`; near the
disk, obtain equal or earlier capture while reducing unnecessary terminal
steering/clipping on centered projected passes. A sub-`0.75L` crossing is the
primary criterion, not clamp fraction alone.

Falsification: reject the projected-miss blend if it changes far/middle closure,
loses any repeatable-capture topology, weakens the terminal traveling wake,
recreates a below-target exit, raises force or yaw-moment peaks, or merely
reduces saturation by coasting. Also reject the assumed sign/scale if the
closed-loop projected miss grows after the blend activates or if a repeated
evaluation is less robust than the three inherited exact-policy captures.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and adaptive prey-capture control
source_mechanism: preserve a rhythmic propulsive carrier while current sensed interception geometry continuously shapes a bounded steering residual
transferable_invariant: once broad target acquisition is established, normalized signed predicted miss can replace range-sensitive bearing error near interception without prescribing a route or suppressing propulsion
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact gait and vortex phases, learned policies, and task-specific paths
policy_translation: preserve the two-joint speed-reserve carrier and blend its body-frame course command toward a bounded signed target/velocity projected-miss command only inside the terminal two body lengths
falsification: reject if far-field behavior changes, projected miss grows after activation, capture repeatability or wake coherence is lost, saturation falls only through coasting, or loads rise

## Non-CFD verification

- The guidance-delta and solver editable-boundary checks pass. Static schema
  inventory finds all 45 direct `params.FIELD` references in the 47-field
  object returned by `target_policy_params`; only metadata fields `version`
  and `control_period` are intentionally not read by policy arithmetic.
- Recorded-trace projection on all three exact-policy captures is identically
  unchanged at and beyond `2L`. Inside `2L`, the mean absolute turn-command
  change is only `0.094--0.105`, and projected-miss blending causes no turn-sign
  reversal on any of the `284/265/345` terminal rows. At the logged capture
  rows it preserves the evidenced sign while mapping route commands
  `+0.785/-0.246/+0.999` to bounded projected-miss commands
  `+0.393/-0.099/+0.838`. This is a trace projection, not a CFD prediction.
- Simultaneous lateral reflection negates target and velocity lateral
  components, so signed projected miss, route command, and the blended command
  all negate while distance, speed, and the smooth gate remain invariant. The
  inherited two-joint carrier/reserve path therefore retains its odd lateral
  symmetry. Julia is absent from the default `PATH`, but the workspace's
  documented Julia wrapper passes the finite two-joint contract and explicit
  bounded reflection checks; the projected-turn gate is exactly zero at and
  beyond `2L`.

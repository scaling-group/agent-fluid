# Persistent outward-acceleration envelope candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  `uniform_direct` initialization at `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and capture at `18.6560--18.7825T`. There is no
  sampled non-capture, so the useful comparison is among successful actuator
  allocators and the assigned parent's completed negative result rather than a
  manufactured failure ranking from close scalar scores.
- I inspected every sampled combined keyframe sheet from release to capture.
  Each top-down row shows body-led target approach with a coherent alternating
  caudal vorticity street, while each oblique row independently shows compact
  three-dimensional Lambda2 structures shed behind the moving fish. None shows
  passive advection, growing wasteful sway, wake collapse, collision, boundary
  approach, or instability. Local-flow RMS remains `0.01796--0.01809U`, and
  monotone closure to `0.746--0.748L` agrees with the visual diagnosis. The
  visually indistinguishable routes do not support selecting the best one-off
  score as a new mechanism.
- The sampled actuator-consistent phase controller captures at `18.6725T` but
  has posterior acceleration-limit occupancy `76.14%`, action RMS
  `24.95/28.85 rad/T^2`, and force/moment RMS `0.01350/0.00703`. The three raw-
  moment relief variants also capture at `18.6560--18.7825T`, but remain within
  the inherited arrival spread and retain posterior acceleration occupancy
  `75.47--75.77%`; they do not supersede the replicated carrier-demodulated
  phase result, which lowered occupancy to `74.17--74.44%` and loads to
  `0.01309--0.01311/0.00682` without establishing a faster route.
- The assigned parent's velocity-headroom phase withdrawal is a concrete
  negative result. It captures at `18.8100T`, lowers posterior acceleration
  occupancy to `73.83%`, and retains `0.01312/0.00683` force/moment RMS, but
  increases exact posterior velocity-limit occupancy from the demodulated
  parent's `7.73--7.83%` to `8.10%`. Removing only the incremental phase
  acceleration therefore does not arrest total carrier-driven outward motion;
  another threshold or withdrawal gain would repeat the same failed semantic.

## Policy hypothesis recorded before editing

Preserve the normalized body-frame bearing/LOS-rate route, recoil-conditioned
yaw response, continuous distributed C-bend, state-feedback traveling carrier,
response-reversing half-cycle steering, persistent same-side stress gate, and
replicated carrier-demodulated moment-residual phase allocator. Add one bounded
velocity-envelope projection after the complete posterior command is formed.
Only when posterior velocity is near its physical limit, the current total
acceleration points farther outward, and the previous feasible action confirms
the same outward direction, smoothly remove the outward component. Never add a
new braking impulse and never alter inward acceleration, so the established
carrier resumes unchanged as soon as headroom or command direction returns.

The products of posterior velocity with current and previous acceleration are
reflection even; the removed acceleration reverses with the joint state. The
mechanism therefore uses normalized two-joint state feedback without a clock,
range stage, world direction, task route, or mutable memory. Support requires
capture with both wake views coherent, arrival inside the inherited
`18.6725--19.0080T` replicate band, posterior exact velocity-limit occupancy
below `7.5%`, posterior acceleration occupancy below `75.0%`, and force/moment
RMS no greater than `0.01320/0.00690`. Falsify it if capture is lost, route
timing leaves the band, velocity occupancy does not fall, load relief is lost,
or either wake view weakens; later workers should then preserve the plain
carrier-demodulated phase allocator and stop applying memoryless velocity gates
until a genuinely beat-scale response signal is exposed.

bookshelf_consulted: true
source_domain: sensor-feedback modulation of rhythmic robotic-fish control and phase-lag steering
source_mechanism: preserve a productive traveling rhythm while a bounded observed-state residual modifies only authority that violates an actuator constraint
transferable_invariant: retain the slow route loop and traveling-wave carrier, and apply the smallest reversible feedback that prevents persistent outward actuation from driving a rhythmic joint farther beyond measured headroom
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, full-body waveforms, exact vortex phases, organized-wake synchronization, and task-specific routes
policy_translation: keep normalized LOS guidance and carrier-demodulated phase steering; use normalized posterior velocity, total requested acceleration, and previous feasible action to project only persistent outward acceleration toward zero near the velocity envelope
falsification: reject if capture leaves 18.6725--19.0080T, posterior velocity occupancy is not below 7.5%, posterior acceleration occupancy is at least 75.0%, force/moment RMS exceeds 0.01320/0.00690, or either wake view degrades

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.

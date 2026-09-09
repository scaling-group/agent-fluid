# Phase-headroom steering-transfer candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, and stable `capture`. The useful comparison
  is therefore between controller mechanisms, not termination classes.
- I inspected both rows of the combined sheets from release through capture
  for the strongest finite sample `solver_1d05d22ea1fe` and the informative
  lower-score half-cycle-allocation sample `solver_8d0068c45885`. Their
  top-down rows begin in blank still water and show genuine self-propulsion on
  a shallow target-directed arc with alternating caudal vorticity. Their
  oblique rows show compact three-dimensional Lambda2 structures shed behind
  the caudal region through capture. Neither view shows passive advection,
  collision, domain-exit approach, wake collapse, out-of-plane motion, or
  numerical instability. The half-cycle sample's slightly longer terminal
  curve is quantitative rather than a different wake topology, so the proven
  gait, target sign, and course redirect should be preserved.
- Quantitatively, the sampled all-distance response-release repeats capture at
  `16.071--16.088T`, with distance integrals `1.82203--1.82366L`, head paths
  `13.129--13.166L`, and anterior/posterior greater-than-90%-rate residence of
  `17.50--17.52/7.93--8.08%`. The approach-restored sample reaches capture at
  `15.939T/1.82008L` on a shorter `13.107L` path, but raises that rate
  residence to `17.70/8.25%`; the response-gated half-cycle variant remains at
  `16.022T/1.82375L/13.144L` and `17.71/8.07%`. Thus neither carrier-handoff
  nor half-cycle gating establishes actuator relief beyond repeat variation.
- The assigned parent logs add two completed negative results. Conditioning
  near-target carrier coupling on speed-authorized course error scored
  `0.056747`, and replacing the hard range transition with unresolved
  directional demand scored `0.055859`; both retained capture but fell below
  the sampled `0.058307--0.061891` class. Along with the inherited closure-
  gated regressions, these results argue against another carrier-release gate.
- The untested structural imbalance is phase-local: across every sampled
  trajectory, whenever anterior rate exceeds 90% of its limit, posterior rate
  is always below 50% and averages only `0.187--0.195` of its limit. This
  supports testing coordinated steering allocation, not lower global drive or
  another rate threshold on the full traveling carrier.

## One-candidate policy hypothesis

Preserve the prefilled corrected-sign body-frame targeting, distance/closing
drive relief, velocity-course redirect, full joint-phase asymmetry, posterior
wave allocation, response-released carrier reversal, carrier/steering
decomposition, bounds, and public two-joint contract. Add one bounded
phase-headroom allocator to the explicit target-aligned head-steering term.
Only when that term is doing outward work and anterior rate exceeds a normalized
onset, transfer a fraction of it to the posterior acceleration in proportion
to posterior rate headroom. Do not transfer rhythmic carrier work or reversing
head steering. This retains total signed direct-steering acceleration while
using the measured phase-local capacity difference.

Expected evidence is retained capture and coherent two-view wake, milestones
and distance integral within the sampled useful class, path no longer than the
`13.166L` repeat envelope, and a material reduction in anterior greater-than-
90%-rate residence without moving posterior residence, command, loads, joint
margin, or terminal yaw/slip outside the sampled envelope. Falsify the
mechanism if capture or wake coherence is lost, rate cost merely moves to the
posterior joint, or timing, integral, path, loads, finite action, or course
diagnostics regress without actuator relief. The candidate's CFD evaluation
occurs after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical body-caudal traveling-wave control
source_mechanism: bounded tail-beat steering asymmetry coordinated with the propulsive rhythm
transferable_invariant: preserve the traveling carrier and braking phase while allocating target-conditioned steering toward the joint with observed phase-local actuation headroom
nontransferable_details: published gains, duty ratios, robot or species kinematics, dimensional cadence, full-body amplitude envelopes, exact vortex phases, and world-frame routes
policy_translation: use normalized anterior and posterior joint rates plus body-frame turn request to transfer only outward direct head steering into same-sign posterior acceleration under the existing two-joint state-feedback contract
falsification: reject if anterior rate residence does not fall materially, if cost is displaced to the posterior joint, or if capture, timing/integral, path, joint margin, loads, terminal course, finite action, or coherent top-down and oblique wakes regress

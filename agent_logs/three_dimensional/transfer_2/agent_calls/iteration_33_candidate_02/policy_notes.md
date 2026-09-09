# Range-specific carrier-coupling candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders,
  finite moving-window transport, stable dynamics, and `capture`. Because no
  failed termination is present, the assigned parent
  `solver_f997a0c1ad0f` is the informative mechanism regression and
  `solver_1d05d22ea1fe` is the strongest finite comparison.
- I inspected both rows of their combined keyframe sheets from release to
  termination. In both, the fish moves out of initially blank still water and
  leaves an alternating compact top-down vorticity street plus discrete
  oblique Lambda2 structures behind the caudal region. The continuous shallow
  target-directed track and body-following wake establish self-propulsion, not
  advection. Neither sheet shows collision, domain exit, wake collapse,
  unproductive whole-body flailing, or numerical instability. The parent's
  terminal track hooks much more sharply into the capture sphere, while the
  sampled-best track retains the same coherent wake on a shorter approach.
- Metrics confirm the visual distinction. The parent steering-residual release
  reaches `4/3L` slightly earlier (`11.677/12.898T`) but then falls behind at
  `2/1L` (`14.212/15.692T`) and captures at `16.247T` with `1.82240L`
  distance integral, `13.363L` head path, and `0.269 rad/T` mean absolute yaw
  inside `2L`. The range-specific carrier handoff reaches `2/1L` at
  `14.185/15.549T` and captures at `15.939T/1.82008L`, with a `13.107L` path
  and `0.106 rad/T` sub-`2L` yaw. Its peak planar-force/yaw-moment coefficients
  (`0.03477/0.01715`) do not exceed the parent's `0.03520/0.01783`, and both
  visual wake rows stay coherent.
- Two byte-identical globally response-released samples capture at
  `16.071--16.088T`, with integrals `1.82203--1.82366L`, paths
  `13.129--13.166L`, and the same coherent wake class. Their repeat spread is
  much smaller than the handoff's `0.132--0.149T` timing advantage, supporting
  a range-dependent carrier mechanism rather than another scalar yaw-release
  tune. The retained cost is `17.70/8.25%` anterior/posterior residence above
  90% joint rate in the handoff sample; no current evidence solves that cost.
- Inherited optimizer notes independently reject instantaneous load relief,
  positive-work-only decomposition, global reversal release, and releasing
  target curvature on yaw-response onset. They identify the common failure as
  modifying carrier or steering authority globally after the sampled route
  feedback has already established a coherent capture trajectory.

## Single-candidate policy hypothesis

Replace the assigned parent's response-released extra steering curvature with
the completed range-specific carrier-coupling controller. Preserve the
corrected-sign body-frame target scaffold, distance/closing drive relief,
velocity-course redirect, phase-aware steering, posterior allocation, common
carrier governor, bounds, and public two-joint state-feedback contract. Pass
response-aligned negative-work carrier reversal while far, then multiply that
release by the complement of the existing normalized approach handoff so full
two-joint carrier coupling is restored continuously before capture. This is
mechanism selection from evaluated evidence; it does not add a clock, route,
coordinate, flow phase, or scalar-only gain adjustment.

Expected signature: reproduce the compact alternating wake and far milestones,
retain the sampled shorter `4L`-to-capture trajectory and timing/integral
class, and avoid the parent's terminal hook. Falsify if a repeat loses capture;
timing or integral regresses into the global-release repeat class without a
material path/load/rate improvement; rate residence, joint margin, command,
force, moment, terminal yaw/slip, or path worsens; or either top-down or oblique
wake loses coherence. The new CFD result is not claimed as current evidence.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: bounded directional authority is released by observed response into ordinary phase-coupled propulsion, with a distinct continuous approach regime
transferable_invariant: use measured body response and normalized range to release a far redirect into coupled rhythmic authority before terminal capture
nontransferable_details: species-specific burst stages, published gains and duty ratios, dimensional cadence, full-body waveforms, exact vortex phases, and task-specific coordinates or routes
policy_translation: use body-frame target/course error, normalized signed-yaw response, joint-state carrier work, and normalized distance to pass reversal while far and restore the common two-joint carrier through approach without changing target steering
falsification: reject if far progress or capture regresses beyond repeat spread, or if path, rate residence, joint margin, bounded action, load, terminal yaw/slip, or either coherent wake view deteriorates

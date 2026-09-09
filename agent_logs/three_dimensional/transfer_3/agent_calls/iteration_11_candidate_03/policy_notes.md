# Terminal whole-body C-bend allocation candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their translation,
  alternating top-down vortex streets, and compact oblique Lambda2 structures
  are therefore self-generated rather than advection or moving-window motion.
- Both rows of the combined keyframe sheets were inspected for the strongest
  finite approach (`solver_5188c80f90a6`) and the assigned range-damping
  failure (`solver_cf44a7c3b1a7`). The former retains an organized wake until
  its `29.10T` left exit and visibly follows a lower route. The latter only
  narrows its late wake and repeats the high left pass. Neither rollout is
  unstable, collides, or loses propulsion before the miss.
- The otherwise identical LOS-rate and range-damped policies reach `3.369L`
  and `3.392L`, cross the target x station near `y=12.995L` and `12.992L`, and
  exit left. Thus drive relief did not change lateral topology. The sampled
  distributed C-bend instead reaches `1.897L` and crosses at `y=11.465L`, a
  `1.53L` lateral correction relative to LOS-rate alone. Its local-flow RMS
  remains about `(0.020,0.006)U`, force and moment RMS remain about
  `(0.007,0.014)L2` and `0.008L3`, and its wake stays coherent. This supports
  curvature allocation, not inflow rejection or another carrier retune.
- The C-bend still passes about `1.97L` above the target at the x station and
  bottoms at `1.897L`. From about `16T` through closest approach, its bounded
  route request is `+0.50 rad/T`, the large-bearing gate is active, and the
  anterior redirect is near its `6 degree` limit. Yet that redirect shifts
  only the first-joint equilibrium; the posterior equilibrium retains only
  the existing LOS-rate mean curvature. The remaining miss is therefore a
  clean test for near-target whole-body allocation, not scalar-only gain
  tuning. Joint rates already touch their envelope and raw acceleration
  commands exceed it in about `62%/76%` of rows, so far-field effort must not
  increase.

## Policy hypothesis recorded before editing

Use the evaluated distributed C-bend as the complete far- and middle-field
baseline. Add one continuous terminal allocation: when normalized range enters
the final approach and the existing large-bearing redirect is active, share
that same bounded anterior mean bend with the posterior equilibrium. This
recruits a whole-body C-bend without changing oscillator frequency, amplitude,
far-field propulsion, sign logic, or the separately bounded LOS-rate steering.
The range gate only decides where an already observed route-error command is
distributed; it cannot encode a clock, world route, or target identity, and it
releases continuously after alignment or increasing range.

Expected evidence is the sampled coherent far-field wake and lower C-bend
route, followed by additional downward curvature below roughly `5L`, a target-
station crossing below `y=11.465L`, and capture or a minimum below `1.897L`.
Reject the mechanism if it recreates an early upper curl, collapses the wake,
causes angle-limit dwelling or materially larger loads, or retains the same
near-target miss despite the posterior share; the latter would falsify joint-
equilibrium allocation and motivate a phase-lag or genuinely beat-scale
response mechanism instead.

bookshelf_consulted: true
source_domain: biological burst turning and robotic-fish closed-loop CPG mean-offset steering
source_mechanism: a large sensory direction error recruits bounded whole-body mean curvature while rhythmic propulsion persists and releases as alignment returns
transferable_invariant: preserve the traveling-wave carrier, but distribute an established redirect across the body only while observed target geometry still requires terminal correction
nontransferable_details: species-specific C-start shape and timing, published gains, robot linkage geometry, clock phase, dimensional approach distances, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame bearing and line-of-sight-rate feedback, then use normalized range and the existing bounded redirect to share terminal mean curvature across the two joint equilibria
falsification: reject if the early upper-turn topology returns, the coherent wake or load history worsens, joint limits dwell, or closest approach does not beat 1.897L despite activating the posterior share

## Dry validation after editing

- The mandated Julia contract/schema check returns two finite accelerations,
  the guidance provenance check recognizes a material reusable update, and the
  solver boundary check passes. No CFD rollout was run.
- A mirrored synthetic terminal state returns exactly sign-mirrored joint
  actions. The tested branch has terminal weight `0.9997`, anterior redirect
  `5.483 deg`, and posterior share `5.481 deg`; both remain below the owned
  `6 deg` bound and vanish with the signed redirect.
- Replaying the extra posterior term over the sampled C-bend trajectory shows
  it changes the acceleration after adapter clipping in about `28.6%` of rows
  below `5L`, with about `147 deg/T^2` mean signed effective difference. Thus
  the proposed allocation is not erased by the existing acceleration clip,
  although only the later CFD evaluation can establish route improvement.

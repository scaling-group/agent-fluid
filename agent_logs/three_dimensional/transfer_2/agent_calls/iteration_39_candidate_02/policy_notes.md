# Course-resolved carrier-priority candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite moving-
  window transport, stable dynamics, and `capture`. No semantic failure is
  present, so the informative negative is a path/load/actuator tradeoff among
  successful carrier governors.
- I inspected the combined sheets from release through capture for the
  highest-score `solver_6dada5e7a98a` and lowest-score
  `solver_7d26cc24fc23`, including both the top-down mid-plane vorticity row
  and oblique 3D body/Lambda2 row. Both fish self-propel from blank still water
  along a shallow target-directed arc. Compact alternating signed vortices and
  discrete coherent three-dimensional structures persist behind the body;
  neither run is advected, collides, exits, becomes unstable, or loses its
  traveling wake. The useful propulsion scaffold should therefore be retained.
- Metrics expose the control difference hidden by the similar wake sheets.
  The common steering-aware full-demand guard captures at
  `15.604T/1.79354L` distance integral, but carries a `13.137L` path, peak
  planar force/yaw moment `0.04226/0.02076`, and anterior/posterior rate
  residence above 90% of `17.45/6.66%`. The carrier-only joint-selective
  preview captures later at `15.730T/1.80572L`, but shortens path to `12.848L`
  and lowers peaks and rate residence to `0.03558/0.01724` and
  `17.10/5.77%`.
- The assigned parent's full-demand plus joint-local withdrawal composition is
  represented by two executable-equivalent samples. It retains the fast class
  at `15.560--15.708T` and `1.79524--1.79624L`, while peak loads fall to
  `0.03833--0.03909/0.01868--0.01916` and posterior rate residence is
  `6.40--6.41%`. Its path varies from `12.994--13.132L` and anterior rate
  residence from `17.16--17.43%`, so the composition improves the common
  guard's load boundary but does not establish a repeat-robust short-path or
  rate-residence gain.
- The assigned parent guidance and inherited step-36--38 notes reject another
  scalar onset, hard distance handoff, instantaneous load/slip residual, or
  same-sign-yaw steering gate. A prior course-resolved reversal release on the
  older common-guard base captured at `15.730T/1.80710L`; it did not dominate,
  but it preserved capture and supports testing course resolution as the one
  carrier-priority transition on the now-evaluated joint-local base.

## One-candidate policy hypothesis

Preserve the corrected-sign body-frame target geometry, distance/closing drive
relief, full velocity-course redirect, joint-phase steering, posterior wave
handoff, carrier/steering decomposition, joint-local full-demand previews,
positive-work withdrawal, soft bounds, and public two-joint contract. Change
only the carrier-priority transition. Define unresolved direction demand from
the existing speed-authorized bounded velocity-course redirect magnitude,
rather than reducing it merely because yaw has the requested sign. While that
body-frame residual is large, the guard may subordinate carrier work to the
redirect; phase-coherent negative-work reversal is released only when same-sign
yaw response coincides with actual course resolution. This replaces the hard
near-distance release rule with observed geometry and response, without a
clock, fixed coordinates, route identity, or new scalar gain.

Expected signature: retain capture, the inherited early milestones and
distance-integral class, lower-load two-view wake, and finite action while
reducing late-arc/path variability or anterior rate residence. Falsify if
capture or coherent propulsion is lost; timing/integral regresses beyond the
sampled repeat envelope without a material path/rate benefit; or path, joint
margin, rate residence, command effort, force/moment, terminal course, or
either wake view leaves the sampled useful class. The new CFD evaluation runs
only after this worker exits and is not evidence claimed here.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: prioritize bounded redirection, then release into phase-coupled propulsion only after observed directional error resolves
transferable_invariant: response onset is not response completion; release a maneuver-priority allocation only when measured response coincides with reduced normalized body-frame directional demand
nontransferable_details: species-specific maneuver stages and kinematics, published gains and duty ratios, dimensional cadence, clocked phase, full-body waveforms, exact vortex phases, and task-specific coordinates or routes
policy_translation: use speed-authorized bounded velocity-course redirect magnitude as unresolved demand; preserve target steering and release two-joint carrier reversal only when same-sign yaw and course resolution agree
falsification: reject if capture, timing/integral, short path, joint margin, actuator residence, loads, terminal course, finite action, or coherent top-down and oblique wakes leave the sampled useful envelope

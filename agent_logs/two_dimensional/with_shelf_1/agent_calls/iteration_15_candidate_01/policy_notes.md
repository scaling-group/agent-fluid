# Candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held in the upper-right while four
  staggered vortex streets develop and merge across the target corridor. The
  released controller therefore begins inside established asymmetric
  crossflow; the common prewarm is initial-condition evidence, not evidence
  for one policy.
- The three strongest sampled evaluations reproduce exactly the same
  target-reaching result: `34.7105` release time, `1.62283L` mean distance,
  `46985.9` total command energy, `0.240234` RMS relative crossflow, and
  `68.963/1036.40` RMS force/moment. Their released sheets show an active sharp
  redirect followed by a coherent self-propelled leftward traverse through the
  merged wakes and capture from the right; the displacement
  `(-10.923,-4.166)L` and mean body-relative forward flow `0.1114` support
  propulsion rather than passive downstream advection.
- The assigned parent uses joint-local speed release. Its sheet has the same
  visible route topology, but it reaches later at `34.8590`, uses more total
  energy (`47176.8`), and raises RMS force/moment to `74.238/1105.81`. The
  isolated policy difference and the three exact global-release repeats make
  coordinated release the evidenced baseline. No sampled current sheet is a
  semantic failure; inherited failures are used only as a boundary: fast
  bearing-trend feedback exited with negative progress, and magnitude-only
  load gates regressed route/load, so neither is reintroduced here.

## Candidate policy hypothesis

Restore a single speed-pressure release shared by the traveling-bend pair.
Within that globally coordinated allocator, retain raw bearing for persistent
route authority and allow the already signed assisting-moment gate to suppress
the optional redirect burst only when normalized joint velocities indicate a
turn-aligned phase. This tests whether phase-selective hydrodynamic credit can
retain the load benefit of signed moment relief without withdrawing burst on
an unrelated half-cycle. Mean steering, reserve scheduling, carrier, base
asymmetry, and every scalar gain remain unchanged.

Expected evidence: retain target reach and the redirect/upstream topology;
improve on the assigned parent's `34.8590` arrival and `74.238/1105.81` loads,
while remaining close to or improving the coordinated baseline's `34.7105`,
`46985.9`, and `68.963/1036.40`. Reject the mechanism if capture is lost, if
arrival/mean distance regress materially, if force or moment exceeds the
joint-local parent, or if the paired phase gate breaks leftward propulsion.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and adaptive swimming in organized wakes
source_mechanism: sensory feedback modulates a rhythmic controller while locomotor phase and inter-segment coordination remain explicit
transferable_invariant: credit environmental yaw assistance only when its target-directed sign and the observed locomotor phase agree; preserve coordinated traveling-wave actuation
nontransferable_details: published gains, species/body envelopes, oscillator clocks, exact vortex phase, single-cylinder synchronization, and task-specific routes
policy_translation: combine normalized body-frame bearing sign and moment_z_L2 with the two joints' velocity-derived phase; apply one shared credit only to the optional redirect asymmetry
falsification: reject if target reach or upstream propulsion is lost, or if phase selection fails to improve arrival/load tradeoffs against the coordinated and joint-local evidence bounds
```

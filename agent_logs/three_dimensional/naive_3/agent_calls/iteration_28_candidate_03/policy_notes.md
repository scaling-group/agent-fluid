# Candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled episodes report direct uniform initialization with
`U_infinity=(0,0,0)`, no cylinders, and capture. I inspected both rows of each
combined keyframe sheet. From release through `6T`, the top-down views develop
alternating signed vortices behind a translating fish; from `10T` to capture,
the wake remains a coherent sinuous street rather than a reciprocal standing
wiggle. The oblique rows likewise show compact alternating Lambda2 structures
along the traveled path at `12T`, `16T`, and termination. The fish also bends
toward the target circle throughout the late frames, with no collision,
domain exit, disordered lateral excursion, or pre-warm artifact immediately
before termination.

The metrics make the propulsion diagnosis unambiguous: sampled peak swimming
speed is `1.374--1.393U`, while peak local flow is only `0.031--0.032U`.
Therefore the visible translation and capture are self-propelled rather than
still-water advection. The coarse sheets do not visibly separate the three
speed-governor variants, so the trajectory and score differences are the
relevant discriminator:

- The unguarded soft-envelope reference captures at `16.943T`, has `2.090L`
  mean distance and `1.393U` peak speed, but spends `3.73/3.54%` of samples
  exactly at the anterior/posterior `260 deg/T` speed limits.
- The sampled posterior-to-anterior reallocation variant removes exact speed
  contact (`258.93/259.19 deg/T`) but regresses to `17.060T`, `2.093L` mean
  distance, `1.383U` peak speed, and score `-0.208655`.
- The inherited bidirectional variant also removes exact contact
  (`258.91/259.19 deg/T`) and recovers `2.089L` mean distance and the best
  sampled score, `-0.204764`, but captures at `16.988T` and peaks at only
  `1.374U`. In this trace the joints are never simultaneously above `94%` of
  the speed limit, and whenever either is above that threshold the other is
  below `90%`, confirming phase-separated headroom.

The assigned-parent guidance protects the zero-centered anterior oscillator,
and the sampled inherited guidance reports that anterior-to-posterior transfer
has a small benefit while warning against sending posterior clipping into the
anterior carrier. The sampled policies now isolate the reverse route as the
unsupported part: posterior-to-anterior alone regresses, whereas adding the
evidence-aligned anterior-to-posterior route recovers performance.

## Policy hypothesis

Keep the captured velocity-course controller, posterior steering reserve,
soft acceleration envelope, continuous posterior angle barrier, and the
high-onset positive-work speed governors unchanged. Retain only a bounded
anterior-to-posterior transfer when anterior work is suppressed, posterior
speed headroom exists, and the transfer agrees with the posterior carrier.
Remove posterior-to-anterior transfer so tail-side speed protection cannot
perturb the zero-centered anterior limit cycle. This is a directional
mechanism ablation, not a gain change.

Expected result: retain capture, the alternating 3D wake, sublimit joint
speeds, and the bidirectional candidate's `~2.089L` approach while recovering
some of the unguarded carrier's speed or `16.943T` arrival. Falsify the
hypothesis if exact speed contact returns, capture is lost, mean distance
exceeds `2.093L`, arrival is not better than `17.060T`, the wake loses its
alternating structure, or force/moment loads materially exceed the
soft-envelope reference.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive-thrust theory
source_mechanism: posterior kinematics carry disproportionate reactive-thrust authority while anterior motion sustains the traveling wave
transferable_invariant: protect the anterior rhythm and route genuinely spare phase-local work toward carrier-aligned posterior motion
nontransferable_details: published gains, dimensional frequencies, continuous-body envelopes, species kinematics, and exact wake phase
policy_translation: normalized joint-speed headroom gates a one-way anterior-to-posterior acceleration transfer that cannot override posterior carrier sign
falsification: reject if capture or coherent shedding is lost, either speed stop returns, or arrival, mean distance, posterior angle use, or loads regress beyond the sampled guarded references

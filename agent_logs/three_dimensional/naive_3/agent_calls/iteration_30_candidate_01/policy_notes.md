# Candidate diagnosis and hypothesis

## Prior evidence

- The four sampled rollouts all use direct uniform still-water initialization,
  zero cylinders, and the same moving-window contract. All capture at
  `16.9884148T` with `0.747166L` final distance, `2.089308L` mean distance,
  and score `-0.20476427`. Their trajectory CSVs and all three keyframe sheets
  are byte-identical.
- The top-down sheet shows a coherent alternating vorticity street from release
  through the target-directed transit; the body continues to bend rather than
  entering a held redirect. The oblique sheet shows compact three-dimensional
  Lambda2 structures shed behind the posterior body without a disorganized
  volume or instability before capture. Peak body speed is `1.37372U` while
  peak local flow is only `0.03134U`, so this is self-propelled motion rather
  than still-water advection.
- The common trace remains inside the angle bounds (`26.92/32.66 deg` peak
  anterior/posterior magnitude) and just inside the speed bounds
  (`258.91/259.19 deg/T`). Peak planar force norm is `0.03634` and peak absolute
  yaw moment is `0.01804`.
- `solver_4f4e50f3682c` adds a yaw-load gate to both reallocation directions,
  yet is exactly trajectory- and image-equivalent to the ungated sampled
  controller. A whole-trace moment peak is therefore not evidence that a
  moment gate overlaps the discretionary transfer events; this load gate is
  an informative no-effect result, not a reason for another threshold edit.
- The assigned-parent guidance and inherited score logs retain capture while
  improving from the earlier `-0.217369` family to `-0.204764`. At the matched
  `0.94` speed-guard onset, posterior-to-anterior-only routing captured at
  `17.060T`, while bidirectional routing captured at `16.988T`. The contribution
  of anterior-to-posterior carrier-aligned routing has not been isolated.

## Proposed candidate

Retain the demonstrated velocity-course steering, acceleration reserve, soft
envelope, posterior stopping-risk projection, and high-onset positive-work
speed governors. Remove the posterior-to-anterior transfer, including its
above-soft-ceiling receiver reserve. Keep only the bounded
anterior-to-posterior transfer when the posterior command already agrees with
the traveling-carrier direction and the posterior joint has speed and
acceleration headroom. This is an architectural one-direction ablation, not a
carrier-gain change.

The hypothesis is that phase-separated anterior work can be recovered by the
posterior propulsive channel without perturbing the zero-centered anterior
oscillator. Removing the reverse cross-coupling should keep the anterior output
from using the former `0.99` receiver reserve, while keeping posterior
reallocation inside the `0.95` soft ceiling; only the independent mechanical
stopping projection retains larger safety authority. This identifies whether
the posterior route, rather than reverse transfer or their interaction,
accounts for the bidirectional arrival improvement. Falsify the candidate if
it loses capture or alternating 3D shedding, touches either speed limit,
arrives later than the matched posterior-to-anterior reference (`17.060T`),
exceeds `2.093L` mean distance, or raises loads beyond the sampled
bidirectional envelope (`0.03634` force norm, `0.01804` absolute yaw moment).

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and low-dimensional robotic-fish work allocation
source_mechanism: directional traveling bends emphasize posterior kinematics for reactive thrust
transferable_invariant: preserve the anterior rhythm and route recoverable phase-local work toward an already-compatible posterior traveling-wave command
nontransferable_details: published gains, species-specific amplitudes, exact tail phases, dimensional frequencies, full-body envelopes, and task routes
policy_translation: use normalized joint-speed headroom and joint-state carrier direction to permit only bounded anterior-to-posterior work transfer within the existing two-joint feedback contract
falsification: reject if capture or coherent alternating shedding is lost, a hard limit returns, arrival exceeds 17.060T, mean distance exceeds 2.093L, or loads exceed the sampled bidirectional envelope

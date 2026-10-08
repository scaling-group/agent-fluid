# Steering-residual posterior coast candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract (`U_infinity=[0,0,0]`, no cylinders, no prewarm) and capture. The
  v34 prefill captures at `25.0635T`, minimum/final distance `0.749973L`, mean
  distance `2.352216L`, and score `-0.452083`. Two byte-identical v35 samples
  and the course-consistency ablation produce the same trajectory, capturing
  earlier at `24.6730T`, minimum/final distance `0.748684L`, mean distance
  `2.348256L`, and score `-0.448647`.
- Both rows of the best sampled v35 combined sheet and the inherited v36
  tangency-failure sheet were inspected from release through termination. The
  successful top-down sequence starts wake-free, develops a regular alternating
  vortex street along a shallow diagonal approach, executes a bounded redirect,
  and crosses the capture disk. Its oblique row shows compact alternating
  three-dimensional Lambda2 structures persisting through capture. The v36
  tangency policy remains self-propelled and wake-coherent, but passes outside
  the disk, makes a broad organized turn, and exits left. This is a trajectory
  and propulsive-phase failure, not passive advection, wake breakup, or
  numerical instability.
- State histories support that distinction. The sampled v35 has zero posterior
  hard-stop occupancy and peak absolute body-frame force/yaw-moment
  coefficients `0.0253/0.0309/0.0156`, with posterior/any-joint exact-rate
  occupancy about `4.86/14.16%` under a direct trace threshold. The inherited
  v36 tangency rollout also keeps zero posterior hard-stop occupancy and the
  same low-load class, and eliminates sampled posterior exact-rate occupancy,
  yet misses at `0.8464L`, exits left at `36.7730T`, and has mean/final distance
  `6.8930/7.3656L`. Therefore exact rate-contact elimination is not a valid
  objective when it changes the posterior follower waveform.
- The mechanism-level difference is narrow and evidenced. v34 tapers every
  velocity-increasing posterior net command toward pure coast. v35 retains an
  already-computed target-steering residual only when it reduces posterior
  speed; the inherited offline audit found only 13 changed states on the v34
  trace. Formal CFD then improved arrival and mean distance without returning
  hard-stop contact or leaving the low-load class. The stronger v36 headroom
  tangency rule changed the carrier throughout the rate band and destroyed the
  capture trajectory despite a better saturation statistic.

## Policy hypothesis

Promote the formally evaluated v35 controller over the v34 prefill. Preserve
the anterior state-feedback phase anchor, posterior traveling-wave target,
course preview, steering-priority allocation, predictive stroke guard, braking
reserve, and posterior-only coast band. When the final posterior command still
points toward the rate boundary, taper its velocity-increasing remainder as in
v34, but retain only the already-requested posterior target-steering component
that opposes measured posterior velocity. Do not synthesize braking, change the
anterior command, tighten the headroom law, or alter below-band states.

The prior evidence predicts the evaluated v35 outcome: capture near `24.67T`,
the same coherent three-dimensional wake and target-closing route, zero sampled
posterior hard-stop occupancy, and peak planar force/yaw-moment coefficients in
the roughly `0.031/0.016` class. Its boundary is semantic rather than scalar:
falsify extension to held-out conditions if capture, route topology, wake
coherence, or hard-stop/load class regresses. Do not reject the mechanism only
because some exact-rate occupancy remains; the completed tangency control shows
that removing it can erase capture.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: an anterior phase anchor organizes a traveling bend while the phase-lagged posterior follower supplies reactive thrust and accepts bounded state feedback
transferable_invariant: preserve traveling-wave direction and phase organization when enforcing posterior feasibility, retaining target-directed feedback that already reduces boundary motion
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain the evaluated anterior oscillator and v34 coast band, then preserve only the existing rate-opposing posterior steering residual using normalized joint rate and the owned acceleration envelope
falsification: reject if capture, coherent route and wake, zero posterior hard-stop occupancy, or the low-load class is lost; do not infer that tighter tangency, anterior filtering, or synthesized inward braking is safe

## Pre-evaluation validation

- The materialized candidate byte-matches the formally evaluated v35 sample.
  All `84` direct `params.FIELD` references resolve among the `86` fields
  returned by `target_policy_params()`, and the prescribed public-contract
  state returns exactly two finite accelerations.
- The reusable-guidance semantic check and solver editable-boundary audit pass.
  The configured check-runner was invoked but its pinned `gpt-5.4-mini` model
  is unsupported on this account; its three declared no-CFD checks were run
  directly and separately and all pass. No formal CFD was run.

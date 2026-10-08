# Course-scaled posterior steering-reserve candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts and the inherited informative failure satisfy the
  frozen evidence contract: direct uniform initialization in still water with
  `U_infinity=[0,0,0]`, no cylinders or prewarm, finite dynamics, and inertial
  moving-window transport.
- Both rows of the combined v35, v34, and inherited phase-follower keyframe
  sheets were inspected from release through termination.  The top-down rows
  begin wake-free and show self-propelled diagonal motion with coherent
  alternating mid-plane vortex streets; the oblique rows show compact
  three-dimensional Lambda2 structures that persist through each redirect.
  The v35 and v34 paths make bounded terminal hooks into the capture disk.
  The follower path instead passes the disk and makes a broad upward loop
  before its left-boundary exit.  Because its wake remains coherent, this is a
  controller-induced route failure rather than passive advection, wake breakup,
  moving-window transport error, or numerical instability.
- The best sampled result is replicated twice as byte-identical v35 and once
  by the v36 course-sign veto: capture at `24.6730T`, minimum/final distance
  `0.748684L`, mean distance `2.348256L`, and score `-0.448647`.  The distinct
  v34 posterior coast also captures, but later and with slightly worse
  distance integral (`25.0635T`, `0.749973L`, `2.352216L`, `-0.452083`).
  The v35 improvement comes from retaining an already-requested
  velocity-opposing posterior steering residual at the rate boundary; the v36
  rollout confirms that its effective residual already agrees with body-frame
  velocity-course error and therefore leaves the fixed trajectory exactly
  unchanged.
- The assigned parent's broad phase-reversal feedforward is the informative
  negative.  It lowers posterior/total exact-rate occupancy but changes the
  established path by about `8T`, misses at `0.993183L`, and exits left at
  `37.1470T` with final/mean distance `6.9973/6.6506L` and score `-7.975740`.
  Upstream follower correction across many far-approach half-cycles is therefore
  unsafe even when it reduces a saturation statistic.  Any new rate-envelope
  mechanism must remain posterior-only, downstream, and confined to the
  already owned rate band.

## Initial policy hypothesis

Preserve the full evaluated v35 oscillator, course preview, steering-priority
allocation, stroke reserve, and braking reserve.  Replace only the final coast
layer's global-limit cap with a component-wise convex release: across the
existing posterior rate band, blend the actual velocity-increasing command
toward the rate-reducing steering residual rather than toward a cap derived
from the full acceleration limit.  Retain that residual only when its sign
agrees with normalized body-frame velocity-course error; otherwise blend toward
pure coasting.  Squaring the already normalized rate pressure keeps the edit
concentrated near the boundary without adding another threshold or gain.

This should remove redundant follower effort continuously while preserving the
signed route correction that distinguishes v35 from v34.  It does not alter the
anterior phase anchor, synthesize inward braking, differentiate the carrier
reference, or introduce time, coordinates, identity, or mutable state.  Reject
the candidate if post-exit CFD loses capture or the established trajectory,
breaks the coherent wake, returns posterior hard-stop contact, leaves the
sampled low-load class, or fails to improve posterior/total rate exposure
without materially worsening the `24.6730T` arrival and `2.348256L` mean
distance.  The new CFD result is not available to this worker and is not
claimed here.

## Pre-CFD locality refinement

The first deterministic replay of the proposed final-layer helper against the
completed v35 trace rejected an overly broad form: blending every outward
rate-band command toward zero would change `225/4478` reconstructed states
from `2.079--14.377T`, with `95` changes above `1e-3 rad/T^2`.  That scope is
too similar to the failed follower's `306/4557` far-approach interventions.
The provisional candidate therefore retained v35 byte-for-byte whenever no
course-consistent inward steering residual exists.  Component blending is
admitted only for the narrower evidenced role: posterior motion is outward in
the owned rate band, target steering already opposes that motion, and the
steering sign agrees with normalized body-frame course error.  This refinement
preserves the original falsification boundary and prevents a lower saturation
statistic from justifying another widespread trajectory perturbation.

A second replay showed that this narrowed component blend changes zero
reconstructed v35 states: the only course-consistent inward residual occurs at
the full-rate boundary, where both formulas already return the same steering.
That provisional form would repeat v36's no-effect result and is not the final
candidate.  The final single mechanism preserves v35's evaluated coast formula
and v36's sign-consistency condition, then adds bounded course urgency only to
the already-retained inward residual: multiply it by
`1 + clamp(abs(course_error),0,1)` before the acceleration-envelope clamp.
This keeps the edit on the one positively evidenced rate-boundary route event,
uses no new tuned scalar, and remains mirror-equivariant.  Falsify it under the
same capture, route, wake, hard-stop, load, arrival, and distance-integral
criteria above.

The final fixed-trace replay predicts exactly one changed state among `4478`
reconstructed v35 rows: at `12.3695T`, distance `7.1867L`, and course error
`+0.23949`, the already rate-reducing posterior command increases from
`+4.55894` to `+5.65077 rad/T^2`.  Every other reconstructed command remains
unchanged.  This audit establishes sign, magnitude, and locality only; it does
not predict the coupled CFD trajectory or claim improvement.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve an anterior phase anchor and lagged posterior traveling bend while proprioceptive feedback modulates only the follower component that conflicts with a physical envelope
transferable_invariant: constraint handling should preserve wave direction and body-frame route-consistent steering while continuously withdrawing only velocity-increasing posterior follower effort near the owned rate boundary
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact vortex phases, Strouhal targets, motor models, and task-specific routes
policy_translation: use posterior joint rate for the existing normalized coast pressure and normalized body-frame velocity-course error for a mirror-equivariant sign-and-urgency allocation, then retain a bounded course-scaled copy of only the already-requested inward posterior steering residual
falsification: reject if capture, the established route, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if rate exposure does not improve without a meaningful arrival or distance-integral regression

## Pre-evaluation validation

- The final candidate LF SHA-256 is
  `5b023268cadfc7b80c4160bebb603801d113b15047f8451ebf246b0b60c05adb`.
- The exact Julia public-contract probe loads the policy and returns two finite
  accelerations.  The deterministic schema audit resolves all `84` direct
  `params.FIELD` references among the `86` fields owned by
  `target_policy_params()`.
- The final helper passes an `875`-state deterministic grid covering both rate,
  command, steering, and course signs; it is sign-symmetric, leaves sub-band
  and already-inward commands exact, and returns the bounded course-scaled
  residual or pure coast at the full boundary as designed.
- The configured check runner was invoked against the final candidate, but its
  pinned `gpt-5.4-mini` model is unsupported on this account.  Its three
  declared no-CFD commands were run directly and separately: reusable-guidance
  semantics, the Julia contract, and the solver editable-boundary audit all
  pass.  The rendered README's duplicated assigned-parent marker was removed
  so the guidance checker can resolve the same parent unambiguously.  No formal
  CFD was run.

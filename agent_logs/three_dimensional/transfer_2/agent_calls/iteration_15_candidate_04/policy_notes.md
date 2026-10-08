# Joint-rate braking-reserve candidate

## Evidence diagnosis before the policy edit

- All four assigned solver rollouts are byte-identical instances of the
  course-preview controller and satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders or prewarm, finite dynamics, and inertial moving-window transport.
  Each self-propels to capture at `24.5795T`, minimum/final distance
  `0.746968L`, and mean distance `2.36044L`. They are replicated evidence for
  one successful route, not four independent mechanisms.
- Both rows of the combined keyframe sheets were inspected for the assigned
  capture, the assigned-parent braking-reserve capture, and the informative
  active-brake failure. The top-down capture sheets start wake-free, build a
  coherent alternating reverse-vortex street along the long diagonal, and
  redirect before crossing the target circle. Their oblique rows show compact
  three-dimensional Lambda2 structures remaining coherent through capture.
  The active-brake failure initially produces the same self-generated wake and
  reaches `0.913L`, but its terminal path curls past the circle, points toward
  the upper boundary, and exits at `36.872T`; neither success nor failure is
  passive advection or numerical wake breakup.
- The assigned parent validates a strong actuator mechanism. Its ungated,
  full-authority posterior braking reserve preserves capture at `24.6290T`,
  `0.748702L`, and mean distance `2.36161L`; eliminates sampled posterior
  hard-stop occupancy (`12.634%` to `0%`, maximum posterior angle
  `0.7680 rad`); and lowers peak absolute body-frame force/yaw-moment
  coefficients from `0.149/0.097/0.0667` to `0.0241/0.0303/0.0149`.
  Preserve this result. The sibling route-gated, 15-percent-authority active
  brake is a concrete negative control: despite nearly eliminating hard-stop
  occupancy, it loses capture and exits above. Braking must remain a
  proprioceptive feasibility layer, not inherit the transient intercept gate.
- The parent's remaining actuator defect is rate clipping, not stroke contact:
  any-joint rate-limit exposure is `15.163%`, essentially unchanged from the
  assigned course-preview sample's `15.149%`. Of `4478` parent samples, the
  anterior and posterior joints occupy the exact `260 deg/T` limit for `419`
  and `260` samples with no overlap. In every one of those rows the returned
  acceleration has the same sign as the saturated joint rate, so the policy
  continues to demand outward velocity while the downstream integrator clips
  it. Most exposure occurs above `6.5L` (`436` samples), so a terminal steering
  handoff cannot address it. Raw acceleration-envelope exposure also remains
  `73.046%`; inherited logs show that final output projection merely duplicates
  downstream clipping and must not be claimed as a dynamic improvement.

## Policy hypothesis

Use the evaluated parent as the base and add one state-feedback feasibility
mechanism after posterior stroke protection: a mirror-equivariant joint-rate
braking reserve on both final joint commands. Below a narrow soft band near the
owned `260 deg/T` rate envelope, pass the established carrier, steering, and
posterior stroke reserve through exactly. Within the band, if commanded
acceleration would increase the magnitude of the observed joint rate, blend it
toward bounded inward acceleration in proportion to normalized rate pressure;
commands already reducing rate pass through unchanged. This acts only on the
evidenced sign-conflicted saturation rows and does not use target side, route,
time, or beat phase.

Expected evidence: retain capture, the established far trajectory and coherent
wake, zero posterior hard-stop occupancy, and the parent's reduced-load class,
while reducing any-joint rate-limit exposure below `15.16%`. Falsify the
mechanism if capture is lost, the diagonal route changes materially, posterior
hard-stop occupancy returns, peak loads leave the parent's low class, or rate
exposure does not improve. Because rate clipping is mostly a far-carrier
phenomenon, also reject repeated near-band chatter or a large loss of closing
speed even if exact-limit occupancy falls.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive swimming
source_mechanism: proprioceptive feedback modifies only constraint-conflicted portions of a traveling joint rhythm while preserving unconstrained anterior-to-posterior wave propagation
transferable_invariant: retain the state-feedback traveling wave, but use normalized joint rate and commanded acceleration sign to reserve bounded inward authority before velocity saturation
nontransferable_details: published CPG gains, motor bandwidths, dimensional cadence, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: normalize each observed joint rate by the owned rate envelope and soften only same-sign outward acceleration inside a narrow rate guard band after the validated posterior stroke reserve
falsification: reject if capture, far-path coherence, zero posterior hard-stop occupancy, or the low-load class is lost, or if exact rate-limit exposure does not fall below the assigned parent

## Pre-evaluation validation

- All direct `params.FIELD` references resolve among the `86` fields returned
  by `target_policy_params()`. The prescribed public-contract state and an
  `8748`-state grid spanning target geometry, range, bearing, both joint
  positions, and both rate limits return two finite accelerations.
- Direct barrier probes are mirror-equivariant to numerical tolerance, pass
  sub-band motion and commands already reducing rate through exactly, and
  return the full mirrored inward envelope for an outward command at either
  signed rate limit.
- Fixed-state application to the assigned-parent trace changes `495` anterior
  and `301` posterior commands (`796/4478` rows total), beginning at `2.079T`
  and `12.287L`; `515` changed rows are above `6.5L`, consistent with the
  diagnosed far-carrier saturation. Every exact-rate parent row becomes an
  inward command, while all sampled sub-band commands remain exact. This is
  an offline command audit, not a trajectory or CFD claim.
- A `10T` joint-only closed-loop integration under fixed far geometry removes
  exact-rate occupancy in both joints (`40/63` parent samples to `0/0`) while
  keeping peak rates at `254.7/257.1 deg/T` and peak bends within about one
  degree of the parent. This checks the local barrier for gross limit chatter;
  hydrodynamic capture remains the stated post-worker falsification test.
- The reusable-guidance semantic check, exact Julia public-contract check, and
  solver editable-boundary audit pass. The configured check-runner was invoked,
  but its pinned `gpt-5.4-mini` model is unsupported on this account; its three
  declared no-CFD commands were therefore run directly and separately. No
  formal CFD was run.

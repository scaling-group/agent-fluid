# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

All four sampled evaluations report direct uniform initialization in still
water, zero background velocity, no cylinders, finite capture, and complete
combined keyframe sheets. The three byte-identical one-sided signed-allocation
samples (`solver_db2418f56ce7`, `solver_cf5406a979f8`, and
`solver_6334f1f4fe88`) are the strongest finite reference: capture occurs at
`16.932T`, score is `-0.200045`, score mean distance is `2.08513L`, and final
distance is `0.74389L`. Their trace peaks are `1.391U` fish speed versus only
`0.03270U` local flow, `0.03693` force coefficient, and `0.01835` absolute yaw
moment. Joint speeds remain sublimit at `258.93/259.20 deg/T`, raw policy
accelerations remain sublimit at `1782/1710 deg/T^2`, and the posterior angle
range is approximately `[-30.53,+34.33] deg`.

Reading the strong sheet from release through capture, the top-down row grows
from no wake into a coherent alternating street that remains attached to a
smooth target-directed route; the oblique row shows compact three-dimensional
Lambda2 structures shed behind the posterior body and caudal fan. The fish is
self-propelled rather than advected, lateral oscillation remains productive,
and neither view shows a wake collapse or a hard-stop posture before capture.

`solver_292735cefd5b` is the informative negative comparison. It adds
target-signed suppression to the anterior-to-posterior transfer and preserves
an almost indistinguishable alternating top-down and compact 3D wake, sublimit
joint speeds, and capture. It arrives `0.006T` earlier but worsens the
distance integral (`2.08585L`) and score (`-0.200966`) relative to the repeated
one-sided allocator. Its slightly higher `1.393U` peak speed does not improve
the route. Therefore the visual similarity is not sufficient evidence for the
extra bidirectional arbitration, and the demonstrated anterior-to-posterior
base transfer should remain unchanged.

The assigned-parent log sequence also bounds the proposal: captures at
`-0.204764` repeated across three completed iterations, the one-sided signed
response improved to `-0.200045`, and a later inherited continuation regressed
to `-0.204089`. Combined with the parent guidance, this supports a new
response-conditioned allocation mechanism while ruling out another broad
receiver-permission change or scalar-only carrier tuning.

## Policy hypothesis

Preserve the zero-centered anterior oscillator, posterior lagged carrier,
velocity-course steering, fixed total acceleration envelope, soft shoulder,
high-onset speed guards, proven bidirectional base transfer, one-sided
signed-yaw residual, and stopping-risk projection. Inside the already evidenced
terminal allocation region only, use the existing normalized signed yaw-moment
gate to move a bounded portion of the posterior acceleration reserve from the
carrier to steering when measured yaw opposes the body-frame turn request.
This changes work allocation, not total available acceleration. Outside that
condition the controller is exactly the inherited carrier and allocator.

The expected result is a shorter-distance approach integral or earlier capture
without erasing the alternating wake, increasing hard-limit occupancy, or
exceeding the sampled `0.5993 rad` posterior-angle and `0.0370/0.0184`
force/moment boundaries. Reject the mechanism if it loses capture, does not
beat the repeated `-0.200045` score/`2.08513L` mean-distance reference, causes
speed or acceleration contact, breaks wake coherence, or merely exchanges a
tiny timing change for larger loads or posterior excursion.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake-disturbance feedback
source_mechanism: bounded sensor-feedback modulation of a propulsive rhythm, separating persistent route intent from measured adverse yaw response
transferable_invariant: preserve the traveling carrier and reallocate only existing rhythmic authority toward correction when signed measured response opposes target-relative intent
nontransferable_details: published gains, species-specific kinematics, clock-driven oscillator phase, exact vortex phase, dimensional frequencies, and task-specific routes
policy_translation: combine the normalized body-frame velocity-course turn request with normalized yaw moment; a smooth adverse-response gate increases posterior steering reserve and decreases carrier reserve by the same amount inside the existing distance allocation, while both joints retain state-feedback phase
falsification: reject if capture, score, distance integral, coherent alternating shedding, sublimit speeds, posterior angle, or force/moment loads fail the explicit sampled-reference boundaries above

## Post-edit non-CFD sanity

A static replay of the new allocation expression over the repeated-reference
trace changes the pre-envelope posterior request in 415 of 3,079 samples
(`13.48%`), first at `12.419T` and only inside the inherited sub-`6L`
allocation regime. The maximum redistribution is `5.054 rad/T^2`; it changes
the carrier/steering composition while leaving their total acceleration
budget fixed. This overlap check only establishes that the hypothesis is
active and bounded. It is not a claim about the unevaluated candidate's CFD
trajectory or score.

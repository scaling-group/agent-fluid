# Multiplicative dual-response terminal-work candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and 235 moving-window shifts. The prefilled minimum-gate
  dual-response policy captures at `16.93206T` with score `-0.19997473`, mean
  distance `2.08507437L`, and crossing distance `0.74382240L`. Two independent
  samples of the preceding yaw-response-only policy reproduce
  `-0.19997658/2.08507586L/0.74382418L`.
- I inspected both rows of the combined keyframe sheets for the strongest
  finite sample and the weaker yaw-response-only sample. From release through
  capture, both top-down rows show continuous target-directed self-propulsion
  and a coherent alternating red/blue wake; both oblique rows retain compact
  caudal Lambda2 structures through the terminal approach. Neither sheet
  shows held-joint coasting, collision, boundary exit, wake collapse, or
  instability. The traces agree with that interpretation: peak fish speed is
  `1.39123U`, while peak local-flow magnitude is only `0.03270U`.
- The multiplicative yaw/force consensus sample is the strongest current
  result: it retains the same `16.93205T` capture, `0.59921 rad` posterior
  excursion, `4.52389 rad/T` peak posterior speed, `31.10177 rad/T^2` peak
  anterior action, and `0.0183547` peak yaw moment, while improving score,
  mean distance, and crossing depth to
  `-0.19994654/2.08505160L/0.74379522L`. Its maximum sampled body-lateral force
  component also falls narrowly from `0.0302559` to `0.0302096`. The combined
  sheets are visually indistinguishable at their sampling resolution, so this
  is evidence for a terminal work-placement improvement, not stronger drive,
  passive advection, or a different wake topology.
- The inherited optimization notes provide the informative negative controls:
  a symmetric target-ray residual and point-consistent carrier relief kept the
  visible wake and arrived slightly earlier, but regressed to
  `-0.204430/2.08866L/0.74814L` and
  `-0.206188/2.09007L/0.74984L`. Together with the current samples, they reject
  relaxing the established course loop or carrier merely because terminal
  geometry or response is available. The reusable distinction is between
  terminating only a small target-compatible residual and withdrawing proven
  propulsive or broad-steering work.

## Single-candidate policy hypothesis

Materialize the evaluated multiplicative response-consensus sample as the one
candidate. Preserve the zero-centered anterior oscillator, lagged posterior
carrier, full normalized body-frame velocity-course loop, one-sided target-ray
correction, posterior positive-work phase gate, acceleration reserve, C1
command envelope, narrow speed guards, target-signed work reallocation,
receiver taper, and stopping-risk projection. Change only the terminal
target-ray response projection from a permissive minimum of the adverse-yaw
and adverse-lateral-force gates to their smooth product. This makes either
weak response channel proportionally terminate the small residual without
weakening the carrier or base course request; the force scale is inherited
from the completed best sample, not from a published controller.

Expect reproduction of capture, the broad route, coherent alternating 3D
shedding, and sublimit mechanics, with the sampled improvement in crossing
quality over both the single-response and minimum-gate variants. Falsify the
selection if it cannot reproduce the distance benefit, loses capture, changes
the route outside the `2.25L` terminal window, touches a joint limit, exceeds
the established `0.5993 rad` posterior or `0.0370/0.0184` force/moment
envelope, or disrupts the alternating wake. Because the gain is non-semantic,
do not infer that additional response channels or stronger attenuation will
continue to help.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric flapping for turning
source_mechanism: sensor response schedules target-compatible corrective work on a useful propulsive half-cycle while preserving the coupled traveling rhythm
transferable_invariant: add only bounded target-signed residual work during a positive-work joint phase and continuously release it when either independent normalized body response indicates that less correction is needed
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, duty ratios, full-body oscillator networks, exact vortex phases, capture geometry, and task-specific routes
policy_translation: retain the normalized body-frame velocity-course loop and one-sided target-ray increment; project only that increment through posterior positive work and the product of adverse normalized yaw-moment and body-lateral-force gates before the existing two-joint allocation and viability layers
falsification: reject if capture, broad-route equivalence, sublimit mechanics, or alternating 3D shedding is lost, or if score, mean/crossing distance, posterior excursion, or force/moment loads regress without a new semantic or mechanical benefit
```

No formal CFD is run in this worker. The selected candidate's next rollout
becomes evidence only after this worker exits.

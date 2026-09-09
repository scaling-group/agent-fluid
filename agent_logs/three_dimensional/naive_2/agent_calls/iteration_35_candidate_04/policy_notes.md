# Candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled rollouts report direct uniform still-water initialization,
zero background velocity, capture termination, and finite dynamics. Their
combined keyframe sheets show the same useful topology in both required views:
the top-down row has a direct targetward path supported by a coherent
alternating reverse-street-like wake, while the oblique Lambda2 row shows a
compact three-dimensional vortex train attached to a self-propelled fish rather
than passive advection. No sampled rollout is a termination failure, so the
tail-only residual is used as the most informative quality failure: it wins the
scalar score while retaining the widest terminal course and worst posterior
angle dwell. The absolute-reserve allocation is the strongest finite margin
example. Neither view shows wake breakup or a new instability that would
justify changing the established carrier.

The diagnostics separate terminal allocation quality from propulsion:

- tail-only cubic residual: `15.1403T`, score `-0.01094`, head-relative
  constant-course miss `0.651L`, posterior `>40 deg` dwell `1.269%`, and peak
  normalized planar force/moment `0.04041/0.01902`;
- dual absolute-reserve transfer (assigned prefill): `15.4464T`, score
  `-0.01764`, miss `0.362L`, anterior/posterior dwell `0.285/0.996%`, and peak
  force/moment `0.03970/0.01889`;
- dual absolute-reserve transfer with receiving-joint shedding: `15.2957T`,
  score `-0.01484`, miss `0.556L`, dwell `0/0.898%`, and peak force/moment
  `0.03872/0.01876`;
- fully directional sending/receiving capacity: `15.3385T`, score `-0.01502`,
  miss `0.461L`, dwell `0/0.681%`, and peak force/moment `0.03959/0.01889`.

Thus absolute tail reserve is associated with the uniquely centered course,
whereas checking receiving-joint capacity is associated with eliminating the
new anterior dwell. Making the tail's own reserve fully directional improves
arrival and dwell but gives back about `0.099L` of the centered margin. This
candidate isolates the missing combination: retain the evidenced absolute
tail-reserve handoff, but make only anterior spillover direction-aware and shed
the rejected share instead of transferring limit exposure.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG/residual steering and biological burst redirect
source_mechanism: preserve a rhythmic propulsive oscillator while sensor-gating a bounded steering residual and releasing unavailable redirect authority back toward cruise
transferable_invariant: keep the traveling carrier intact; admit a transient steering residual only where observed joint state has compatible directional reserve, and shed rather than force authority that no actuator can safely receive
nontransferable_details: published oscillator gains, dimensional beat settings, species-specific burst kinematics, exact vortex phase, full-body joint envelopes, and task-specific routes
policy_translation: retain the normalized body-frame predicted-miss residual and absolute posterior reserve that produced the centered course; transfer only its excluded share to the head when signed angle and rate state can accept that residual, otherwise leave that share with the unmodified carrier
falsification: reject if capture or compact-wake translation is lost, predicted miss is not competitive with `0.362L`, anterior `>40 deg` dwell remains, posterior dwell/load increases, or arrival materially worsens beyond `15.4464T`

## Candidate-specific expectation

The only new controller mechanism is receiver-safe spillover. Far-field
navigation, carrier frequency/amplitude, target-relative gates, corrective-yaw
handoff, posterior pulse, and residual magnitude remain unchanged. The next CFD
evaluation should therefore retain the direct compact-wake capture class while
testing whether the centered absolute-tail-reserve route can avoid exchanging
posterior saturation for anterior dwell. This is not a claim of improvement;
the candidate result is unavailable until after this worker exits.

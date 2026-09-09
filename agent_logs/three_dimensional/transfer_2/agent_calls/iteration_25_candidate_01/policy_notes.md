# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the experiment contract: direct uniform
  quiescent initialization, `U_infinity=(0,0,0)`, no cylinders, stable finite
  dynamics, and capture. The comparison is therefore between useful capture
  mechanisms rather than against a semantic failure.
- Both rows of every combined keyframe sheet were inspected. In the strongest
  sample (`solver_435f3fac7d39`) and the weakest/slowest sample
  (`solver_e26b4eb5ad01`), the top-down row shows a self-generated alternating
  wake from release through approach, while the oblique row shows coherent
  three-dimensional Lambda2 structures convecting behind the freely moving
  fish. With zero background flow this is self-propulsion, not advection. The
  fish turns toward the target and retains a coherent traveling wake; the
  terminal sheets show the shared tight hook into the capture circle rather
  than collision, domain exit, or wake collapse.
- The sampled rate guard (`solver_435f3fac7d39`) is materially better than its
  response-aware parent (`solver_bf9554cfba28`): capture advances from
  `19.1620T` to `18.7550T`, distance integral falls from `2.06924L` to
  `2.04031L`, and the `10/8/6/4/2/1L` milestones all advance by
  `0.138/0.242/0.231/0.324/0.396/0.407T`. Mean absolute anterior/posterior
  command falls from `18.46/17.56` to `17.87/17.07 rad/T^2`; residence above
  99% of the rate limit falls from `8.35/4.36%` to `8.06/3.28%`. The inherited
  optimizer score log independently identifies that sample as `-0.15214`,
  versus `-0.18047` for the response-aware parent.
- The boundary is visible in the trajectory metrics: the guarded rollout still
  reaches exactly 100% of both joint-rate limits, and the command remains
  outward during about `81.5/75.0%` of anterior/posterior samples above 99% of
  the rate limit. It also lengthens head path from `12.309L` to `12.421L` and
  raises peak planar force/yaw moment from `0.02537/0.01356` to
  `0.02686/0.01397`. This supports improving when the guard intervenes, not
  increasing steering or carrier gains.
- Releasing half-cycle steering after yaw response is not supported:
  `solver_e26b4eb5ad01` shares the prefill's early `10/8/6L` milestones and
  regresses to `19.4040T/2.08115L/-0.19203`. This agrees with the assigned
  parent lesson to avoid another near-target redirect/slip gate on this fixed
  release.

## Candidate mechanism

Start from the sampled response-aware handoff and rate-guarded scaffold. Add a
short, owned response-horizon prediction to the existing normalized joint-rate
proximity signal: for each joint, add only its outward raw acceleration over a
small fraction of the controller period to measured absolute rate, then use
the larger predicted fraction to withdraw outward acceleration smoothly. Keep
the gate shared across the two-joint traveling wave, retain per-joint outward
alignment, and never attenuate reversal acceleration. This is a new
state-feedback allocation mechanism rather than scalar tuning of propulsion or
steering.

Expected result: intervene before the hard clamp, reduce >99%-rate residence
and outward-at-limit events while retaining the best sample's earlier
milestones, capture, coherent wake, and command reduction. Reject it if it
loses capture, delays the `10/8/6L` milestones beyond the response-aware
envelope, fails to improve rate residence, or worsens path, peak load, joint
margin, or wake coherence.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and reactive traveling-bend propulsion
source_mechanism: sensor feedback modulates a low-dimensional rhythmic carrier while posterior lag preserves a propulsive traveling wave
transferable_invariant: preserve the observed traveling bend and use normalized joint-state feedback to withdraw only actuator effort that drives the state farther into its envelope
nontransferable_details: published gains, dimensional frequencies, robot hardware, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: retain the joint-state oscillator, posterior lag, body-frame target scaffold, and response-aware handoff; predict normalized rate proximity from measured rate plus a short outward-acceleration horizon and smoothly attenuate only outward acceleration
falsification: reject if hard-rate residence and outward-at-limit events do not fall while early milestones, capture, short path, load class, joint margin, and coherent top-down/oblique wake are preserved

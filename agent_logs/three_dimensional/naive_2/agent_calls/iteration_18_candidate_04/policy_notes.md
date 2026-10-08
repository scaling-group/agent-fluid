# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=(0,0,0)`, no cylinders, and finite capture. Three are exact
  repeats of the assigned `q1_carrier` policy: they capture at `16.631994T`,
  score `-0.118306881`, and have distance integral `2.001992L`. The older
  raw-`q1` demodulator captures at `16.637493T`, scores `-0.119673807`, and has
  distance integral `2.003406L`. Thus the mean-removed phase compensation is a
  small but exactly reproduced improvement, not a reason to replace the route
  controller.
- In both the best repeated sheet and the weakest finite comparator, the
  top-down sequence grows from quiescent fluid into a regular alternating
  wake that remains attached to the propulsive tail path through capture. The
  oblique row likewise changes from no Lambda2 wake at release to compact,
  alternating tail-connected 3D structures; there is no visible advection,
  body/wake breakup, boundary interaction, or instability. No failed
  multimodal rollout is present in the current sample, so the older finite
  capture is the most informative visual comparator.
- Metrics agree that the fish is self-propelled and still closing strongly at
  capture: final speed is `1.108U` and reconstructed radial closure is about
  `1.108U`. Terminal braking or wave relief therefore addresses neither a
  miss nor a closure loss in these completed rollouts.
- The remaining inefficiency is release-to-cruise buildup. In the repeated
  incumbent the normalized anterior phase-plane radius first reaches `0.4` at
  `1.95T`, `0.8` at `4.11T`, and `1.0` at `4.54T`; distance is still
  `12.013L` and speed only `0.396U` near `4T`, with first passage below `12L`
  at `4.07T`. Later cruise is already fast and coherent. Joint angles remain
  below `0.556 rad`, but velocities touch the `4.538 rad/T` limit and the two
  accelerations spend about `43.8%/58.9%` above 90% of the envelope, so any
  startup mechanism must be bounded and shut off once carrier energy is
  adequate.

## Policy hypothesis

Keep the captured bearing/course/crossflow controller, mean-removed yaw
demodulation, posterior mean bend, phase-selective relief, carrier frequency,
and terminal behavior unchanged. Add a reflection-equivariant phase-plane
energy refill to joint 1: below a conservative fraction of the nominal
`(q1_carrier, q1_dot/omega)` radius, apply a small bounded acceleration in the
direction of joint velocity. The command supplies positive oscillator energy
without selecting a clock phase or a bend side and becomes exactly zero above
the floor. The posterior joint continues to reconstruct its lagged wave from
the resulting observed anterior state.

Expected evidence is earlier attainment of productive carrier radius, earlier
distance decrease, and a lower distance integral while retaining capture and
the connected alternating wake. Falsify the candidate if it loses capture,
changes the successful approach arc materially, creates joint-angle contact,
meaningfully increases velocity/acceleration residence or force/moment peaks,
or causes the refill to remain active through ordinary cruise instead of
serving as a low-energy reserve.

bookshelf_consulted: true
source_domain: robotic-fish central pattern generators and classical traveling-wave propulsion
source_mechanism: phase-independent amplitude convergence for a rhythmic carrier with posterior phase lag
transferable_invariant: regulate oscillation energy separately from phase, preserve a directed posterior-lagged traveling bend, and bound the feedback
nontransferable_details: published oscillator gains, species amplitudes, dimensional frequencies, full-body envelopes, exact wake phases, and task routes
policy_translation: use the normalized body-frame joint phase-plane radius to gate a bounded same-velocity-sign refill on joint 1 while leaving target steering and the joint-2 lagged state feedback intact
falsification: reject if startup progress does not improve, capture or wake coherence is lost, refill persists during normal cruise, or saturation and load envelopes worsen materially

# Candidate diagnosis and hypothesis

## Evidence read before editing

- Every sampled rollout and the assigned parent use direct uniform still-water
  initialization at `U_infinity=(0,0,0)`, with no cylinders or prewarm. The
  visible translation and wakes are therefore self-generated rather than
  advection artifacts.
- `solver_e450df1efa49` makes the closest sampled pass (`4.1281L`) and its two
  image rows show a coherent alternating mid-plane street with organized 3D
  Lambda2 structures. It nevertheless passes above the target and leaves the
  left boundary at `9.1538L`; its raw acceleration requests exceed the physical
  envelope on roughly 73%/70% of rows, so its complex branch and gain stack is
  not a safe carrier.
- The compact bounded controllers preserve the same useful traveling wake.
  `solver_b6bb94d9cdaf` is the strongest finite sample (score `-7.6367`, minimum
  `5.3570L`), but its short-window yaw-rate brake repeatedly changes the bend
  while the route remains wrong and it exits the upper boundary. The inherited
  response-release prefill, `solver_59bc4ebdddec`, also exits above the target
  after only `7.5311L` closest approach. Releasing steering on beat-scale
  bearing motion therefore does not provide persistent course correction.
- The assigned parent's newly evaluated course-vector controller is the most
  important negative result. Its normalized instantaneous body-velocity
  direction alternates strongly while forward speed is still small: the
  reconstructed target-minus-course cross product changes from `+0.15` at
  release to about `-0.61`, `+0.50`, and `-0.71` at `2T`, `4T`, and `6T`.
  Both image rows show an early tight curl, weak downstream wake development,
  and little translation before an upper exit at `9.735T`. It improves only
  from `12.3277L` to `11.4731L` (score `-14.1922`). Commands remain below the
  acceleration envelope and maximum speed is only `0.525`, so this is not a
  clamp or high-speed failure: normalizing beat-scale lateral velocity into a
  unit course direction made a fast oscillatory signal own the slow route.
- The naive champion sign test reaches `6.1797L` before a lower exit, while
  its 3D curvature-sign correction reaches `4.1281L` before the opposite
  topology. Together with the compact samples, this supports retaining the
  traveling-bend scaffold and a bearing-signed mean bend, but not another
  instantaneous response-rate or course-direction loop.

## Policy hypothesis

Use one gait-preserving steering mechanism: compute the complete signed
line-of-sight angle from the normalized body-frame target vector and map it to
the sampled distributed mean-curvature actuator. Schedule only its authority,
not its sign, from bounded forward body speed. Low authority at release lets
the joint-state oscillator establish its propulsive traveling wave; authority
then rises smoothly and remains owned by target geometry. Using `atan(target
lateral, target forward)` preserves the fore/aft target distinction that the
adapter's folded bearing loses after a pass.

Expected result: compared with the response-release prefill and the failed
course-vector parent, the fish should retain an organized alternating wake,
avoid the early curl, and apply persistent correction before reaching the
upper boundary. A useful result is a smaller closest distance or a better
termination class without greater acceleration/speed-limit residence. Falsify
the mechanism if it still curls before forward speed develops, repeats the
upper exit without contracting line-of-sight error, loses wake coherence, or
raises actuator/load saturation.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and classical fish mean-curvature turning
source_mechanism: preserve a propulsive rhythm while a bounded body-relative direction error modulates a slower average bend
transferable_invariant: keep joint-state rhythm generation separate from normalized target steering, and gate strong steering until the propulsive carrier has observable authority
nontransferable_details: published gains, dimensional cadence, species envelopes, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: use the full normalized body-frame target angle to sign a bounded two-joint mean bend, with smooth authority from forward body speed and no normalized instantaneous course or short-window rate term
falsification: reject if the early curl or upper-boundary topology persists, closest approach does not improve, the alternating wake collapses, or joint and load histories worsen
